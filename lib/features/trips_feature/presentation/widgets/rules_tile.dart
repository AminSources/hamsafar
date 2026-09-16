import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RulesTile extends StatelessWidget {
  final String rule;

  const RulesTile({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: .center,
        children: [
          Icon(
            LucideIcons.shieldCheck,
            size: 18.sp,
            color: context.colorScheme.primary,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: txt(
              rule,
              size: 12.5.sp,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
