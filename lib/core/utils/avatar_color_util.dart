import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:material_ui/material_ui.dart';

Color getAvatarColor(String identifier) {
  final avatars = AppColors.avatars;

  final hash = identifier.codeUnits.fold<int>(
    0,
    (prev, element) => prev + element,
  );
  return avatars[hash % avatars.length];
}
