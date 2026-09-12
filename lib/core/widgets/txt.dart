import 'package:flutter/material.dart';

// ignore: camel_case_types
class txt extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? fontFamily;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const txt(
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
