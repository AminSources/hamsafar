import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';

class HsButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final VoidCallback? onTap;

  const HsButton({super.key, this.width, this.height, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 50.h,
        decoration: BoxDecoration(
          gradient: context.horizontalGradient,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(child: child),
      ),
    );
  }
}
