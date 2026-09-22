import 'package:flutter/material.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';

extension HsBadgeExtension on HsBadgeType {
  Color backgroundColor(BuildContext context) {
    switch (this) {
      case HsBadgeType.success:
        return context.colorScheme.primaryContainer;
      case HsBadgeType.warning:
        return context.colorScheme.secondaryContainer;
      case HsBadgeType.error:
        return context.colorScheme.errorContainer;
      case HsBadgeType.none:
        return context.colorScheme.surfaceContainer;
    }
  }

  Color foregroundColor(BuildContext context) {
    switch (this) {
      case HsBadgeType.success:
        return context.colorScheme.primary;
      case HsBadgeType.warning:
        return context.colorScheme.onSecondaryContainer;
      case HsBadgeType.error:
        return context.colorScheme.onErrorContainer;
      case HsBadgeType.none:
        return context.colorScheme.onSurfaceVariant;
    }
  }
}
