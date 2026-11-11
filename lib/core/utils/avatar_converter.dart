import 'package:flutter/material.dart';
import 'package:hamsafar/core/constants/icons.dart';

class AvatarConverter {
  const AvatarConverter._();

  static IconData stringToIconData({required String avatarName}) {
    return avatarIconRegistry[avatarName] ?? avatarIconRegistry['tent']!;
  }

  static String iconDataToString({required IconData iconData}) {
    for (final entry in avatarIconRegistry.entries) {
      if (entry.value == iconData) return entry.key;
    }
    return 'tent';
  }
}
