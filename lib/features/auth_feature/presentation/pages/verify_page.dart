import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/app_bar_widget.dart';
import 'package:hamsafar/core/widgets/avatar_icon_widget.dart';
import 'package:hamsafar/core/widgets/note_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              //* appbar
              AppBarWidget(title: "تایید ایمیل", hasBackButton: true),

              //* space
              SizedBox(height: 10.h),

              //* avatar
              AvatarIconWidget(
                width: 80.w,
                height: 80.w,
                icon: Icons.mark_email_unread_rounded,
                iconColor: context.colorScheme.secondary,
                backgroundColor: context.colorScheme.secondaryContainer,
              ),

              //* space
              SizedBox(height: 20.h),

              //* title
              txt(
                "کد تایید را وارد کنید",
                fontWeight: FontWeight.bold,
                style: context.textTheme.bodyLarge,
              ),

              //* space
              SizedBox(height: 15.h),

              //* subtitle
              Row(
                mainAxisAlignment: .center,
                textDirection: TextDirection.rtl,
                children: [
                  txt(
                    " کد ۶ رقمی به ایمیل",
                    style: context.textTheme.bodyMedium,
                  ),
                  txt(
                    "example@gmail.com",
                    color: context.colorScheme.primary,
                    style: context.textTheme.bodyMedium,
                  ),
                  txt(".ارسال شد "),
                ],
              ),

              //* space
              SizedBox(height: 20.h),

              //* code input
              Row(
                spacing: 10.w,
                children: List.generate(6, (index) {
                  return Expanded(
                    child: TextField(
                      maxLength: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                    ),
                  );
                }),
              ),

              //* space
              SizedBox(height: 20.h),

              //* Auth Button
              ElevatedButton(
                onPressed: () {
                  //? push to onboarding page
                  Navigator.pushNamed(context, "/onboarding");
                },
                child: txt("تایید"),
              ),

              //* space
              SizedBox(height: 10.h),

              //* dont receive code text
              Row(
                mainAxisAlignment: .center,
                textDirection: .rtl,
                children: [
                  txt("کد را دریافت نکردید؟"),
                  TextButton(onPressed: () {}, child: txt("ارسال مجدد")),
                ],
              ),

              //* space
              SizedBox(height: 10.h),

              //* auth note
              NoteWidget(
                noteIcon: Icons.info_outline_rounded,
                noteText:
                    ".اگر ایمیل را در اینباکس نمی بینید، پوشه اسپم را بررسی کنید",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
