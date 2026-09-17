import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

extension HsSnackBarExtension on BuildContext {
  void showHsSnackBar({
    required String text,
    IconData? icon,
    HsSnackBarType hsSnackBarType = HsSnackBarType.info,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    final ({Color color, IconData defaultIcon}) style =
        switch (hsSnackBarType) {
          HsSnackBarType.success => (
            color: colorScheme.primary,
            defaultIcon: LucideIcons.circleCheck,
          ),
          HsSnackBarType.error => (
            color: colorScheme.error,
            defaultIcon: LucideIcons.xCircle,
          ),
          HsSnackBarType.warning => (
            color: colorScheme.onSecondary,
            defaultIcon: LucideIcons.alertTriangle,
          ),
          HsSnackBarType.info => (
            color: colorScheme.inverseSurface,
            defaultIcon: LucideIcons.info,
          ),
        };

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon ?? style.defaultIcon, color: style.color),
              SizedBox(width: 12.w),
              Expanded(
                child: txt(
                  text,
                  fontWeight: FontWeight.w800,
                  size: 14.sp,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          backgroundColor: colorScheme.surfaceContainer,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 75.h),
          duration: duration,
        ),
      );
  }
}
