import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OnboardingProfileAvatar extends StatelessWidget {
  const OnboardingProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          //* circle avatar
          CircleAvatar(
            radius: 50.r,
            backgroundColor: context.colorScheme.primaryContainer,
            child: Icon(
              LucideIcons.userRound,
              size: 50.sp,
              color: context.colorScheme.primary,
            ),
          ),

          //* edit button
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.surface,
                  width: 2.w,
                ),
              ),
              child: Icon(
                LucideIcons.edit,
                size: 20.sp,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
