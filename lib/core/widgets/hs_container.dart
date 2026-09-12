import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';

class HsContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final Widget? child;
  final VoidCallback? onTap;

  const HsContainer({
    super.key,
    this.width,
    this.height,
    this.child,
    this.onTap,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius ?? 10.r),
      child: Container(
        width: width ?? 40.w,
        height: height ?? 40.w,
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.onSurfaceVariant),
          borderRadius: BorderRadius.circular(radius ?? 10.r),
        ),
        child: child,
      ),
    );
  }
}
