import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/extensions/hs_badge_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsBadge extends StatelessWidget {
  final String label;
  final double? labelSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icon;
  final double? iconSize;
  final HsBadgeType? type;

  const HsBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.type = HsBadgeType.none,
    this.labelSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? type!.backgroundColor(context),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: iconSize ?? 12.sp,
              color: foregroundColor ?? type!.foregroundColor(context),
            ),
            SizedBox(width: 4.w),
          ],
          txt(
            label,
            size: labelSize ?? 10.5.sp,
            color: foregroundColor ?? type!.foregroundColor(context),
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
