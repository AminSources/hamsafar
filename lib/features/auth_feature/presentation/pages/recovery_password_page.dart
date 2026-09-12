import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_appbar.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HsAppbar(title: "", hasBack: true),

              SizedBox(height: 40.h),

              Center(
                child: Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.key_rounded,
                      size: context.textTheme.displayLarge!.fontSize,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
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
                  prefixIcon: Icon(Icons.email_outlined),
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
