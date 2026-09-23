import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class ProfileSummary extends StatelessWidget {
  final String value;
  final String title;
  final IconData? icon;
  final Color? iconColor;

  const ProfileSummary({
    super.key,
    required this.value,
    required this.title,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            //* icon
            if (icon != null) ...[
              Icon(icon, color: iconColor, size: 18.sp),
              SizedBox(width: 4.w),
            ],

            //* value
            txt(value, style: context.textTheme.titleMedium),
          ],
        ),
        SizedBox(height: 4.h),

        //* title
        txt(
          title,
          style: context.textTheme.bodySmall,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }
}
