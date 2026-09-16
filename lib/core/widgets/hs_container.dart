import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';

class HsContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;
  final Alignment? alignment;
  final Color? borderColor;

  const HsContainer({
    super.key,
    this.width,
    this.height,
    this.child,
    this.onTap,
    this.radius,
    this.color,
    this.padding,
    this.margin,
    this.gradient,
    this.alignment,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          type: MaterialType.transparency,
          borderRadius: BorderRadius.circular(radius ?? 10.r),
          child: Ink(
            decoration: BoxDecoration(
              color: color,
              gradient: gradient,
              border: Border.all(
                color: borderColor ?? context.colorScheme.surfaceContainerHigh,
              ),
              borderRadius: BorderRadius.circular(radius ?? 10.r),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(radius ?? 10.r),
              child: Padding(
                padding: padding ?? EdgeInsets.zero,
                child: Align(
                  alignment: alignment ?? Alignment.center,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
