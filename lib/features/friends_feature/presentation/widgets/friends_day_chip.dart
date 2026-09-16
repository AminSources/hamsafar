import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsDayChip extends StatelessWidget {
  final String dayLetter;
  final bool isActive;
  final ValueChanged<int> onChange;

  const FriendsDayChip({
    super.key,
    required this.dayLetter,
    required this.isActive,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: isActive
            ? context.colorScheme.primary
            : context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: txt(
          dayLetter,
          color: isActive
              ? context.colorScheme.onPrimary
              : context.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          size: 14.sp,
        ),
      ),
    );
  }
}
