import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/auth_feature/presentation/widgets/onboarding_header.dart';
import 'package:hamsafar/features/auth_feature/presentation/widgets/onboarding_profile_avatar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
                //* header
                OnboardingHeader(),
                SizedBox(height: 32.h),

                //* profile avatar
                OnboardingProfileAvatar(),
                SizedBox(height: 32.h),

                //* name field
                TextFormField(
                  focusNode: nameFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'نام و نام خانوادگی',
                    prefixIcon: Icon(LucideIcons.userRound),
                  ),
                ),
                SizedBox(height: 16.h),

                //* user name field
                TextFormField(
                  focusNode: userNameFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'نام کاربری',
                    prefixIcon: Icon(LucideIcons.atSign),
                  ),
                ),
                SizedBox(height: 16.h),

                //* bio field
                TextFormField(
                  focusNode: bioFocusNode,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'چند خط درباره خودت و سبک سفر کردنت بنویس...',
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(height: 40.h),

                //* continue button
                HsButton(
                  onTap: () {
                    //? go home page
                    context.go("/main-wrapper");
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
