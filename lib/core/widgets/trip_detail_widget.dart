import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripDetailWidget extends StatelessWidget {
  final String label;
  final IconData icon;

  const TripDetailWidget({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: .rtl,
      children: [
        //* icon
        Icon(icon, size: context.textTheme.bodyLarge!.fontSize),

        //* space
        SizedBox(width: 5.w),

        //* title
        txt(label),
      ],
    );
  }
}
