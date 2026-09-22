import 'package:flutter/material.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import "package:lucide_icons_flutter/lucide_icons.dart";

enum PaymentMemberStatus {
  pending(
    label: "در انتظار پرداخت",
    badgeType: HsBadgeType.warning,
    icon: LucideIcons.clock,
  ),
  paid(
    label: "پرداخت شده",
    badgeType: HsBadgeType.success,
    icon: LucideIcons.creditCardCheck,
  ),
  notPaid(
    label: "پرداخت نشده",
    badgeType: HsBadgeType.error,
    icon: LucideIcons.creditCardMinus,
  );

  final String label;
  final HsBadgeType badgeType;
  final IconData icon;

  const PaymentMemberStatus({
    required this.label,
    required this.badgeType,
    required this.icon,
  });
}
