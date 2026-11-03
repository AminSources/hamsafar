import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_icon_label.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripDetailsPage extends StatefulWidget {
  final int? tripId;

  const TripDetailsPage({super.key, this.tripId});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  @override
  void initState() {
    super.initState();
    if (widget.tripId != null) {
      context.read<TripsCubit>().loadTripDetails(widget.tripId!);
    } else {
      _loadCurrentTrip();
    }
  }

  Future<void> _loadCurrentTrip() async {
    final cubit = context.read<TripsCubit>();
    await cubit.loadMyTrips();
    if (!mounted || cubit.state.myTrips.isEmpty) return;
    await cubit.loadTripDetails(cubit.state.myTrips.first.id);
  }

  String _date(DateTime value) =>
      '${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}';

  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  Future<void> _edit(TripEntity trip) async {
    await context.push('/trip-create', extra: trip);
    if (mounted) {
      context.read<TripsCubit>().loadTripDetails(trip.id);
    }
  }

  Future<void> _delete(TripEntity trip) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف سفر'),
        content: Text('سفر «${trip.name}» و اطلاعات وابسته به آن حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('انصراف'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('حذف سفر'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    final deleted = await context.read<TripsCubit>().deleteTrip(trip.id);
    if (!mounted) return;
    if (deleted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TripsCubit, TripsState>(
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
                        child: const Text('تلاش دوباره'),
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
                            tooltip: 'ویرایش سفر',
                            onPressed: () => _edit(trip),
                            icon: const Icon(Icons.edit_outlined),
                          )
                        : null,
                  ),
                  SizedBox(height: 20.h),
                  txt(trip.name, style: context.textTheme.headlineMedium),
                  SizedBox(height: 8.h),
                  HsIconLabel(label: trip.location, icon: LucideIcons.mapPin),
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
                          .map((item) => Chip(label: Text(item)))
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
                  if (trip.members.isEmpty)
                    txt(
                      trip.isCreator || trip.isMember
                          ? 'هنوز عضوی در این سفر پذیرفته نشده است.'
                          : 'فهرست اعضا فقط برای اعضای سفر قابل مشاهده است.',
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ...trip.members
                      .where((member) => member['member_status'] == 'accepted')
                      .map((member) {
                        final firstName = member['first_name'] as String? ?? '';
                        final lastName = member['last_name'] as String? ?? '';
                        final username = member['username'] as String? ?? '';
                        final memberName = '$firstName $lastName'.trim();
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            child: Text(
                              memberName.isEmpty ? '؟' : memberName[0],
                            ),
                          ),
                          title: Text(
                            memberName.isEmpty ? username : memberName,
                          ),
                          subtitle: Text(
                            member['member_type'] == 'leader' ? 'لیدر' : 'عضو',
                          ),
                        );
                      }),
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
                        label: Text(
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
