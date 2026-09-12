// lib/features/auth/presentation/pages/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            //? unfocus text field when tap anywhere of page
            emailFocusNode.unfocus();
            passwordFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),

                Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    gradient: context.verticalGradient,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.route_outlined,
                      size: context.textTheme.displayLarge!.fontSize,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                txt('خوش برگشتی! 👋', style: context.textTheme.headlineLarge),

                SizedBox(height: 8.h),

                txt(
                  'برای ادامه هماهنگی سفرها وارد حسابت شو',
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(height: 32.h),

                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'ایمیل',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 16.h),

                TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: 'رمز عبور',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                TextButton(
                  onPressed: () {
                    //? push recovery password page
                    context.push('/recovery');
                  },
                  child: txt(
                    'فراموشی رمز عبور؟',
                    style: context.textTheme.labelMedium,
                    color: context.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 24.h),

                HsButton(
                  width: double.infinity,
                  height: 50.h,
                  onTap: () {
                    //? go onboarding page
                    context.go("/onboarding");
                  },
                  child: const txt('ورود به حساب'),
                ),
                SizedBox(height: 24.h),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: context.colorScheme.outlineVariant),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text('یا', style: context.textTheme.bodySmall),
                    ),
                    Expanded(
                      child: Divider(color: context.colorScheme.outlineVariant),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.g_mobiledata,
                        size: 24.sp,
                        color: context.colorScheme.onSurface,
                      ),
                      SizedBox(width: 8.w),
                      const txt('ورود با گوگل'),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    txt(
                      'حساب کاربری ندارید؟',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(width: 4.w),

                    GestureDetector(
                      onTap: () {
                        //? go to register page
                        context.go("/register");
                      },
                      child: txt(
                        'ایجاد حساب',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
