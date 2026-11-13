import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_info_box.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home/domain/entities/home_trip_entity.dart';
import 'package:hamsafar/features/home/presentation/widgets/home_avatar_stack.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeTripCard extends StatelessWidget {
  final HomeTripEntity trip;
  final bool isInTrip;

  const HomeTripCard({super.key, required this.trip, required this.isInTrip});

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(String? time) {
    return time?.isNotEmpty == true ? time! : '—';
  }

  @override
  Widget build(BuildContext context) {
    final tripId = int.tryParse(trip.id);

    return HsContainer(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      color: context.colorScheme.surface,
      radius: 20.r,
      onTap: tripId == null
          ? null
          : () => context.push('/trip-detail', extra: tripId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HsBadge(
                label: isInTrip ? '🚗 در حال سفر' : 'در حال آماده‌سازی',
                backgroundColor: context.colorScheme.surfaceContainerHigh,
                foregroundColor: context.colorScheme.onSurface,
              ),
              HsBadge(
                label: 'شروع ${_formatDate(trip.departureDate)}',
                backgroundColor: context.colorScheme.secondary,
                foregroundColor: context.colorScheme.onSecondary,
              ),
            ],
          ),
          SizedBox(height: 14.h),
          txt(trip.title, style: context.textTheme.headlineSmall),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                LucideIcons.mapPin,
                size: 15.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: txt(
                  trip.location.isEmpty ? 'مقصد مشخص نشده' : trip.location,
                  style: context.textTheme.bodySmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          HsInfoBox(
            labels: isInTrip
                ? const ['تاریخ رفت', 'زمان برگشت', 'اعضا']
                : const ['تاریخ رفت', 'زمان حرکت', 'اعضا'],
            values: [
              _formatDate(trip.departureDate),
              _formatTime(isInTrip ? trip.returnTime : trip.departureTime),
              '${trip.members.length} نفر',
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.white24, height: 1),
          SizedBox(height: 14.h),
          HomeAvatarStack(members: trip.members),
        ],
      ),
    );
  }
}
