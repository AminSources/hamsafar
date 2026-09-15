import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.check, size: 50.sp, color: Colors.white),
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
              HsContainer(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                color: context.colorScheme.surface,
                radius: 16.r,
                child: Column(
                  children: [
                    //* label
                    txt(
                      'کد دعوت سفر',
                      size: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(height: 12.h),

                    //* code display
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: context.colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.copy_outlined,
                            size: 20.sp,
                            color: context.colorScheme.primary,
                          ),
                          SizedBox(width: 10.w),
                          txt(
                            'HMS-84Z2K',
                            size: 22.sp,
                            fontWeight: FontWeight.w900,
                            color: context.colorScheme.onPrimaryContainer,
                            fontFamily: 'vazirmatn',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              //* share button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.share, size: 20.sp, color: Colors.white),
                  label: txt(
                    'اشتراک‌گذاری کد دعوت',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    size: 14.sp,
                  ),
                ),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: txt(
                      'با وارد کردن این کد در «جستجوی سفر»، دوستان می‌توانند درخواست عضویت بدهند',
                      size: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onSurfaceVariant,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
