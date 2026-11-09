import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trip_coordination/presentation/widgets/trip_task_tile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripTasksPage extends StatefulWidget {
  final int tripId;

  const TripTasksPage({super.key, required this.tripId});

  @override
  State<TripTasksPage> createState() => _TripTasksPageState();
}

class _TripTasksPageState extends State<TripTasksPage> {
  final SupabaseClient _client = Supabase.instance.client;
  Map<String, dynamic>? _data;
  bool _loading = true;
  bool _busy = false;

  String get _userId => _client.auth.currentUser?.id ?? '';
  bool get _isLeader => _data?['is_leader'] == true;
  bool get _membershipClosed => _data?['membership_closed'] == true;

  List<Map<String, dynamic>> get _members =>
      (_data?['members'] as List? ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();

  List<Map<String, dynamic>> get _tasks =>
      (_data?['tasks'] as List? ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (mounted) setState(() => _loading = true);
    try {
      final response = await _client.rpc(
        'get_trip_task_context',
        params: {'p_trip_id': widget.tripId},
      );
      if (!mounted) return;
      setState(() => _data = Map<String, dynamic>.from(response as Map));
    } catch (error) {
      if (!mounted) return;
      _message(_friendlyError(error), false);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _friendlyError(Object error) {
    final raw = error.toString().toLowerCase();
    if (raw.contains('membership_closed')) {
      return 'عضوگیری بسته شده است.';
    }
    if (raw.contains('membership_not_closed')) {
      return 'برای مدیریت وظایف ابتدا عضوگیری را ببندید.';
    }
    if (raw.contains('task_already_completed')) {
      return 'وظیفه انجام شده و دیگر قابل تغییر نیست.';
    }
    if (raw.contains('leader_only')) {
      return 'فقط لیدر سفر می‌تواند این عملیات را انجام دهد.';
    }
    if (raw.contains('trip_not_found_or_forbidden')) {
      return 'به اطلاعات وظایف این سفر دسترسی ندارید.';
    }
    if (raw.contains('task_assignee_not_active')) {
      return 'مسئول انتخاب‌شده دیگر عضو فعال سفر نیست.';
    }
    return 'عملیات وظیفه انجام نشد. دوباره تلاش کنید.';
  }

  void _message(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : null,
      ),
    );
  }

  String _memberName(Map<String, dynamic> member) {
    final name = '${member['first_name'] ?? ''} ${member['last_name'] ?? ''}'
        .trim();
    return name.isEmpty ? (member['username'] as String? ?? 'عضو سفر') : name;
  }

  int? _parseMemberId(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  Future<void> _openTaskSheet({Map<String, dynamic>? task}) async {
    if (!_isLeader || !_membershipClosed || _busy) return;
    if (_members.isEmpty) {
      _message('برای تخصیص وظیفه، عضو پذیرفته‌شده‌ای وجود ندارد.', false);
      return;
    }

    final initialTripMemberId = _parseMemberId(
      task?['trip_member_id'] ?? _members.first['trip_member_id'],
    );

    final draft = await showModalBottomSheet<_TaskDraft>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _TripTaskFormSheet(
        members: _members,
        initialTitle: task?['task'] as String? ?? '',
        initialTripMemberId: initialTripMemberId,
        isEditing: task != null,
      ),
    );
    if (!mounted || draft == null) return;

    setState(() => _busy = true);
    try {
      if (task == null) {
        await _client.from('trip_member_tasks').insert({
          'trip_member_id': draft.tripMemberId,
          'task': draft.title,
        });
      } else {
        await _client
            .from('trip_member_tasks')
            .update({'trip_member_id': draft.tripMemberId, 'task': draft.title})
            .eq('id', task['id']);
      }
      await _load();
      if (mounted) {
        _message(task == null ? 'وظیفه اضافه شد.' : 'وظیفه ویرایش شد.', true);
      }
    } catch (error) {
      if (mounted) _message(_friendlyError(error), false);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _deleteTask(Map<String, dynamic> task) async {
    if (!_isLeader || !_membershipClosed || task['is_done'] == true || _busy) {
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف وظیفه'),
        content: Text('وظیفه «${task['task']}» حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('انصراف'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;

    setState(() => _busy = true);
    try {
      await _client.from('trip_member_tasks').delete().eq('id', task['id']);
      await _load();
      if (mounted) _message('وظیفه حذف شد.', true);
    } catch (error) {
      if (mounted) _message(_friendlyError(error), false);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _completeTask(Map<String, dynamic> task) async {
    if (!_membershipClosed ||
        task['is_done'] == true ||
        task['user_id'] != _userId ||
        _busy) {
      return;
    }

    setState(() => _busy = true);
    try {
      await _client
          .from('trip_member_tasks')
          .update({'is_done': true})
          .eq('id', task['id']);
      await _load();
      if (mounted) _message('وظیفه به‌عنوان انجام‌شده ثبت شد.', true);
    } catch (error) {
      if (mounted) _message(_friendlyError(error), false);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _tasks;
    final completed = tasks.where((task) => task['is_done'] == true).length;

    return Scaffold(
      floatingActionButton: _isLeader && _membershipClosed
          ? FloatingActionButton.extended(
              onPressed: _busy ? null : () => _openTaskSheet(),
              icon: const Icon(Icons.add),
              label: const Text('افزودن وظیفه'),
            )
          : null,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            children: [
              const HsAppBar(title: 'وظایف سفر', hasBack: true),
              SizedBox(height: 16.h),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.all(36),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_data == null)
                const HsNote(note: 'اطلاعات وظایف این سفر در دسترس نیست.')
              else ...[
                if (!_membershipClosed)
                  const HsNote(
                    note:
                        'وظایف پس از بسته شدن عضوگیری فعال می‌شوند. در حال حاضر فقط می‌توانید وضعیت وظایف ثبت‌شده را مشاهده کنید.',
                  )
                else
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(14.w),
                      child: Row(
                        children: [
                          const Icon(Icons.checklist_rounded),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              'وضعیت وظایف: $completed از ${tasks.length} انجام شده',
                            ),
                          ),
                          if (_isLeader) const Chip(label: Text('مدیریت لیدر')),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 12.h),
                if (tasks.isEmpty)
                  HsNote(
                    note: _membershipClosed
                        ? 'هنوز وظیفه‌ای برای این سفر ثبت نشده است.'
                        : 'هنوز وظیفه‌ای ثبت نشده است. بعد از بسته شدن عضوگیری، لیدر می‌تواند وظایف را تقسیم کند.',
                  )
                else
                  ...tasks.map((task) {
                    final isDone = task['is_done'] == true;
                    final isMine = task['user_id'] == _userId;
                    final canManage = _isLeader && _membershipClosed && !isDone;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: TripTaskTile(
                        task: task['task'] as String? ?? '',
                        isDone: isDone,
                        name: _memberName(task),
                        onDone: _membershipClosed && isMine && !isDone && !_busy
                            ? (_) => _completeTask(task)
                            : null,
                        onEdit: canManage && !_busy
                            ? () => _openTaskSheet(task: task)
                            : null,
                        onDelete: canManage && !_busy
                            ? () => _deleteTask(task)
                            : null,
                      ),
                    );
                  }),
                SizedBox(height: 80.h),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskDraft {
  const _TaskDraft({required this.title, required this.tripMemberId});

  final String title;
  final int tripMemberId;
}

/// Owns the text controller for the lifetime of the bottom-sheet route.
///
/// The route can remain mounted briefly after showModalBottomSheet completes
/// its result future, while the reverse transition is still running. Keeping
/// the controller here prevents disposing it while TextField is still mounted.
class _TripTaskFormSheet extends StatefulWidget {
  const _TripTaskFormSheet({
    required this.members,
    required this.initialTitle,
    required this.initialTripMemberId,
    required this.isEditing,
  });

  final List<Map<String, dynamic>> members;
  final String initialTitle;
  final int? initialTripMemberId;
  final bool isEditing;

  @override
  State<_TripTaskFormSheet> createState() => _TripTaskFormSheetState();
}

class _TripTaskFormSheetState extends State<_TripTaskFormSheet> {
  late final TextEditingController _titleController;
  int? _selectedTripMemberId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);

    final availableIds = widget.members
        .map((member) => _parseMemberId(member['trip_member_id']))
        .whereType<int>()
        .toSet();

    if (availableIds.contains(widget.initialTripMemberId)) {
      _selectedTripMemberId = widget.initialTripMemberId;
    } else if (availableIds.isNotEmpty) {
      _selectedTripMemberId = availableIds.first;
    }
  }

  int? _parseMemberId(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  String _memberName(Map<String, dynamic> member) {
    final name = '${member['first_name'] ?? ''} ${member['last_name'] ?? ''}'
        .trim();
    return name.isEmpty ? (member['username'] as String? ?? 'عضو سفر') : name;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final members = widget.members
        .map((member) {
          final id = _parseMemberId(member['trip_member_id']);
          if (id == null) return null;
          return DropdownMenuItem<int>(
            value: id,
            child: Text(_memberName(member)),
          );
        })
        .whereType<DropdownMenuItem<int>>()
        .toList();

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isEditing ? 'ویرایش وظیفه' : 'ایجاد وظیفه',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _titleController,
                autofocus: true,
                maxLength: 120,
                decoration: const InputDecoration(
                  labelText: 'عنوان وظیفه',
                  hintText: 'مثلاً رزرو اقامتگاه',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<int>(
                initialValue: _selectedTripMemberId,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'مسئول انجام وظیفه',
                  border: OutlineInputBorder(),
                ),
                items: members,
                onChanged: (value) {
                  setState(() => _selectedTripMemberId = value);
                },
              ),
              SizedBox(height: 18.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    final title = _titleController.text.trim();
                    final memberId = _selectedTripMemberId;
                    if (title.isEmpty || memberId == null) return;

                    Navigator.of(
                      context,
                    ).pop(_TaskDraft(title: title, tripMemberId: memberId));
                  },
                  child: Text(
                    widget.isEditing ? 'ذخیره تغییرات' : 'افزودن وظیفه',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
