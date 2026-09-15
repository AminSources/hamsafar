import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class DateTimeOption extends StatelessWidget {
  final String title;
  final bool selected;

  const DateTimeOption({
    super.key,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: HsContainer(
        padding: EdgeInsets.all(14.w),
        color: selected
            ? context.colorScheme.primaryContainer
            : context.colorScheme.surface,
        borderColor: selected ? context.colorScheme.primary : null,
        radius: 14.r,
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              size: 22.sp,
              color: selected
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 12.w),
            txt(
              title,
              size: 13.5.sp,
              fontWeight: FontWeight.w800,
              color: selected
                  ? context.colorScheme.onPrimaryContainer
                  : context.colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
