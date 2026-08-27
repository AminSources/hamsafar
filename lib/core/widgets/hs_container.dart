import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';

class HsContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? radius;
  final Color? borderColor;
  final bool? hasBorder;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const HsContainer({
    super.key,
    this.width,
    this.height,
    this.child,
    this.radius,
    this.borderColor,
    this.hasBorder,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 15.r,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.outline,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: radius ?? BorderRadius.circular(15.r),
        ),
        child: child,
      ),
    );
  }
}
