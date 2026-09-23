// lib/features/friends_feature/presentation/pages/friend_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_available_days_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_profile_about_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_profile_card.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_tools_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar section
              HsAppBar(title: 'پروفایل دوست', hasBack: true),
              SizedBox(height: 24.h),

              //* profile card section
              FriendsProfileCard(),
              SizedBox(height: 20.h),

              //* about me section
              FriendsProfileAboutCard(),
              SizedBox(height: 16.h),

              //* available days section
              FriendsAvailableDaysCard(),
              SizedBox(height: 16.h),

              //* my items section
              FriendsToolsCard(),
              SizedBox(height: 24.h),

              //* remove friend button
              HsButton(
                hsButtonType: HsButtonType.outline,
                borderColor: context.colorScheme.error,
                onTap: () {
                  //? close page
                  context.pop();
                },
                child: Row(
                  spacing: 8.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.userRoundMinus,
                      size: 20.sp,
                      color: context.colorScheme.error,
                    ),
                    txt(
                      'حذف دوست',
                      color: context.colorScheme.error,
                      fontWeight: FontWeight.w800,
                      size: 14.sp,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
