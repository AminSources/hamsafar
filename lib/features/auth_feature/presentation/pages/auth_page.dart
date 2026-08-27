import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/avatar_icon_widget.dart';
import 'package:hamsafar/core/widgets/note_widget.dart';
import 'package:hamsafar/core/widgets/text_field_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/auth_feature/presentation/widgets/auth_footer_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              //* logo
              AvatarIconWidget(
                width: 75.w,
                height: 75.w,
                icon: Icons.train_rounded,
                iconSize: 40.sp,
              ),

              //* space
              SizedBox(height: 20.h),

              //* title
              txt("همسفر", style: context.textTheme.displayLarge),

              //* space
              SizedBox(height: 10.h),

              //* subtitle
              txt("ورود به حساب کاربری", style: context.textTheme.bodyLarge),

              //* space
              SizedBox(height: 20.h),

              //* email field
              TextFieldWidget(title: "ایمیل", hintText: "example@gmail.com"),

              //* space
              SizedBox(height: 20.h),

              //* continue button
              ElevatedButton(onPressed: () {}, child: txt("ادامه")),

              //* space
              SizedBox(height: 20.h),

              //* footer
              AuthFooterWidget(),

              //* space
              SizedBox(height: 20.h),

              //* footer note
              NoteWidget(
                noteText:
                    "همسفر فقط از ایمیل برای استفاده از کد تایید استفاده میکند، رمز عبور وجود ندارد",
                noteIcon: Icons.lock_outline_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
