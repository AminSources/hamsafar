import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
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
    this.type,
    this.labelSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (type) {
      case HsBadgeType.success:
        bg = context.colorScheme.primaryContainer;
        fg = context.colorScheme.primary;
      case HsBadgeType.warning:
        bg = context.colorScheme.secondaryContainer;
        fg = context.colorScheme.onSecondaryContainer;
      default:
        bg = context.colorScheme.surfaceContainer;
        fg = context.colorScheme.inverseSurface;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: iconSize ?? 12.sp, color: fg),
            SizedBox(width: 4.w),
          ],
          txt(
            label,
            size: labelSize ?? 10.5.sp,
            color: fg,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
