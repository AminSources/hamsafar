import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class ProfileAvailableDayChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final ValueChanged<bool> onSelect;

  const ProfileAvailableDayChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: 64.w,
      height: 44.w,
      color: isSelected
          ? context.colorScheme.primary
          : context.colorScheme.surface,
      borderColor: isSelected
          ? context.colorScheme.primary
          : context.colorScheme.outline,
      onTap: () => onSelect(isSelected),
      child: Center(
        child: txt(
          title,
          style: context.textTheme.titleSmall,
          color: isSelected
              ? context.colorScheme.onPrimary
              : context.colorScheme.onSurface,
        ),
      ),
    );
  }
}
