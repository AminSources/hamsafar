import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripInput extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  const TripInput({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            txt(
              title,
              size: 11.sp,
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 6.h),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: value,
                prefixIcon: Icon(
                  icon,
                  size: 18.sp,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
