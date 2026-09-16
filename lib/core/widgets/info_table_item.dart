import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class InfoTableItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor;

  const InfoTableItem({
    super.key,
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        txt(
          label,
          style: context.textTheme.labelSmall,
          color: labelColor ?? context.colorScheme.onSurfaceVariant,
        ),
        SizedBox(height: 3.h),
        txt(
          value,
          style: context.textTheme.labelLarge,
          color: valueColor ?? context.colorScheme.inverseSurface,
        ),
      ],
    );
  }
}
