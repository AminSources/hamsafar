import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_icon_label.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendsTileInfo extends StatelessWidget {
  final String rate;
  final int tripCount;

  const FriendsTileInfo({
    super.key,
    required this.rate,
    required this.tripCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //* rating
        HsIconLabel(
          label: rate,
          icon: LucideIcons.star,
          iconSize: 12.sp,
          labelSize: 12.sp,
          iconColor: context.colorScheme.secondary,
        ),

        SizedBox(width: 12.w),

        //* trips count
        HsIconLabel(
          label: "$tripCount سفر",
          icon: LucideIcons.mapPinCheck,
          iconSize: 12.sp,
          labelSize: 12.sp,
          color: context.textTheme.bodySmall!.color,
        ),
      ],
    );
  }
}
