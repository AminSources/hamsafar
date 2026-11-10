import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/auth/domain/entities/user_entity.dart';
import 'package:hamsafar/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trip_coordination/presentation/widgets/trip_task_tile.dart';
import 'package:hamsafar/features/trip_coordination/domain/usecases/trip_coordination_usecases.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';

import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/localization/app_translations.dart';
class TripTasksPage extends StatefulWidget {
  final int tripId;

  final GetTripTaskContextUseCase getTripTaskContextUseCase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final SaveTripTaskUseCase saveTripTaskUseCase;
  final DeleteTripTaskUseCase deleteTripTaskUseCase;
  final CompleteTripTaskUseCase completeTripTaskUseCase;

  const TripTasksPage({
    super.key,
    required this.tripId,
    required this.getTripTaskContextUseCase,
    required this.getCurrentUserUsecase,
    required this.saveTripTaskUseCase,
    required this.deleteTripTaskUseCase,
    required this.completeTripTaskUseCase,
  });

  @override
  State<TripTasksPage> createState() => _TripTasksPageState();
}

class _TripTasksPageState extends State<TripTasksPage> {
  TripTaskContextEntity? _data;
  bool _loading = true;
  bool _busy = false;
  String? _currentUserId;

  String get _userId => _currentUserId ?? '';
  bool get _isLeader => _data?.isLeader == true;
  bool get _membershipClosed => _data?.membershipClosed == true;

  List<TripTaskMemberEntity> get _members =>
      _data?.members ?? const <TripTaskMemberEntity>[];

  List<TripTaskEntity> get _tasks =>
      _data?.tasks ?? const <TripTaskEntity>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (mounted) setState(() => _loading = true);
    try {
      if (_currentUserId == null) {
        final authResult =
            await widget.getCurrentUserUsecase(const NoParams());
        if (!mounted) return;

        if (authResult is! DataSuccess<UserEntity?> ||
            authResult.data == null) {
          _message(
            authResult.message ?? 'ابتدا وارد حساب کاربری شوید.',
            false,
          );
          setState(() => _data = null);
          return;
        }

        _currentUserId = authResult.data!.id;
      }

      final response = await widget.getTripTaskContextUseCase(widget.tripId);
      if (!mounted) return;
      setState(() => _data = response);
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
        content: txt(message),
        backgroundColor: success ? Colors.green : null,
      ),
    );
  }

  String _memberName(TripTaskEntity task) => task.memberDisplayName;

  Future<void> _openTaskSheet({TripTaskEntity? task}) async {
    if (!_isLeader || !_membershipClosed || _busy) return;
    if (_members.isEmpty) {
      _message('برای تخصیص وظیفه، عضو پذیرفته‌شده‌ای وجود ندارد.', false);
      return;
    }

    final initialTripMemberId =
        task?.tripMemberId ?? _members.first.tripMemberId;

    final draft = await showModalBottomSheet<_TaskDraft>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _TripTaskFormSheet(
        members: _members,
        initialTitle: task?.title ?? '',
        initialTripMemberId: initialTripMemberId,
        isEditing: task != null,
      ),
    );
    if (!mounted || draft == null) return;

    setState(() => _busy = true);
    try {
      if (task == null) {
        await widget.saveTripTaskUseCase(
          tripMemberId: draft.tripMemberId,
          title: draft.title,
        );
      } else {
        await widget.saveTripTaskUseCase(
          taskId: task.id,
          tripMemberId: draft.tripMemberId,
          title: draft.title,
        );
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

  Future<void> _deleteTask(TripTaskEntity task) async {
    if (!_isLeader || !_membershipClosed || task.isDone || _busy) {
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const txt('حذف وظیفه'),
        content: txt('وظیفه «${task.title}» حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const txt('انصراف'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const txt('حذف'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;

    setState(() => _busy = true);
    try {
      await widget.deleteTripTaskUseCase(task.id);
      await _load();
      if (mounted) _message('وظیفه حذف شد.', true);
    } catch (error) {
      if (mounted) _message(_friendlyError(error), false);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _completeTask(TripTaskEntity task) async {
    if (!_membershipClosed ||
        task.isDone ||
        task.userId != _userId ||
        _busy) {
      return;
    }

    setState(() => _busy = true);
    try {
      await widget.completeTripTaskUseCase(task.id);
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
    final completed = tasks.where((task) => task.isDone).length;

    return Scaffold(
      floatingActionButton: _isLeader && _membershipClosed
          ? FloatingActionButton.extended(
              onPressed: _busy ? null : () => _openTaskSheet(),
              icon: const Icon(Icons.add),
              label: const txt('افزودن وظیفه'),
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
                            child: txt(
                              'وضعیت وظایف: $completed از ${tasks.length} انجام شده',
                            ),
                          ),
                          if (_isLeader) const Chip(label: txt('مدیریت لیدر')),
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
                    final isDone = task.isDone;
                    final isMine = task.userId == _userId;
                    final canManage = _isLeader && _membershipClosed && !isDone;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: TripTaskTile(
                        task: task.title as String? ?? '',
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

  final List<TripTaskMemberEntity> members;
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
        .map((member) => member.tripMemberId)
        .toSet();

    if (availableIds.contains(widget.initialTripMemberId)) {
      _selectedTripMemberId = widget.initialTripMemberId;
    } else if (availableIds.isNotEmpty) {
      _selectedTripMemberId = availableIds.first;
    }
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
        .map(
          (member) => DropdownMenuItem<int>(
            value: member.tripMemberId,
            child: txt(member.displayName),
          ),
        )
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
              txt(
                widget.isEditing ? 'ویرایش وظیفه' : 'ایجاد وظیفه',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _titleController,
                autofocus: true,
                maxLength: 120,
                decoration: InputDecoration(
                  labelText: AppTranslations.translate(context, 'عنوان وظیفه'),
                  hintText: AppTranslations.translate(context, 'مثلاً رزرو اقامتگاه'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<int>(
                initialValue: _selectedTripMemberId,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: AppTranslations.translate(context, 'مسئول انجام وظیفه'),
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
                  child: txt(
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
