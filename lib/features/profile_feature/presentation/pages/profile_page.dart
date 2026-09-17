import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile_feature/presentation/widgets/profile_card.dart';
import 'package:hamsafar/features/profile_feature/presentation/widgets/profile_menu_tile.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              HsAppBar(title: 'پروفایل من'),
              SizedBox(height: 24.h),

              //* profile header card
              ProfileCard(),
              SizedBox(height: 16.h),

              //* available days item
              ProfileMenuTile(
                title: 'روزهای آزاد من',
                subtitle: "چ، پ، ج",
                icon: LucideIcons.calendarCheck,
                onTap: () {
                  context.push('/available-days');
                },
              ),
              SizedBox(height: 12.h),

              ProfileMenuTile(
                title: 'وسایل من',
                subtitle: '۵ مورد',
                icon: LucideIcons.toolCase,
                onTap: () {
                  context.push('/my-items');
                },
              ),
              SizedBox(height: 24.h),

              //* settings section title
              HsHeader(title: "تنظیمات"),
              SizedBox(height: 12.h),

              //* app settings item
              ProfileMenuTile(
                title: "تنظیمات برنامه",
                icon: LucideIcons.settings,
                onTap: () {
                  context.push('/settings');
                },
              ),
              SizedBox(height: 12.h),

              //* account settings item
              ProfileMenuTile(
                title: "تنظیمات حساب کاربری",
                icon: LucideIcons.userRoundCog,
                onTap: () {},
              ),
              SizedBox(height: 16.h),

              //* logout button
              HsButton(
                hsButtonType: HsButtonType.outline,
                borderColor: context.colorScheme.error,
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: 10.w,
                  children: [
                    //* icon
                    Icon(
                      LucideIcons.logOut,
                      size: 20.sp,
                      color: context.colorScheme.error,
                    ),

                    //* txt
                    txt(
                      "خروج از حساب کاربری",
                      color: context.colorScheme.error,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 65.h),
            ],
          ),
        ),
      ),
    );
  }
}
