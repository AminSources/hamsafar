import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class BottomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final int value;
  final ValueChanged<int> onSelect;

  const BottomNavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.value,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(value),
      splashColor: context.colorScheme.primaryContainer,
      child: Ink(
        child: Column(
          spacing: 5.h,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            if (isSelected == true)
              Container(
                width: 16.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            //* icon
            Icon(
              icon,
              size: 20.sp,
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurfaceVariant,
            ),

            //* label
            txt(
              label,
              style: context.textTheme.labelMedium,
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
