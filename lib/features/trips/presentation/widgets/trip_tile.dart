import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_icon_label.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripTile extends StatelessWidget {
  final TripEntity trip;
  final VoidCallback? onTap;

  const TripTile({super.key, required this.trip, this.onTap});

  String _statusLabel(String status) => switch (status) {
        'active' => 'درحال سفر',
        'completed' => 'پایان‌یافته',
        'cancelled' => 'لغوشده',
        _ => 'درحال آماده‌سازی',
      };

  HsBadgeType _statusType(String status) => switch (status) {
        'active' => HsBadgeType.success,
        'preparing' => HsBadgeType.warning,
        _ => HsBadgeType.none,
      };

  String _date(DateTime value) =>
      '${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}';

  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return HsTile(
      onTap: onTap ?? () => context.push('/trip-detail', extra: trip.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HsBadge(
                label: _statusLabel(trip.status),
                icon: Icons.circle,
                iconSize: 8.sp,
                type: _statusType(trip.status),
              ),
              HsBadge(
                label: '${trip.memberCount} عضو',
                icon: LucideIcons.users,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          txt(trip.name, style: context.textTheme.titleMedium),
          SizedBox(height: 6.h),
          HsIconLabel(
            label: trip.leaderName,
            icon: LucideIcons.crown,
            iconColor: context.colorScheme.secondary,
          ),
          SizedBox(height: 4.h),
          HsIconLabel(
            label: trip.location,
            icon: LucideIcons.mapPin,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HsIconLabel(
                label: _date(trip.departureAt),
                icon: LucideIcons.calendar,
                color: context.colorScheme.onSurfaceVariant,
              ),
              HsIconLabel(
                label: _time(trip.departureAt),
                icon: LucideIcons.clock,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          if (!trip.canJoin && !trip.isCreator) ...[
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: txt(
                      'برای عضویت در این سفر، ابتدا باید از سفر فعلی خود خارج شوید.',
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
