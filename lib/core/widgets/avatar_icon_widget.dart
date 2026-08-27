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
  final bool? isCircle;

  const AvatarIconWidget({
    super.key,
    this.width,
    this.height,
    this.icon,
    this.iconSize,
    this.backgroundColor,
    this.iconColor,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.primary,
        borderRadius: BorderRadius.circular(isCircle! ? 50.r : 20.r),
      ),
      child: Icon(icon, size: iconSize ?? 20.sp, color: iconColor),
    );
  }
}
