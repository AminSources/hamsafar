import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HomeInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const HomeInfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        txt(label, size: 10.sp, color: Colors.white.withValues(alpha: 0.7)),
        SizedBox(height: 3.h),
        txt(
          value,
          size: 12.5.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ],
    );
  }
}
