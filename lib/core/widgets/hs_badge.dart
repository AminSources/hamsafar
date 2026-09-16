import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icon;

  const HsBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12.sp, color: foregroundColor),
            SizedBox(width: 4.w),
          ],
          txt(
            label,
            size: 10.5.sp,
            color: foregroundColor,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
