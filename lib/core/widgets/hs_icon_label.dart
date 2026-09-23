import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsIconLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final double? spacing;
  final double? iconSize;
  final double? labelSize;
  final Color? iconColor;
  final Color? labelColor;

  const HsIconLabel({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.spacing,
    this.iconColor,
    this.labelColor,
    this.iconSize,
    this.labelSize,
  });

  ({Color? labelClr, Color? iconClr}) get _resolvedColors {
    if (color != null) {
      return (labelClr: color, iconClr: color);
    }
    return (labelClr: labelColor, iconClr: iconColor);
  }

  @override
  Widget build(BuildContext context) {
    final colors = _resolvedColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: spacing ?? 8.w,
      children: [
        //* icon
        Icon(
          icon,
          size: iconSize,
          color: colors.iconClr ?? context.colorScheme.inverseSurface,
        ),

        //* txt
        Flexible(
          child: txt(
            label,
            size: labelSize,
            style: context.textTheme.bodyLarge,
            color: colors.labelClr ?? context.colorScheme.inverseSurface,
          ),
        ),
      ],
    );
  }
}
