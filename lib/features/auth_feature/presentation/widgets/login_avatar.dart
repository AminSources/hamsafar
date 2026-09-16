import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginAvatar extends StatelessWidget {
  const LoginAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
        gradient: context.verticalGradient,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Center(
        child: Icon(
          LucideIcons.backpack,
          size: context.textTheme.displayLarge!.fontSize,
        ),
      ),
    );
  }
}
