import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// The single registry for avatar identifiers persisted in Supabase and their
/// corresponding UI icons. Keep existing identifiers stable for compatibility.
const Map<String, IconData> avatarIconRegistry = {
  'tent': LucideIcons.tent,
  'treePalm': LucideIcons.treePalm,
  'cat': LucideIcons.cat,
  'dog': LucideIcons.dog,
  'rabbit': LucideIcons.rabbit,
  'squirrel': LucideIcons.squirrel,
  'panda': LucideIcons.panda,
  'snail': LucideIcons.snail,
  'bird': LucideIcons.bird,
  'turtle': LucideIcons.turtle,
  'fish': LucideIcons.fish,
  'rat': LucideIcons.rat,
};

/// Immutable ordered choices used by avatar pickers.
final List<IconData> avatarIcons =
    List<IconData>.unmodifiable(avatarIconRegistry.values);
