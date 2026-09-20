import 'package:flutter/widgets.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum MemberStatus {
  none(
    label: "نامشخص",
    icon: LucideIcons.circleAlert,
    badgeType: HsBadgeType.none,
  ),
  confirmed(
    label: "تایید شده",
    icon: LucideIcons.circleCheck,
    badgeType: HsBadgeType.success,
  ),
  pending(
    label: "در انتظار پرداخت",
    icon: LucideIcons.clock,
    badgeType: HsBadgeType.warning,
  );

  final String label;
  final IconData icon;
  final HsBadgeType badgeType;

  const MemberStatus({
    required this.label,
    required this.icon,
    required this.badgeType,
  });
}
