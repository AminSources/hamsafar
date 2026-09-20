import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/enums/member_rule.dart';
import 'package:hamsafar/features/trips/enums/member_status.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final String username;
  final MemberStatus? memberStatus;
  final MemberRule? memberRule;
  final bool isInTrip;

  const MemberTile({
    super.key,
    required this.name,
    required this.username,
    this.memberStatus,
    this.memberRule,
    required this.isInTrip,
  });

  ({String label, IconData icon, HsBadgeType type}) get _badgeData {
    if (isInTrip && memberStatus == MemberStatus.none) {
      return (
        label: memberRule!.rule,
        icon: memberRule!.icon,
        type: HsBadgeType.none,
      );
    }

    return (
      label: memberStatus!.label,
      icon: memberStatus!.icon,
      type: memberStatus!.badgeType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HsTile(
      leading: HsAvatar(
        type: HsAvatarType.profile,
        label: txt(name[0], size: 16.sp),
        color: getAvatarColor(name),
        size: 40.w,
      ),
      trailing: HsBadge(
        label: _badgeData.label,
        icon: _badgeData.icon,
        type: _badgeData.type,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* name
          txt(name, style: context.textTheme.bodyLarge),

          //* user name
          txt(username, style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
