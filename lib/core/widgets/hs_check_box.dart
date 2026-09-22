import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';

class HsCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onTap;

  const HsCheckBox({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(!value),
      borderRadius: BorderRadius.circular(99.r),
      child: Ink(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: value ? context.colorScheme.primary : null,
          border: Border.all(color: context.colorScheme.outline),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: value
              ? Icon(
                  Icons.check,
                  size: 16.sp,
                  color: context.colorScheme.onPrimary,
                )
              : null,
        ),
      ),
    );
  }
}
