import 'package:flutter/material.dart';
import "package:lucide_icons_flutter/lucide_icons.dart";

enum MemberRule {
  owner(rule: "لیدر", icon: LucideIcons.crown),
  member(rule: "عضو", icon: LucideIcons.userRound);

  final String rule;
  final IconData icon;

  const MemberRule({required this.rule, required this.icon});
}
