import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HsAppBar(title: "", hasBack: true),

              SizedBox(height: 40.h),

              HsAvatar(
                size: 70.w,
                type: HsAvatarType.icon,
                label: Icon(LucideIcons.rotateCcwKey, size: 36.sp),
              ),
              SizedBox(height: 16.h),

              Center(
                child: txt(
                  'بازیابی رمز عبور',
                  style: context.textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 8.h),
              txt(
                'ایمیل خود را وارد کنید تا کد بازیابی رمز عبور برایتان ارسال شود.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 32.h),

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'ایمیل',
                  prefixIcon: Icon(LucideIcons.mail),
                ),
              ),
              SizedBox(height: 32.h),

              HsButton(
                width: double.infinity,
                height: 50.h,
                onTap: () {},
                child: const txt('ارسال کد بازیابی'),
              ),
              SizedBox(height: 24.h),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: txt(
                    'بازگشت به صفحه ورود',
                    style: context.textTheme.labelMedium,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
