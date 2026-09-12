import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String text;
  final TextStyle? style; // تغییر نام به استاندارد فلاتر
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? fontFamily;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const Txt(
    this.text, {
    super.key,
    this.style,
    this.size,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.fontFamily,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final baseStyle = theme.textTheme.bodyMedium?.merge(style);

    final effectiveStyle = baseStyle?.copyWith(
      fontSize: size ?? baseStyle.fontSize,
      color: color ?? baseStyle.color,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      fontFamily: fontFamily ?? baseStyle.fontFamily,
      decoration: decoration ?? baseStyle.decoration,
      decorationColor: decorationColor ?? baseStyle.decorationColor,
    );

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: effectiveStyle,
    );
  }
}
