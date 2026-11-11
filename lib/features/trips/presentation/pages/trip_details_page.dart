import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_icon_label.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friends_usecase.dart';
import 'package:hamsafar/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:hamsafar/features/trips/presentation/bloc/trips_state.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hamsafar/core/localization/app_translations.dart';

class TripDetailsPage extends StatefulWidget {
  final int? tripId;
  final GetFriendsUsecase getFriendsUsecase;

  const TripDetailsPage({
    super.key,
    this.tripId,
    required this.getFriendsUsecase,
  });

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  @override
  void initState() {
    super.initState();
    if (widget.tripId != null) {
      context.read<TripsBloc>().add(TripDetailsLoadRequested(widget.tripId!));
    } else {
      _loadCurrentTrip();
    }
  }

  void _loadCurrentTrip() {
    context.read<TripsBloc>().add(const CurrentTripDetailsLoadRequested());
  }

  String _date(DateTime value) =>
      '${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}';

  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  Future<void> _edit(TripEntity trip) async {
    final router = GoRouter.of(context);
    final tripsBloc = context.read<TripsBloc>();
    final result = await router.push<int>('/trip-create', extra: trip);
    if (!mounted || result == null) return;
    tripsBloc.add(TripDetailsLoadRequested(trip.id));
  }

  Future<void> _invite(TripEntity trip) async {
    final friendsResult = await widget.getFriendsUsecase(NoParams());
    if (!mounted) return;

    if (friendsResult is! DataSuccess<List<FriendEntity>>) {
      context.showHsSnackBar(
        text: friendsResult.message ?? 'دریافت فهرست دوستان ناموفق بود.',
        hsSnackBarType: HsSnackBarType.error,
      );
      return;
    }

    final friends = friendsResult.data ?? const <FriendEntity>[];
    if (friends.isEmpty) {
      context.showHsSnackBar(
        text: 'دوستی برای دعوت وجود ندارد.',
        hsSnackBarType: HsSnackBarType.warning,
      );
      return;
    }

    final selected = <String>{};
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const txt('دعوت دوستان به سفر'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: friends
                  .map(
                    (friend) => CheckboxListTile(
                      value: selected.contains(friend.id),
                      title: txt(
                        '${friend.firstName} ${friend.lastName}'.trim().isEmpty
                            ? friend.userName
                            : '${friend.firstName} ${friend.lastName}'.trim(),
                      ),
                      subtitle: txt('@${friend.userName}'),
                      onChanged: (value) => setDialogState(() {
                        if (value == true) {
                          selected.add(friend.id);
                        } else {
                          selected.remove(friend.id);
                        }
                      }),
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const txt('انصراف'),
            ),
            FilledButton(
              onPressed: selected.isEmpty
                  ? null
                  : () => Navigator.pop(dialogContext, true),
              child: const txt('ارسال دعوت'),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !mounted) return;

    context.read<TripsBloc>().add(
      TripUsersInviteRequested(trip.id, selected.toList()),
    );
  }

  Future<void> _delete(TripEntity trip) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const txt('حذف سفر'),
        content: txt('سفر «${trip.name}» و اطلاعات وابسته به آن حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const txt('انصراف'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const txt('حذف سفر'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    context.read<TripsBloc>().add(TripDeletionRequested(trip.id));
  }

  void _toggleMembership(TripEntity trip) {
    context.read<TripsBloc>().add(
      TripMembershipClosureChanged(trip.id, !trip.membershipClosed),
    );
  }

  void _startTrip(TripEntity trip) {
    context.read<TripsBloc>().add(TripStartRequested(trip.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripsBloc, TripsState>(
      listener: (context, state) {
        final result = state.lastActionResult;
        if (result == null) return;

        if (result.type == TripActionType.deleted && result.succeeded) {
          context.pop();
          return;
        }

        final successMessage = switch (result.type) {
          TripActionType.joined => 'به سفر پیوستید.',
          TripActionType.invitationResponded => 'وضعیت دعوت به‌روزرسانی شد.',
          TripActionType.left => 'از سفر خارج شدید.',
          TripActionType.invited => 'دعوت‌ها ارسال شدند.',
          TripActionType.memberRemoved => 'عضو از سفر حذف شد.',
          TripActionType.membershipChanged =>
            state.selectedTrip?.membershipClosed == true
                ? 'عضوگیری سفر بسته شد.'
                : 'عضوگیری سفر دوباره باز شد.',
          TripActionType.started => 'وضعیت سفر به «درحال سفر» تغییر کرد.',
          TripActionType.deleted => 'سفر حذف شد.',
        };
        context.showHsSnackBar(
          text: result.succeeded
              ? successMessage
              : state.errorMessage ?? 'عملیات سفر انجام نشد.',
          hsSnackBarType:
              result.succeeded ? HsSnackBarType.success : HsSnackBarType.error,
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<TripsBloc, TripsState>(
          builder: (context, state) {
            final trip = state.selectedTrip;
            if (state.isLoadingDetails && trip == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (trip == null) {
              return Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HsAppBar(title: 'جزئیات سفر', hasBack: true),
                    const Spacer(),
                    Center(
                      child: txt(
                        state.errorMessage ?? 'اطلاعات سفر در دسترس نیست.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: _loadCurrentTrip,
                        child: const txt('تلاش دوباره'),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HsAppBar(
                    title: 'جزئیات سفر',
                    hasBack: true,
                    leading: trip.isCreator
                        ? IconButton(
                            tooltip: AppTranslations.translate(
                              context,
                              'ویرایش سفر',
                            ),
                            onPressed: () => _edit(trip),
                            icon: const Icon(Icons.edit_outlined),
                          )
                        : null,
                  ),
                  SizedBox(height: 20.h),
                  txt(trip.name, style: context.textTheme.headlineMedium),
                  SizedBox(height: 8.h),
                  HsIconLabel(label: trip.location, icon: LucideIcons.mapPin),
                  if (!trip.canJoin && !trip.isCreator) ...[
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20.sp,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: txt(
                              'شما در حال حاضر عضو سفر دیگری هستید. برای عضویت در این سفر، ابتدا باید از سفر فعلی خود خارج شوید.',
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if ((trip.description ?? '').isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    txt(trip.description!),
                  ],
                  SizedBox(height: 20.h),
                  _InfoRow(
                    label: 'وضعیت',
                    value: switch (trip.status) {
                      'active' => 'درحال سفر',
                      'completed' => 'پایان‌یافته',
                      'cancelled' => 'لغوشده',
                      _ => 'درحال آماده‌سازی',
                    },
                  ),
                  if (trip.isCreator && trip.isPreparing) ...[
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: state.isUpdatingMembership
                            ? null
                            : () => _toggleMembership(trip),
                        icon: state.isUpdatingMembership
                            ? SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                trip.membershipClosed
                                    ? Icons.lock_open_rounded
                                    : Icons.lock_outline_rounded,
                              ),
                        label: txt(
                          state.isUpdatingMembership
                              ? 'در حال تغییر وضعیت...'
                              : trip.membershipClosed
                              ? 'باز کردن عضوگیری'
                              : 'بستن عضوگیری',
                        ),
                      ),
                    ),
                  ],
                  if (trip.isCreator && trip.status == 'preparing') ...[
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: state.isUpdatingStatus
                            ? null
                            : () => _startTrip(trip),
                        icon: state.isUpdatingStatus
                            ? SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.play_arrow_rounded),
                        label: txt(
                          state.isUpdatingStatus
                              ? 'در حال شروع سفر...'
                              : 'شروع سفر',
                        ),
                      ),
                    ),
                  ],
                  _InfoRow(label: 'لیدر سفر', value: trip.leaderName),
                  _InfoRow(
                    label: 'تاریخ رفت',
                    value:
                        '${_date(trip.departureAt)} - ${_time(trip.departureAt)}',
                  ),
                  _InfoRow(
                    label: 'تاریخ برگشت',
                    value: '${_date(trip.returnAt)} - ${_time(trip.returnAt)}',
                  ),
                  _InfoRow(label: 'بودجه', value: '${trip.budget} تومان'),
                  if ((trip.meetingPoint ?? '').isNotEmpty)
                    _InfoRow(label: 'محل تجمع', value: trip.meetingPoint!),
                  _InfoRow(
                    label: 'زمان‌بندی',
                    value: trip.scheduleType == 'fixed'
                        ? 'قطعی'
                        : 'رأی‌گیری اعضا',
                  ),
                  SizedBox(height: 20.h),
                  if (trip.costItems.isNotEmpty) ...[
                    txt('آیتم‌های هزینه', style: context.textTheme.titleMedium),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: trip.costItems
                          .map((item) => Chip(label: txt(item)))
                          .toList(),
                    ),
                    SizedBox(height: 20.h),
                  ],
                  txt('قوانین سفر', style: context.textTheme.titleMedium),
                  SizedBox(height: 10.h),
                  if (trip.rules.isEmpty)
                    txt(
                      'قانونی برای این سفر ثبت نشده است.',
                      color: context.colorScheme.onSurfaceVariant,
                    )
                  else
                    ...trip.rules.map(
                      (rule) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              LucideIcons.shieldCheck,
                              size: 18.sp,
                              color: context.colorScheme.primary,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(child: txt(rule)),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 20.h),
                  txt(
                    'اعضا (${trip.memberCount})',
                    style: context.textTheme.titleMedium,
                  ),
                  SizedBox(height: 10.h),
                  ...trip.members
                      .where((m) => m['member_status'] == 'accepted')
                      .map((member) {
                        final first = member['first_name'] as String? ?? '';
                        final last = member['last_name'] as String? ?? '';
                        final username = member['username'] as String? ?? '';
                        final userId = member['id'] as String? ?? '';
                        final displayName = '$first $last'.trim();
                        final isLeader = member['member_type'] == 'leader';
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            child: txt(
                              displayName.isEmpty ? '؟' : displayName[0],
                            ),
                          ),
                          title: txt(
                            displayName.isEmpty ? username : displayName,
                          ),
                          subtitle: txt(
                            isLeader ? 'لیدر سفر' : 'عضو پذیرفته‌شده',
                          ),
                          trailing:
                              trip.isCreator &&
                                  !trip.membershipClosed &&
                                  !isLeader
                              ? IconButton(
                                  tooltip: AppTranslations.translate(
                                    context,
                                    'اخراج عضو',
                                  ),
                                  icon: const Icon(
                                    Icons.person_remove_alt_1_outlined,
                                  ),
                                  onPressed: () async {
                                    final tripsBloc = context
                                        .read<TripsBloc>();
                                    final yes = await showDialog<bool>(
                                      context: context,
                                      builder: (d) => AlertDialog(
                                        title: const txt('اخراج عضو'),
                                        content: txt(
                                          'آیا ${displayName.isEmpty ? username : displayName} از سفر اخراج شود؟',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(d, false),
                                            child: const txt('انصراف'),
                                          ),
                                          FilledButton(
                                            onPressed: () =>
                                                Navigator.pop(d, true),
                                            child: const txt('اخراج'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (!mounted || yes != true) return;
                                    tripsBloc.add(TripMemberRemovalRequested(trip.id, userId));
                                  },
                                )
                              : null,
                        );
                      }),
                  if (trip.isCreator) ...[
                    SizedBox(height: 8.h),
                    txt(
                      'دعوت‌های در انتظار',
                      style: context.textTheme.titleSmall,
                    ),
                    ...trip.members
                        .where((m) => m['member_status'] == 'pending')
                        .map((member) {
                          final first = member['first_name'] as String? ?? '';
                          final last = member['last_name'] as String? ?? '';
                          final userId = member['id'] as String? ?? '';
                          final name = '$first $last'.trim();
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: txt(
                              name.isEmpty
                                  ? (member['username'] as String? ?? '')
                                  : name,
                            ),
                            subtitle: const txt('در انتظار پاسخ'),
                            trailing: trip.membershipClosed
                                ? null
                                : IconButton(
                                    tooltip: AppTranslations.translate(
                                      context,
                                      'لغو دعوت',
                                    ),
                                    icon: const Icon(Icons.close),
                                    onPressed: () => context
                                        .read<TripsBloc>()
                                        .add(TripMemberRemovalRequested(trip.id, userId)),
                                  ),
                          );
                        }),
                    OutlinedButton.icon(
                      onPressed: trip.membershipClosed
                          ? null
                          : () => _invite(trip),
                      icon: const Icon(Icons.person_add_alt_1),
                      label: const txt('دعوت دوستان'),
                    ),
                  ] else if (trip.currentMemberStatus == 'pending') ...[
                    SizedBox(height: 12.h),
                    const txt('برای پیوستن به این سفر دعوت شده‌اید.'),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: trip.membershipClosed
                                ? null
                                : () => context
                                      .read<TripsBloc>()
                                      .add(TripInvitationResponseRequested(trip.id, accept: true)),
                            child: const txt('پذیرفتن دعوت'),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context
                                .read<TripsBloc>()
                                .add(TripInvitationResponseRequested(trip.id, accept: false)),
                            child: const txt('رد دعوت'),
                          ),
                        ),
                      ],
                    ),
                  ] else if (trip.currentMemberStatus == 'accepted' &&
                      !trip.isCreator &&
                      !trip.membershipClosed) ...[
                    SizedBox(height: 12.h),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final tripsBloc = context.read<TripsBloc>();
                        final yes = await showDialog<bool>(
                          context: context,
                          builder: (d) => AlertDialog(
                            title: const txt('خروج از سفر'),
                            content: const txt(
                              'از عضویت در این سفر خارج می‌شوید؟',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(d, false),
                                child: const txt('انصراف'),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.pop(d, true),
                                child: const txt('خروج'),
                              ),
                            ],
                          ),
                        );
                        if (!mounted || yes != true) return;
                        tripsBloc.add(TripLeaveRequested(trip.id));
                      },
                      icon: const Icon(Icons.logout),
                      label: const txt('خروج از سفر'),
                    ),
                  ] else if (!trip.isCreator &&
                      !trip.membershipClosed &&
                      trip.isPreparing &&
                      (trip.currentMemberStatus == null ||
                          [
                            'left',
                            'rejected',
                          ].contains(trip.currentMemberStatus))) ...[
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () =>
                            context.read<TripsBloc>().add(TripJoinRequested(trip.id)),
                        icon: const Icon(Icons.group_add_outlined),
                        label: const txt('پیوستن به سفر'),
                      ),
                    ),
                  ],
                  if (trip.isCreator ||
                      trip.currentMemberStatus == 'accepted') ...[
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            context.push('/trip-tasks', extra: trip.id),
                        icon: const Icon(Icons.checklist_rounded),
                        label: const txt('مشاهده وظایف سفر'),
                      ),
                    ),
                  ],
                  if (trip.isCreator) ...[
                    SizedBox(height: 20.h),
                    HsButton(
                      onTap: () => _edit(trip),
                      child: txt(
                        'ویرایش سفر',
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: state.isDeleting
                            ? null
                            : () => _delete(trip),
                        icon: const Icon(Icons.delete_outline),
                        label: txt(
                          state.isDeleting ? 'در حال حذف...' : 'حذف سفر',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                  if (state.errorMessage != null) ...[
                    SizedBox(height: 10.h),
                    txt(state.errorMessage!, color: context.colorScheme.error),
                  ],
                  SizedBox(height: 32.h),
                ],
              ),
            );
          },
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105.w,
            child: txt(
              label,
              color: context.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(child: txt(value, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
