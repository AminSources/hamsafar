import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';

class HsButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final VoidCallback? onTap;
  final HsButtonType? hsButtonType;
  final Color? borderColor;
  final Color? backgroundColor;

  const HsButton({
    super.key,
    this.width,
    this.height,
    this.child,
    this.onTap,
    this.hsButtonType = HsButtonType.filled,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = hsButtonType == HsButtonType.filled;
    return SizedBox(
      width: width,
      height: height ?? 50.h,
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(15.r),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: isFilled ? context.horizontalGradient : null,
            border: isFilled
                ? null
                : Border.all(
                    color: borderColor ?? context.colorScheme.onSurfaceVariant,
                  ),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15.r),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
