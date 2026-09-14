import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final String username;
  final Color avatarColor;
  final String letter;
  final String status;
  final Color chipBg;
  final Color chipFg;
  final IconData? chipIcon;

  const MemberTile({
    super.key,
    required this.name,
    required this.username,
    required this.avatarColor,
    required this.letter,
    required this.status,
    required this.chipBg,
    required this.chipFg,
    this.chipIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: avatarColor,
            child: txt(
              letter,
              color: Colors.white,
              fontWeight: FontWeight.w800,
              size: 15.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                txt(
                  name,
                  size: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                ),
                SizedBox(height: 2.h),
                txt(
                  username,
                  size: 11.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (chipIcon != null) ...[
                  Icon(chipIcon, size: 12.sp, color: chipFg),
                  SizedBox(width: 4.w),
                ],
                txt(
                  status,
                  size: 10.5.sp,
                  color: chipFg,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
