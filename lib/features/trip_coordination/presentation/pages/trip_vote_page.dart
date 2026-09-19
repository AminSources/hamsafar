import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripVotePage extends StatelessWidget {
  const TripVotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: const HsAppBar(
                  title: 'رای‌گیری سفر فعال',
                  hasBack: true,
                ),
              ),

              SizedBox(height: 16.h),

              //* question title
              txt('زمان حرکت کی باشد؟ ⏰', style: context.textTheme.titleLarge),

              SizedBox(height: 8.h),

              //* voting status info
              txt(
                'رای‌گیری پس از بسته شدن عضوگیری شروع شد · ۵ ساعت تا پایان',
                style: context.textTheme.bodySmall,
                color: context.colorScheme.onSurfaceVariant,
              ),

              SizedBox(height: 24.h),

              //* option 1 - 07:00 (selected with 67%)
              HsContainer(
                radius: 16.r,
                color: context.colorScheme.primaryContainer,
                borderColor: context.colorScheme.primary,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* option time and icon
                    Row(
                      children: [
                        Icon(
                          Icons.wb_twilight,
                          size: 20.sp,
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                        SizedBox(width: 8.w),
                        txt(
                          '۰۷:۰۰ صبح',
                          style: context.textTheme.titleMedium,
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                        const Spacer(),
                        //* selected badge
                        txt(
                          'رای شما',
                          style: context.textTheme.labelSmall,
                          color: context.colorScheme.primary,
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    //* vote count and percentage
                    Row(
                      children: [
                        txt(
                          '۴ رای از ۶ عضو',
                          style: context.textTheme.bodySmall,
                        ),
                        const Spacer(),
                        txt(
                          '۶۷٪',
                          style: context.textTheme.labelMedium,
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    //* progress bar
                    HsContainer(
                      height: 8.h,
                      radius: 999.r,
                      color: context.colorScheme.surfaceContainerHigh,
                      borderColor: Colors.transparent,
                      child: FractionallySizedBox(
                        widthFactor: 0.67,
                        child: HsContainer(
                          radius: 999.r,
                          gradient: context.horizontalGradient,
                          borderColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              //* option 2 - 08:30 (17%)
              HsContainer(
                radius: 16.r,
                color: context.colorScheme.surfaceContainer,
                borderColor: context.colorScheme.outline,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* option time
                    Row(
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          size: 20.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 8.w),
                        txt('۰۸:۳۰ صبح', style: context.textTheme.titleMedium),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    //* vote count and percentage
                    Row(
                      children: [
                        txt(
                          '۱ رای از ۶ عضو',
                          style: context.textTheme.bodySmall,
                        ),
                        const Spacer(),
                        txt(
                          '۱۷٪',
                          style: context.textTheme.labelMedium,
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    //* progress bar
                    HsContainer(
                      height: 8.h,
                      radius: 999.r,
                      color: context.colorScheme.surfaceContainerHigh,
                      borderColor: Colors.transparent,
                      child: FractionallySizedBox(
                        widthFactor: 0.17,
                        child: HsContainer(
                          radius: 999.r,
                          color: context.colorScheme.onSurfaceVariant,
                          borderColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              //* option 3 - 09:00 (16%)
              HsContainer(
                radius: 16.r,
                color: context.colorScheme.surfaceContainer,
                borderColor: context.colorScheme.outline,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* option time
                    Row(
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          size: 20.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 8.w),
                        txt('۰۹:۰۰ صبح', style: context.textTheme.titleMedium),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    //* vote count and percentage
                    Row(
                      children: [
                        txt(
                          '۱ رای از ۶ عضو',
                          style: context.textTheme.bodySmall,
                        ),
                        const Spacer(),
                        txt(
                          '۱۶٪',
                          style: context.textTheme.labelMedium,
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    //* progress bar
                    HsContainer(
                      height: 8.h,
                      radius: 999.r,
                      color: context.colorScheme.surfaceContainerHigh,
                      borderColor: Colors.transparent,
                      child: FractionallySizedBox(
                        widthFactor: 0.16,
                        child: HsContainer(
                          radius: 999.r,
                          color: context.colorScheme.onSurfaceVariant,
                          borderColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              //* submit vote button
              HsButton(
                width: double.infinity,
                child: txt(
                  'ثبت رای برای «۰۷:۰۰»',
                  style: context.textTheme.labelLarge,
                  color: context.colorScheme.onPrimary,
                ),
              ),

              SizedBox(height: 16.h),

              //* info note
              HsContainer(
                radius: 14.r,
                color: context.colorScheme.tertiaryContainer,
                borderColor: Colors.transparent,
                padding: EdgeInsets.all(12.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 18.sp,
                      color: context.colorScheme.onTertiaryContainer,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: txt(
                        'زمان سفر با بیشترین رای تعیین و به همه اعضا اعلام می‌شود',
                        style: context.textTheme.bodySmall,
                        color: context.colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
