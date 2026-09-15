import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripBudgetPage extends StatelessWidget {
  const TripBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //* budget summary card
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            color: context.colorScheme.surface,
            radius: 16.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* total cost
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    txt(
                      'هزینه تخمینی کل سفر',
                      size: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onSurface,
                    ),
                    txt(
                      '۲٬۷۰۰٬۰۰۰ تومان',
                      size: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: context.colorScheme.primary,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Divider(color: context.colorScheme.outlineVariant, height: 1),
                SizedBox(height: 12.h),

                //* grid of stats
                Row(
                  children: [
                    //* members count
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt(
                            'تعداد نفرات',
                            size: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(height: 4.h),
                          txt(
                            '۶ نفر',
                            size: 13.sp,
                            fontWeight: FontWeight.w800,
                            color: context.colorScheme.onSurface,
                          ),
                        ],
                      ),
                    ),
                    //* per person share
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt(
                            'سهم هر نفر',
                            size: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(height: 4.h),
                          txt(
                            '۴۵۰٬۰۰۰ ت',
                            size: 13.sp,
                            fontWeight: FontWeight.w800,
                            color: context.colorScheme.onSurface,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                //* received row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    txt(
                      'دریافت‌شده',
                      size: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    txt(
                      '۰ ت',
                      size: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: context.colorScheme.onSurface,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                //* progress bar
                Container(
                  height: 6.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerRight,
                    widthFactor: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          //* total estimated cost input
          txt(
            'هزینه تخمینی کل',
            size: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '۲٬۷۰۰٬۰۰۰',
              prefixIcon: Icon(Icons.money_rounded),
            ),
          ),
          SizedBox(height: 16.h),

          //* per person input
          txt(
            'دریافتی هر نفر',
            size: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '۴۵۰٬۰۰۰',
              prefixIcon: Icon(Icons.money_rounded),
            ),
          ),
          SizedBox(height: 20.h),

          //* cost items title
          txt(
            'آیتم‌های هزینه',
            size: 13.sp,
            fontWeight: FontWeight.w800,
            color: context.colorScheme.onSurface,
          ),
          SizedBox(height: 12.h),

          //* cost chips
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              //* park entry chip
              HsContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                color: context.colorScheme.primaryContainer,
                borderColor: context.colorScheme.primaryContainer,
                radius: 999.r,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.park_outlined,
                      size: 16.sp,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 6.w),
                    txt(
                      'ورودی پارک ملی',
                      size: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.close,
                      size: 14.sp,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
              //* fuel chip
              HsContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                color: context.colorScheme.primaryContainer,
                borderColor: context.colorScheme.primaryContainer,
                radius: 999.r,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    txt(
                      '⛽ سوخت',
                      size: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.close,
                      size: 14.sp,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
              //* accommodation chip
              HsContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                color: context.colorScheme.primaryContainer,
                borderColor: context.colorScheme.primaryContainer,
                radius: 999.r,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    txt(
                      '🏕 اقامت',
                      size: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.close,
                      size: 14.sp,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
              //* food chip
              HsContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                color: context.colorScheme.primaryContainer,
                borderColor: context.colorScheme.primaryContainer,
                radius: 999.r,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    txt(
                      '🍕 خوراک',
                      size: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.close,
                      size: 14.sp,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
              //* toll chip
              HsContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                color: context.colorScheme.primaryContainer,
                borderColor: context.colorScheme.primaryContainer,
                radius: 999.r,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    txt(
                      '🛣 عوارض مسیر',
                      size: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.close,
                      size: 14.sp,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
              //* add chip
              HsContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                color: Colors.transparent,
                borderColor: context.colorScheme.outline,
                radius: 999.r,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 16.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 4.w),
                    txt(
                      'افزودن',
                      size: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          //* info note
          HsContainer(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            color: context.colorScheme.secondaryContainer,
            borderColor: context.colorScheme.secondary,
            radius: 10.r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 18.sp,
                  color: context.colorScheme.onSecondaryContainer,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: txt(
                    'هزینه تخمینی بر اساس سفرهای مشابه قبلی شما محاسبه شده است. بودجه قبل از سفر دریافت و در صورت اضافه آمدن، به هر نفر بازگردانده می‌شود.',
                    size: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
