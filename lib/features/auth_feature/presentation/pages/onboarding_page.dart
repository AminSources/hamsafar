import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final FocusNode nameFocusNode;
  late final FocusNode userNameFocusNode;
  late final FocusNode bioFocusNode;

  @override
  void initState() {
    nameFocusNode = FocusNode();
    userNameFocusNode = FocusNode();
    bioFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    userNameFocusNode.dispose();
    bioFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            //? unfocus text field when tap anywhere of page
            nameFocusNode.unfocus();
            userNameFocusNode.unfocus();
            bioFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: txt(
                    'پروفایلت رو کامل کن ✨',
                    style: context.textTheme.headlineLarge,
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: txt(
                    'این اطلاعات به دوستانت کمک می‌کند تو را پیدا کنند',
                    style: context.textTheme.bodyMedium,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 32.h),

                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: context.colorScheme.primaryContainer,
                        child: Icon(
                          Icons.person,
                          size: 50.sp,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.colorScheme.surface,
                              width: 2.w,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 20.sp,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                TextFormField(
                  focusNode: nameFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'نام و نام خانوادگی',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(height: 16.h),

                TextFormField(
                  focusNode: userNameFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'نام کاربری',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                SizedBox(height: 16.h),

                TextFormField(
                  focusNode: bioFocusNode,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'چند خط درباره خودت و سبک سفر کردنت بنویس...',
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(height: 40.h),

                HsButton(
                  onTap: () {
                    //? go home page
                    context.go("/home");
                  },
                  child: const txt('ادامه'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
