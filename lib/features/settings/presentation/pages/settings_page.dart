import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/settings/presentation/cubit/app_settings_cubit.dart';
import 'package:hamsafar/features/settings/presentation/widgets/settings_footer.dart';
import 'package:hamsafar/features/settings/presentation/widgets/settings_tile.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _showLanguageSelector(BuildContext context) async {
    final settingsCubit = context.read<AppSettingsCubit>();

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return BlocBuilder<AppSettingsCubit, AppSettingsState>(
          bloc: settingsCubit,
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: txt(
                        'انتخاب زبان',
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                    RadioGroup<String>(
                      groupValue: state.localeCode,
                      onChanged: (value) {
                        if (value == null) return;
                        settingsCubit.setLanguage(value);
                        Navigator.of(sheetContext).pop();
                      },
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            value: 'fa',
                            title: const txt('فارسی'),
                          ),
                          RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            value: 'en',
                            title: const txt('انگلیسی'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showThemeSelector(BuildContext context) async {
    final settingsCubit = context.read<AppSettingsCubit>();

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return BlocBuilder<AppSettingsCubit, AppSettingsState>(
          bloc: settingsCubit,
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: txt(
                        'انتخاب حالت تم',
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                    RadioGroup<ThemeMode>(
                      groupValue: state.themeMode,
                      onChanged: (value) {
                        if (value == null) return;
                        settingsCubit.setThemeMode(value);
                        Navigator.of(sheetContext).pop();
                      },
                      child: Column(
                        children: [
                          RadioListTile<ThemeMode>(
                            contentPadding: EdgeInsets.zero,
                            value: ThemeMode.system,
                            title: const txt('پیشفرض سیستم'),
                          ),
                          RadioListTile<ThemeMode>(
                            contentPadding: EdgeInsets.zero,
                            value: ThemeMode.light,
                            title: const txt('روشن'),
                          ),
                          RadioListTile<ThemeMode>(
                            contentPadding: EdgeInsets.zero,
                            value: ThemeMode.dark,
                            title: const txt('تیره'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _themeModeLabel(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'پیشفرض سیستم';
      case ThemeMode.light:
        return 'روشن';
      case ThemeMode.dark:
        return 'تیره';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
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
                    title: 'زبان برنامه',
                    subtitle: state.localeCode == 'fa' ? 'فارسی' : 'انگلیسی',
                    icon: LucideIcons.languages,
                    onTap: () => _showLanguageSelector(context),
                  ),
                  SizedBox(height: 10.h),

                  //* theme mode setting
                  SettingsTile(
                    title: 'حالت تم',
                    subtitle: _themeModeLabel(state.themeMode),
                    icon: LucideIcons.sunMoon,
                    onTap: () => _showThemeSelector(context),
                  ),
                  SizedBox(height: 10.h),

                  //* theme color setting
                  SettingsTile(
                    title: 'رنگ تم',
                    subtitle: 'پیشفرض',
                    icon: LucideIcons.swatchBook,
                    trailing: Icon(
                      Icons.circle_rounded,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  //* account and support section title
                  HsHeader(title: 'حساب کاربری و پشتیبانی'),
                  SizedBox(height: 12.h),

                  //* report bug item
                  SettingsTile(
                    title: 'گزارش باگ',
                    icon: LucideIcons.bug,
                    onTap: () => context.push('/bug-report'),
                  ),
                  SizedBox(height: 10.h),

                  //* contact us item
                  SettingsTile(
                    title: 'تماس با ما',
                    icon: LucideIcons.headset,
                    onTap: () => context.push('/bug-report'),
                  ),
                  SizedBox(height: 64.h),

                  //* app version info
                  SettingsFooter(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
