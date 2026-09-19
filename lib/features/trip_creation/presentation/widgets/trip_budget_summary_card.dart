import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripBudgetSummaryCard extends StatelessWidget {
  const TripBudgetSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
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
    );
  }
}
