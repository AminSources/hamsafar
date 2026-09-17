import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TimeRangeTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const TimeRangeTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          txt(
            title,
            style: context.textTheme.titleSmall,
            color: context.colorScheme.onSurface,
          ),
          SizedBox(height: 8.h),
          HsContainer(
            color: context.colorScheme.primaryContainer,
            borderColor: context.colorScheme.primary,
            padding: EdgeInsets.all(14.w),
            onTap: onTap,
            child: txt(
              value,
              style: context.textTheme.titleLarge,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
