import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(16.w),
      radius: 16.r,
      color: context.colorScheme.surface,
      onTap: onTap,
      child: Row(
        children: [
          //* icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: context.colorScheme.primary, size: 20.sp),
          ),
          SizedBox(width: 12.w),

          //* text column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                txt(title, style: context.textTheme.titleSmall),

                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  txt(
                    subtitle!,
                    style: context.textTheme.bodySmall,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ],
            ),
          ),

          //* trailing
          trailing ?? const SizedBox.shrink(),

          //* chevron
          Icon(
            Icons.chevron_right_rounded,
            color: context.colorScheme.onSurfaceVariant,
            size: 24.sp,
          ),
        ],
      ),
    );
  }
}
