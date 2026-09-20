import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_icon_label.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripSummaryCard extends StatelessWidget {
  const TripSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            HsBadge(
              label: "درحال اماده سازی",
              icon: Icons.circle,
              iconSize: 8.sp,
            ),

            HsBadge(
              label: "۳ روز مانده",
              icon: LucideIcons.clock,
              type: HsBadgeType.warning,
            ),
          ],
        ),

        //* space
        SizedBox(height: 12.h),

        //* trip name
        txt("سفر کوهنوردی عینالی", style: context.textTheme.displaySmall),

        //* trip location detail
        HsIconLabel(
          label: "تبریز، کوه عینالی",
          icon: LucideIcons.mapPin,
          color: context.colorScheme.onSurfaceVariant,
        ),

        //* space
        SizedBox(height: 12.h),

        //* trip date and time
        Row(
          mainAxisAlignment: .spaceBetween,
          spacing: 12.w,
          children: [
            //* date
            HsIconLabel(
              label: "تاریخ: ۱۷ اردیبهشت",
              icon: LucideIcons.calendar,
            ),

            //* time
            HsIconLabel(label: "ساعت: ۱۸:۰۰", icon: LucideIcons.clock),

            //* members
            HsIconLabel(label: "اعضا: ۶ نفر", icon: LucideIcons.userRoundGroup),
          ],
        ),
      ],
    );
  }
}
