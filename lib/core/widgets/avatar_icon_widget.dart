import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';

class AvatarIconWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData? icon;

  const AvatarIconWidget({super.key, this.width, this.height, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(icon, size: 50.w),
    );
  }
}
