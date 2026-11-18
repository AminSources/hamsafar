import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_member_entity.dart';
import 'package:hamsafar/features/trips/enums/member_rule.dart';
import 'package:hamsafar/features/trips/enums/member_status.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MemberTile extends StatelessWidget {
  final String userId;
  final String displayName;
  final String userName;
  final String avatar;
  final MemberRule memberRule;
  final MemberStatus memberStatus;

  const MemberTile({
    super.key,
    required this.userId,
    required this.displayName,
    required this.userName,
    required this.avatar,
    required this.memberRule,
    required this.memberStatus,
  });

  ({String label, IconData icon, HsBadgeType type}) get _badgeData {
    if (memberStatus == MemberStatus.accepted) {
      return (
        label: memberRule.rule,
        icon: memberRule.icon,
        type: HsBadgeType.none,
      );
    }

    return (
      label: memberStatus.label,
      icon: memberStatus.icon,
      type: memberStatus.badgeType,
    );
  }

  void _openMemberProfile(String userId, BuildContext context) {
    final authState = context.read<AuthBloc>().state;

    if (authState is! AuthSuccess) return;

    final currentUserId = authState.user.id;
    final isCurrentUser = userId == currentUserId;

    final location = isCurrentUser ? '/my-profile' : '/friend-profile/$userId';

    context.push(location);
  }

  @override
  Widget build(BuildContext context) {
    return HsTile(
      onTap: () => _openMemberProfile(userId, context),
      leading: HsAvatar(
        type: HsAvatarType.profile,
        label: Icon(AvatarConverter.stringToIconData(avatarName: avatar)),
        color: getAvatarColor(displayName),
        size: 40.w,
      ),
      trailing: memberRule == MemberRule.member
          ? HsButton(
              width: 45.w,
              height: 45.h,
              hsButtonType: HsButtonType.outline,
              borderColor: context.colorScheme.error,
              child: Icon(
                LucideIcons.userRoundMinus,
                color: context.colorScheme.error,
                size: context.textTheme.bodyMedium!.fontSize! * 1.2,
              ),
            )
          : SizedBox(width: 45.w, height: 45.h),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* name
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Flexible(
                child: txt(
                  displayName,
                  style: context.textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: HsBadge(
                  label: _badgeData.label,
                  icon: _badgeData.icon,
                  type: _badgeData.type,
                ),
              ),
            ],
          ),

          //* user name
          txt("@$userName", style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
