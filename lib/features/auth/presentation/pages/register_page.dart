import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/features/auth/domain/params/sign_up_params.dart';
import 'package:hamsafar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agreedToTerms = true;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            _confirmPasswordFocusNode.unfocus();
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
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'رمز عبور',
                          prefixIcon: Icon(LucideIcons.lock),
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
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocusNode,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'تأیید رمز عبور',
                          prefixIcon: Icon(LucideIcons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "لطفا گذرواژه خود را وارد کنید";
                          }
                          if (value != _passwordController.text) {
                            return "گذرواژه صحیح نیست";
                          }
                          if (value.length < 8) {
                            return "ارقام گذرواژه نمیتواند کمتر از 8 باشد";
                          }
                          return null;
                        },
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
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
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
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SignUpEvent(
                                SignUpParams(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: state is AuthLoading
                            ? CircularProgressIndicator()
                            : const txt("ایجاد حساب کاربری"),
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
                            child: txt(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
