// lib/features/friends_feature/presentation/pages/friend_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_day_chip.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_item_tile.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_profile_about_card.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_profile_card.dart';
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
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* section title
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 18.sp,
                          color: context.colorScheme.primary,
                        ),
                        SizedBox(width: 8.w),
                        txt(
                          'روزهای آزاد هفته',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    //* days grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        7,
                        (index) => FriendsDayChip(
                          dayLetter: ["ش", "ی", "د", "س", "چ", "پ", "ج"][index],
                          isActive: index > 3,
                          onChange: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              //* my items section
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 16.r,
                color: context.colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* section title
                    Row(
                      children: [
                        Icon(
                          Icons.backpack_outlined,
                          size: 18.sp,
                          color: context.colorScheme.primary,
                        ),
                        SizedBox(width: 8.w),
                        txt(
                          'وسایل من',
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
                          child: FriendsItemTile(
                            itemName: [
                              "چادر",
                              "گاز",
                              "دوربین",
                              "قطب نما",
                            ][index],
                            icon: [
                              LucideIcons.tent,
                              LucideIcons.flame,
                              LucideIcons.camera,
                              LucideIcons.compass,
                            ][index],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              //* remove friend button
              HsButton(
                width: double.infinity,
                height: 50.h,
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
