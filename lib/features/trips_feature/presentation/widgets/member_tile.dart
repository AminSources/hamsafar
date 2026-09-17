import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/features/trip_creation_feature/enums/member_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final String username;
  final Color avatarColor;
  final String letter;

  final MemberType? status;
  final String? statusLabel;

  const MemberTile({
    super.key,
    required this.name,
    required this.username,
    required this.avatarColor,
    required this.letter,
    required this.status,

    this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    //? chip icon , chip bg , chip fg
    IconData chipIcon;
    Color chipBg;
    Color chipFg;
    switch (status) {
      case MemberType.leader:
        chipIcon = LucideIcons.crown;
        chipBg = context.colorScheme.secondaryContainer;
        chipFg = context.colorScheme.onSecondaryContainer;
        break;
      case MemberType.confirmed:
        chipIcon = LucideIcons.circleCheck;
        chipBg = AppColors.successContainer;
        chipFg = AppColors.onSuccessContainer;
        break;
      case MemberType.pending:
        chipIcon = LucideIcons.clock;
        chipBg = context.colorScheme.onSecondaryContainer;
        chipFg = context.colorScheme.secondaryContainer;
        break;
      default:
        chipIcon = LucideIcons.info;
        chipBg = context.colorScheme.tertiary;
        chipFg = context.colorScheme.onTertiary;
    }

    //
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: avatarColor,
            child: txt(
              letter,
              color: Colors.white,
              fontWeight: FontWeight.w800,
              size: 15.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                txt(
                  name,
                  size: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                ),
                SizedBox(height: 2.h),
                txt(
                  username,
                  size: 11.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          HsBadge(
            label: statusLabel ?? "نامشخص",
            backgroundColor: chipBg,
            foregroundColor: chipFg,
            icon: chipIcon,
          ),
        ],
      ),
    );
  }
}
