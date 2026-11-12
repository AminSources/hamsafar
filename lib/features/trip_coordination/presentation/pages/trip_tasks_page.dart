import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/localization/app_translations.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/presentation/bloc/trip_tasks_bloc.dart';
import 'package:hamsafar/features/trip_coordination/presentation/widgets/trip_task_tile.dart';

class TripTasksPage extends StatelessWidget {
  final int tripId;

  const TripTasksPage({super.key, required this.tripId});

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<TripTasksBloc>();
    if (bloc.state.isBusy || bloc.state.isLoading) return;
    bloc.add(TripTasksLoadRequested(tripId));
    await bloc.stream.firstWhere((state) => !state.isLoading);
  }

  Future<void> _openTaskSheet(
    BuildContext context, {
    required TripTaskContextEntity data,
    TripTaskEntity? task,
  }) async {
    if (!data.isLeader || !data.membershipClosed) return;
    if (data.members.isEmpty) {
      context.showHsSnackBar(
        text: 'برای تخصیص وظیفه، عضو پذیرفته‌شده‌ای وجود ندارد.',
        hsSnackBarType: HsSnackBarType.warning,
      );
      return;
    }

    final initialTripMemberId =
        task?.tripMemberId ?? data.members.first.tripMemberId;
    final draft = await showModalBottomSheet<_TaskDraft>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _TripTaskFormSheet(
        members: data.members,
        initialTitle: task?.title ?? '',
        initialTripMemberId: initialTripMemberId,
        isEditing: task != null,
      ),
    );

    if (!context.mounted || draft == null) return;
    context.read<TripTasksBloc>().add(
      TripTaskSaveRequested(
        tripId: tripId,
        taskId: task?.id,
        tripMemberId: draft.tripMemberId,
        title: draft.title,
      ),
    );
  }

  Future<void> _deleteTask(BuildContext context, TripTaskEntity task) async {
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

    if (!context.mounted || confirmed != true) return;
    context.read<TripTasksBloc>().add(
      TripTaskDeleteRequested(tripId: tripId, taskId: task.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripTasksBloc, TripTasksState>(
      listener: (context, state) {
        final feedback = state.feedback;
        if (feedback == null) return;
        context.showHsSnackBar(
          text: feedback,
          hsSnackBarType: state.feedbackIsSuccess == true
              ? HsSnackBarType.success
              : HsSnackBarType.error,
        );
      },
      builder: (context, state) {
        final data = state.data;
        final tasks = data?.tasks ?? const <TripTaskEntity>[];
        final userId = state.currentUserId ?? '';
        final isLeader = data?.isLeader == true;
        final membershipClosed = data?.membershipClosed == true;
        final completed = tasks.where((task) => task.isDone).length;

        return Scaffold(
          floatingActionButton: isLeader && membershipClosed
              ? FloatingActionButton.extended(
                  onPressed: state.isBusy || data == null
                      ? null
                      : () => _openTaskSheet(context, data: data),
                  icon: const Icon(Icons.add),
                  label: const txt('افزودن وظیفه'),
                )
              : null,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
                children: [
                  const HsAppBar(title: 'وظایف سفر', hasBack: true),
                  SizedBox(height: 16.h),
                  if (state.isLoading && data == null)
                    const Padding(
                      padding: EdgeInsets.all(36),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (data == null)
                    Column(
                      children: [
                        HsNote(
                          note: state.errorMessage ??
                              'اطلاعات وظایف این سفر در دسترس نیست.',
                        ),
                        SizedBox(height: 12.h),
                        FilledButton(
                          onPressed: () => context
                              .read<TripTasksBloc>()
                              .add(TripTasksLoadRequested(tripId)),
                          child: const txt('تلاش مجدد'),
                        ),
                      ],
                    )
                  else ...[
                    if (state.errorMessage != null)
                      HsNote(note: state.errorMessage!),
                    if (!membershipClosed)
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
                              if (isLeader)
                                const Chip(label: txt('مدیریت لیدر')),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 12.h),
                    if (tasks.isEmpty)
                      HsNote(
                        note: membershipClosed
                            ? 'هنوز وظیفه‌ای برای این سفر ثبت نشده است.'
                            : 'هنوز وظیفه‌ای ثبت نشده است. بعد از بسته شدن عضوگیری، لیدر می‌تواند وظایف را تقسیم کند.',
                      )
                    else
                      ...tasks.map((task) {
                        final isDone = task.isDone;
                        final isMine = task.userId == userId;
                        final canManage =
                            isLeader && membershipClosed && !isDone;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: TripTaskTile(
                            task: task.title,
                            isDone: isDone,
                            name: task.memberDisplayName,
                            onDone: membershipClosed &&
                                    isMine &&
                                    !isDone &&
                                    !state.isBusy
                                ? (_) => context
                                    .read<TripTasksBloc>()
                                    .add(TripTaskCompletionRequested(
                                      tripId: tripId,
                                      taskId: task.id,
                                    ))
                                : null,
                            onEdit: canManage && !state.isBusy
                                ? () => _openTaskSheet(
                                      context,
                                      data: data,
                                      task: task,
                                    )
                                : null,
                            onDelete: canManage && !state.isBusy
                                ? () => _deleteTask(context, task)
                                : null,
                          ),
                        );
                      }),
                    if (state.isBusy)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(child: LinearProgressIndicator()),
                      ),
                    SizedBox(height: 80.h),
                  ],
                ],
              ),
            ),
          ),
        );
      },
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
                  hintText: AppTranslations.translate(
                    context,
                    'مثلاً رزرو اقامتگاه',
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<int>(
                initialValue: _selectedTripMemberId,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: AppTranslations.translate(
                    context,
                    'مسئول انجام وظیفه',
                  ),
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
