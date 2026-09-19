import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/features/settings/presentation/widgets/settings_footer.dart';
import 'package:hamsafar/features/settings/presentation/widgets/settings_tile.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
              HsAppBar(title: 'تنظیمات', hasBack: true),
              SizedBox(height: 24.h),

              //* app settings section title
              HsHeader(title: 'تنظیمات برنامه'),
              SizedBox(height: 12.h),

              //* language setting
              SettingsTile(
                title: "زبان برنامه",
                subtitle: "فارسی",
                icon: LucideIcons.languages,
              ),
              SizedBox(height: 10.h),

              //* theme mode setting
              SettingsTile(
                title: "حالت تم",
                subtitle: "پیشفرض سیستم",
                icon: LucideIcons.sunMoon,
              ),
              SizedBox(height: 10.h),

              //* theme color setting
              SettingsTile(
                title: "رنگ تم",
                subtitle: "پیشفرض",
                icon: LucideIcons.swatchBook,
                trailing: Icon(
                  Icons.circle_rounded,
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(height: 24.h),

              //* account and support section title
              HsHeader(title: "حساب کاربری و پشتیبانی"),
              SizedBox(height: 12.h),

              //* report bug item
              SettingsTile(
                title: "گزارش باگ",
                icon: LucideIcons.bug,
                onTap: () => context.push("/bug-report"),
              ),
              SizedBox(height: 10.h),

              //* contact us item
              SettingsTile(
                title: "تماس با ما",
                icon: LucideIcons.headset,
                onTap: () => context.push("/bug-report"),
              ),
              SizedBox(height: 64.h),

              //* app version info
              SettingsFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
