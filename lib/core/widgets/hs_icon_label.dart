import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsIconLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final double? spacing;
  final double? size;
  final Color? iconColor;
  final Color? labelColor;

  const HsIconLabel({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.spacing,
    this.size,
    this.iconColor,
    this.labelColor,
  });

  ({Color? newLabelColor, Color? newIconColor}) get copyWith {
    if (color != null) {
      return (newLabelColor: color, newIconColor: color);
    }

    return (
      newLabelColor: color ?? labelColor,
      newIconColor: color ?? iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: 8.w,
      children: [
        //* icon
        Icon(
          icon,
          size: 16.sp,
          color: copyWith.newIconColor ?? context.colorScheme.inverseSurface,
        ),

        //* txt
        Flexible(
          child: txt(
            label,
            style: context.textTheme.bodyLarge,
            color: copyWith.newLabelColor ?? context.colorScheme.inverseSurface,
          ),
        ),
      ],
    );
  }
}
