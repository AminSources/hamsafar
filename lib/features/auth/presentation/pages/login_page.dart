import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/features/auth/domain/params/sign_in_params.dart';
import 'package:hamsafar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            //? unfocus text field when tap anywhere of page
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailed) {
                  context.showHsSnackBar(text: state.message);
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),

                      HsAvatar(
                        size: 60.w,
                        label: Icon(LucideIcons.backpack, size: 34.sp),
                      ),
                      SizedBox(height: 16.h),

                      txt(
                        'خوش برگشتی! 👋',
                        style: context.textTheme.headlineLarge,
                      ),

                      SizedBox(height: 8.h),

                      txt(
                        'برای ادامه هماهنگی سفرها وارد حسابت شو',
                        style: context.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 32.h),

                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        decoration: const InputDecoration(
                          hintText: 'ایمیل',
                          prefixIcon: Icon(LucideIcons.mail),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا ایمیل خود را وارد کنید';
                          }
                          if (!value.contains("@")) {
                            return "ایمیل نامعتبر است";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      TextFormField(
                        obscureText: _obscureText,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'رمز عبور',
                          prefixIcon: const Icon(LucideIcons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? LucideIcons.eyeClosed
                                  : LucideIcons.eye,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            onPressed: () =>
                                setState(() => _obscureText = !_obscureText),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "لطفا گذرواژه خود را وارد کنید";
                          }
                          if (value.length < 8) {
                            return "ارقام گذرواژه نمیتواند کمتر از 8 باشد";
                          }
                          return null;
                        },
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
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              LoginEvent(
                                SignInParams(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: state is AuthLoading
                            ? CircularProgressIndicator()
                            : const txt('ورود به حساب'),
                      ),
                      SizedBox(height: 24.h),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: context.colorScheme.outlineVariant,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'یا',
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: context.colorScheme.outlineVariant,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      HsButton(
                        onTap: () {},
                        hsButtonType: HsButtonType.outline,
                        child: Row(
                          spacing: 12.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/assets/images/google_icon.png",
                              width: 24.w,
                              height: 24.w,
                              fit: BoxFit.fill,
                            ),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
