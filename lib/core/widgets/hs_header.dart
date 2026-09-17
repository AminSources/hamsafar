import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onTap;

  const HsHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        txt(title, style: context.textTheme.titleMedium),
        const Spacer(),
        if (actionLabel != null)
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                txt(
                  actionLabel!,
                  size: 11.5.sp,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 16.sp,
                  color: context.colorScheme.primary,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
