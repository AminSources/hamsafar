import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/app_bar_widget.dart';
import 'package:hamsafar/core/widgets/avatar_icon_widget.dart';
import 'package:hamsafar/core/widgets/text_field_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/enums/chip_mode.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              //* app bar
              AppBarWidget(
                title: "تکمیل پروفایل",
                hasBackButton: true,
                hasChip: true,
                chipMode: ChipMode.warning,
              ),

              SizedBox(height: 30.h),

              //* profile avatar
              AvatarIconWidget(
                width: 100.w,
                height: 100.w,
                isCircle: true,
                icon: Icons.person_outline_rounded,
              ),

              SizedBox(height: 10.h),

              //* profile description
              txt("افزودن تصویر پروفایل (اختیاری)"),

              SizedBox(height: 20.h),

              //* name field
              TextFieldWidget(title: "نام نمایشی *", hintText: "محمدامین"),

              SizedBox(height: 20.h),

              //* user name field
              TextFieldWidget(title: "شناسه کاربری *", hintText: "m_amin"),

              SizedBox(height: 20.h),

              //* about me field
              TextFieldWidget(title: "درباره من (اختیاری)", maxLines: 2),

              SizedBox(height: 20.h),

              //* start button
              ElevatedButton(
                onPressed: () {
                  //? push home page
                  Navigator.pushNamed(context, "/home");
                },
                child: txt("شروع"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
