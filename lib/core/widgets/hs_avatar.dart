import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';

class HsAvatar extends StatelessWidget {
  final double? size;
  final Widget? label;
  final double? labelSize;
  final Color? labelColor;
  final bool? isCircle;
  final Color? color;
  final HsAvatarType? type;

  const HsAvatar({
    super.key,
    this.size,
    this.label,
    this.labelSize,
    this.labelColor,
    this.isCircle,
    this.color,
    this.type = HsAvatarType.none,
  });

  @override
  Widget build(BuildContext context) {
    Color foregroundColor = Colors.white;
    Color backgroundColor;
    bool isCircleAvatar;
    switch (type) {
      case HsAvatarType.profile:
        foregroundColor = Colors.white;
        backgroundColor = color ?? context.colorScheme.primary;
        isCircleAvatar = true;
      case HsAvatarType.icon:
        foregroundColor = context.colorScheme.primary;
        backgroundColor = context.colorScheme.onPrimary;
        isCircleAvatar = false;
      default:
        foregroundColor = labelColor ?? Colors.white;
        backgroundColor = color ?? context.colorScheme.primary;
        isCircleAvatar = isCircle ?? false;
    }

    return Container(
      width: size ?? 20.w,
      height: size ?? 20.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(isCircleAvatar ? 99.r : 12.r),
      ),
      child: Center(
        child: IconTheme(
          data: IconThemeData(color: foregroundColor, size: labelSize ?? 20.sp),
          child: label ?? SizedBox.shrink(),
        ),
      ),
    );
  }
}
