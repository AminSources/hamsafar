import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_icon_label.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendsProfileAboutCard extends StatelessWidget {
  final String bio;

  const FriendsProfileAboutCard({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(16.w),
      radius: 16.r,
      color: context.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* section title
          HsIconLabel(
            label: "درباره من",
            labelSize: 16.sp,
            icon: LucideIcons.userRound,
            iconColor: context.colorScheme.primary,
          ),

          SizedBox(height: 12.h),

          //* about text
          txt(
            bio,
            color: context.colorScheme.onSurfaceVariant,
            size: 12.5.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
