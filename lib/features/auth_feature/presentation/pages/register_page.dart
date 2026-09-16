import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agreedToTerms = true;

  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

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
            confirmPasswordFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                txt(
                  'ایجاد حساب کاربری',
                  style: context.textTheme.headlineLarge,
                ),
                SizedBox(height: 8.h),
                txt(
                  'با ایمیل خودت در چند ثانیه ثبت‌نام کن',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 32.h),

                TextFormField(
                  focusNode: emailFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'ایمیل',
                    prefixIcon: Icon(LucideIcons.mail),
                  ),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  focusNode: passwordFocusNode,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'رمز عبور',
                    prefixIcon: Icon(LucideIcons.lock),
                  ),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  focusNode: confirmPasswordFocusNode,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'تأیید رمز عبور',
                    prefixIcon: Icon(LucideIcons.lock),
                  ),
                ),
                SizedBox(height: 24.h),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Checkbox(
                        value: _agreedToTerms,
                        onChanged: (val) =>
                            setState(() => _agreedToTerms = val ?? false),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          children: [
                            const TextSpan(text: 'شرایط استفاده'),
                            TextSpan(
                              text: ' و ',
                              style: TextStyle(
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            const TextSpan(text: 'حریم خصوصی'),
                            TextSpan(
                              text: ' همسفر را مطالعه کرده و می‌پذیرم.',
                              style: TextStyle(
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                HsButton(
                  width: double.infinity,
                  height: 50.h,
                  onTap: () {
                    //? go onboarding page
                    context.go("/onboarding");
                  },
                  child: const txt('ایجاد حساب کاربری'),
                ),
                SizedBox(height: 24.h),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: context.colorScheme.outlineVariant),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: txt('یا', style: context.textTheme.bodySmall),
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
                      const txt('ایجاد حساب با گوگل'),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    txt(
                      'حساب کاربری دارید؟',
                      style: context.textTheme.bodyMedium,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        //? go to login page
                        context.go("/login");
                      },
                      child: txt(
                        'وارد شوید',
                        style: context.textTheme.labelMedium,
                        color: context.colorScheme.primary,
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
