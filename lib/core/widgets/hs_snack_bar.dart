import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_enums.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HsSnackBar {
  final String text;
  final IconData? icon;
  final HsSnackBarMode? mode;

  const HsSnackBar({required this.text, this.icon, this.mode});

  SnackBar toSnackBar(BuildContext context) {
    final Color iconColor;
    final IconData contentIcon;
    switch (mode) {
      case HsSnackBarMode.success:
        iconColor = context.colorScheme.primary;
        contentIcon = icon ?? LucideIcons.circleCheck;
        break;
      case HsSnackBarMode.error:
        iconColor = context.colorScheme.error;
        contentIcon = icon ?? LucideIcons.xCircle;
        break;
      case HsSnackBarMode.warning:
        iconColor = context.colorScheme.onSecondary;
        contentIcon = icon ?? LucideIcons.alertTriangle;
        break;
      case HsSnackBarMode.info:
        iconColor = context.colorScheme.inverseSurface;
        contentIcon = icon ?? LucideIcons.info;
        break;
      default:
        iconColor = context.colorScheme.inverseSurface;
        contentIcon = icon ?? LucideIcons.info;
        break;
    }

    return SnackBar(
      content: Row(
        children: [
          //* icon
          Icon(contentIcon, color: iconColor),

          //* text
          SizedBox(width: 12.w),
          txt(text, fontWeight: FontWeight.w800, size: 14.sp),
        ],
      ),
      backgroundColor: context.colorScheme.surfaceContainer,
      duration: const Duration(milliseconds: 1500),
    );
  }
}
