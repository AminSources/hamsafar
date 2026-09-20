import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_icon_label.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripTile extends StatelessWidget {
  final bool isInTrip;
  final String tripName;
  final String leaderName;
  final String date;
  final String time;
  final int members;

  const TripTile({
    super.key,
    required this.isInTrip,
    required this.date,
    required this.members,
    required this.tripName,
    required this.leaderName,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return HsTile(
      onTap: () {
        //? push trip details page
        context.push("/trip-detail", extra: false);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* trip status
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              //* trip status
              HsBadge(
                label: isInTrip ? "درحال سفر" : "درحال اماده سازی",
                icon: Icons.circle,
                iconSize: 8.sp,
                type: isInTrip ? HsBadgeType.success : HsBadgeType.none,
              ),

              //* trip duration
              HsBadge(
                label: "۳ روز مانده",
                icon: LucideIcons.clock,
                type: HsBadgeType.warning,
              ),
            ],
          ),
          SizedBox(height: 12.h),

          //* trip name
          txt(tripName, style: context.textTheme.titleMedium),
          SizedBox(height: 6.h),

          //* trip leader name
          HsIconLabel(
            label: leaderName,
            icon: LucideIcons.crown,
            iconColor: context.colorScheme.secondary,
          ),

          //* date and time details
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              //* date
              HsIconLabel(
                label: date,
                icon: LucideIcons.calendar,
                color: context.colorScheme.onSurfaceVariant,
              ),

              //* time
              HsIconLabel(
                label: time,
                icon: LucideIcons.clock,
                color: context.colorScheme.onSurfaceVariant,
              ),

              //* trip members count
              HsIconLabel(
                label: "$members عضو",
                icon: LucideIcons.userRoundGroup,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
