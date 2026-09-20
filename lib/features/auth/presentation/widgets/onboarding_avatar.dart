import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OnboardingAvatar extends StatelessWidget {
  const OnboardingAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentGeometry.bottomRight,
        children: [
          //* circle avatar
          HsAvatar(
            size: 90.w,
            type: HsAvatarType.profile,
            label: Icon(LucideIcons.userRound, size: 40.sp),
          ),

          //* edit button
          HsAvatar(
            size: 30.w,
            type: HsAvatarType.icon,
            label: Icon(LucideIcons.edit, size: 16.sp),
          ),
        ],
      ),
    );
  }
}
