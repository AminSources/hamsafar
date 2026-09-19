import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HomeMemberCircle extends StatelessWidget {
  final String label;
  final Color? bg;
  final Color? fg;

  const HomeMemberCircle({super.key, required this.label, this.bg, this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bg,
        border: Border.all(
          color: context.colorScheme.surfaceContainerHigh,
          width: 2,
        ),
      ),
      child: Center(
        child: txt(label, size: 11.sp, color: fg, fontWeight: FontWeight.w800),
      ),
    );
  }
}
