import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';

class AvatarIconWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData? icon;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const AvatarIconWidget({
    super.key,
    this.width,
    this.height,
    this.icon,
    this.iconSize,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(icon, size: iconSize ?? 50.sp, color: iconColor),
    );
  }
}
