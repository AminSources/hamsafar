import 'package:flutter/material.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/enums/chip_mode.dart';

extension ChipExtenstion on BuildContext {
  //? set chip background by chip mode
  Color setChipBackground(ChipMode chipMode) {
    switch (chipMode) {
      case ChipMode.info:
        return colorScheme.surfaceContainerHighest;
      case ChipMode.warning:
        return colorScheme.secondaryContainer;
      case ChipMode.success:
        return colorScheme.primaryContainer;
    }
  }

  //? set chip label by chip mode
  Color setChipLabel(ChipMode chipMode) {
    switch (chipMode) {
      case ChipMode.info:
        return colorScheme.onSurfaceVariant;
      case ChipMode.warning:
        return colorScheme.secondary;
      case ChipMode.success:
        return colorScheme.primary;
    }
  }
}
