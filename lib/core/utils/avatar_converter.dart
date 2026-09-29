import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AvatarConverter {
  const AvatarConverter._();

  static IconData stringToIconData({required String avatarName}) {
    switch (avatarName) {
      case 'tent':
        return LucideIcons.tent;
      case 'treePalm':
        return LucideIcons.treePalm;
      case 'cat':
        return LucideIcons.cat;
      case 'dog':
        return LucideIcons.dog;
      case 'rabbit':
        return LucideIcons.rabbit;
      case 'squirrel':
        return LucideIcons.squirrel;
      case 'panda':
        return LucideIcons.panda;
      case 'snail':
        return LucideIcons.snail;
      case 'bird':
        return LucideIcons.bird;
      case 'turtle':
        return LucideIcons.turtle;
      case 'fish':
        return LucideIcons.fish;
      case 'rat':
        return LucideIcons.rat;
      default:
        return LucideIcons.tent;
    }
  }

  static String iconDataToString({required IconData iconData}) {
    switch (iconData) {
      case LucideIcons.tent:
        return 'tent';
      case LucideIcons.treePalm:
        return 'treePalm';
      case LucideIcons.cat:
        return 'cat';
      case LucideIcons.dog:
        return 'dog';
      case LucideIcons.rabbit:
        return 'rabbit';
      case LucideIcons.squirrel:
        return 'squirrel';
      case LucideIcons.panda:
        return 'panda';
      case LucideIcons.snail:
        return 'snail';
      case LucideIcons.bird:
        return 'bird';
      case LucideIcons.turtle:
        return 'turtle';
      case LucideIcons.fish:
        return 'fish';
      case LucideIcons.rat:
        return 'rat';
      default:
        return 'tent';
    }
  }
}
