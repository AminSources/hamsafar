import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class BudgetSummaryCard extends StatelessWidget {
  const BudgetSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(20.w),
      radius: 20.r,
      color: context.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* total budget
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              txt(
                'بودجه کل سفر',
                size: 12.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              txt(
                '۲,۷۰۰,۰۰۰ تومان',
                size: 12.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),

          SizedBox(height: 12.h),

          //* share per person
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              txt(
                'سهم هر نفر',
                size: 12.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              txt('۴۵۰,۰۰۰ ت', size: 12.5.sp, fontWeight: FontWeight.w700),
            ],
          ),

          SizedBox(height: 12.h),

          //* divider
          Divider(color: context.colorScheme.outlineVariant, height: 1),

          SizedBox(height: 12.h),

          //* received amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              txt(
                'دریافت‌شده',
                size: 12.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 16.sp,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: 4.w),
                  txt(
                    '۱,۸۰۰,۰۰۰ ت',
                    size: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 8.h),

          //* remaining amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              txt(
                'باقی‌مانده',
                size: 12.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              Row(
                children: [
                  Icon(
                    Icons.pending_actions_rounded,
                    size: 16.sp,
                    color: context.colorScheme.error,
                  ),
                  SizedBox(width: 4.w),
                  txt(
                    '۹۰۰,۰۰۰ ت',
                    size: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.error,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
