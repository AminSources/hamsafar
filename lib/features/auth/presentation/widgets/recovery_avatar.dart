import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RecoveryAvatar extends StatelessWidget {
  const RecoveryAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: Icon(
            LucideIcons.rotateCcwKey,
            size: context.textTheme.displayLarge!.fontSize,
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
