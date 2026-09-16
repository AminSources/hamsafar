import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/widgets/invite_code_card.dart';

class TripSuccessPage extends StatelessWidget {
  const TripSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              //* spacer top
              SizedBox(height: 40.h),

              //* success icon circle
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: context.verticalGradient,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_rounded,
                  size: 50.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24.h),

              //* title
              txt(
                'سفر شما ایجاد شد! 🎉',
                size: 20.sp,
                fontWeight: FontWeight.w900,
                color: context.colorScheme.onSurface,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),

              //* description
              txt(
                'شما لیدر سفر «سفر جنگل‌گردی شمال» هستید. پس از پذیرش اعضا، مراحل هماهنگی (رای‌گیری، وظایف و تقسیم بودجه) آغاز می‌شود.',
                size: 13.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurfaceVariant,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),

              //* invite code card
              InviteCodeCard(),
              SizedBox(height: 24.h),

              //* share button
              HsButton(child: txt('اشتراک‌گذاری کد دعوت'), onTap: () {}),
              SizedBox(height: 12.h),

              //* go home button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton(
                  onPressed: () {
                    context.go("/main-wrapper");
                  },
                  child: txt(
                    'رفتن به خانه',
                    fontWeight: FontWeight.w800,
                    size: 14.sp,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              //* hint text
              HsNote(
                note:
                    'با وارد کردن این کد در «جستجوی سفر»، دوستان می‌توانند درخواست عضویت بدهند',
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
