import 'package:flutter/material.dart';
import 'package:hamsafar/core/extensions/chip_extenstion.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/enums/chip_mode.dart';

class ChipWidget extends StatelessWidget {
  final Widget label;
  final ChipMode? chipMode;

  const ChipWidget({
    super.key,
    required this.label,
    this.chipMode = ChipMode.info,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: label,
      labelStyle: context.textTheme.bodySmall?.copyWith(
        color: context.setChipLabel(chipMode!),
      ),
      backgroundColor: context.setChipBackground(chipMode!),
    );
  }
}
