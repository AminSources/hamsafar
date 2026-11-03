import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripSuccessPage extends StatelessWidget {
  final int? tripId;

  const TripSuccessPage({super.key, this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 40.h),
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
              txt(
                'سفر شما ایجاد شد! 🎉',
                size: 20.sp,
                fontWeight: FontWeight.w900,
                color: context.colorScheme.onSurface,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              txt(
                'اطلاعات سفر ذخیره شد. می‌توانید جزئیات آن را مشاهده و مدیریت کنید.',
                size: 13.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurfaceVariant,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              HsButton(
                onTap: () => context.go(
                  '/trip-detail',
                  extra: tripId,
                ),
                child: txt(
                  'مشاهده جزئیات سفر',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton(
                  onPressed: () => context.go('/main-wrapper'),
                  child: txt(
                    'رفتن به خانه',
                    fontWeight: FontWeight.w800,
                    size: 14.sp,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const HsNote(
                note: 'دوستانی که انتخاب کرده‌اید، پس از ایجاد سفر دعوت‌نامه دریافت می‌کنند.',
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
