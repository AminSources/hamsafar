import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripTasksPage extends StatelessWidget {
  const TripTasksPage({super.key});

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
                child: const HsAppBar(title: 'وظایف سفر', hasBack: true),
              ),

              SizedBox(height: 16.h),

              //* progress section
              Row(
                children: [
                  //* progress indicator
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        //* background circle
                        SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            value: 0.5,
                            strokeWidth: 3.w,
                            backgroundColor:
                                context.colorScheme.surfaceContainerHigh,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        //* percentage text
                        txt(
                          '۵۰٪',
                          style: context.textTheme.labelSmall,
                          size: 8.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  //* progress text
                  txt('۲ از ۴ انجام شد', style: context.textTheme.titleSmall),
                ],
              ),

              SizedBox(height: 24.h),

              //* task 1 - completed (accommodation booking)
              HsContainer(
                radius: 16.r,
                color: AppColors.successContainer,
                borderColor: Colors.transparent,
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* task header
                    Row(
                      children: [
                        //* check icon
                        HsContainer(
                          width: 28.w,
                          height: 28.w,
                          radius: 999.r,
                          color: AppColors.success,
                          borderColor: Colors.transparent,
                          child: Icon(
                            Icons.check,
                            size: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        //* task title
                        Expanded(
                          child: txt(
                            'رزرو اقامتگاه بوم‌گردی',
                            style: context.textTheme.titleSmall,
                            color: AppColors.onSuccessContainer,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.onSuccessContainer,
                          ),
                        ),
                        //* completed badge
                        HsContainer(
                          radius: 6.r,
                          color: AppColors.success,
                          borderColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          child: txt(
                            'انجام شد',
                            style: context.textTheme.labelSmall,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    //* assigned to
                    Row(
                      children: [
                        //* avatar
                        CircleAvatar(
                          radius: 10.r,
                          backgroundColor: AppColors.avatars[0],
                          child: txt(
                            'س',
                            color: Colors.white,
                            size: 8.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        txt(
                          'سارا محمدی (لیدر)',
                          style: context.textTheme.bodySmall,
                          color: AppColors.onSuccessContainer,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //* task 2 - completed (breakfast purchase)
              HsContainer(
                radius: 16.r,
                color: AppColors.successContainer,
                borderColor: Colors.transparent,
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* task header
                    Row(
                      children: [
                        //* check icon
                        HsContainer(
                          width: 28.w,
                          height: 28.w,
                          radius: 999.r,
                          color: AppColors.success,
                          borderColor: Colors.transparent,
                          child: Icon(
                            Icons.check,
                            size: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        //* task title
                        Expanded(
                          child: txt(
                            'خرید صبحانه روز اول',
                            style: context.textTheme.titleSmall,
                            color: AppColors.onSuccessContainer,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.onSuccessContainer,
                          ),
                        ),
                        //* completed badge
                        HsContainer(
                          radius: 6.r,
                          color: AppColors.success,
                          borderColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          child: txt(
                            'انجام شد',
                            style: context.textTheme.labelSmall,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    //* assigned to
                    Row(
                      children: [
                        //* avatar
                        CircleAvatar(
                          radius: 10.r,
                          backgroundColor: AppColors.avatars[3],
                          child: txt(
                            'ع',
                            color: Colors.white,
                            size: 8.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        txt(
                          'علی کریمی',
                          style: context.textTheme.bodySmall,
                          color: AppColors.onSuccessContainer,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //* task 3 - pending (bring stove)
              HsContainer(
                radius: 16.r,
                color: context.colorScheme.surfaceContainer,
                borderColor: context.colorScheme.outline,
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* task header
                    Row(
                      children: [
                        //* pending icon
                        HsContainer(
                          width: 28.w,
                          height: 28.w,
                          radius: 999.r,
                          color: context.colorScheme.secondaryContainer,
                          borderColor: context.colorScheme.outline,
                          child: Icon(
                            Icons.local_fire_department_outlined,
                            size: 16.sp,
                            color: context.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        //* task title
                        Expanded(
                          child: txt(
                            'همراه آوردن اجاق گاز',
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    //* assigned to
                    Row(
                      children: [
                        //* avatar
                        CircleAvatar(
                          radius: 10.r,
                          backgroundColor: AppColors.avatars[1],
                          child: txt(
                            'م',
                            color: Colors.white,
                            size: 8.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        txt('مهدی رضایی', style: context.textTheme.bodySmall),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    //* based on items note
                    Row(
                      children: [
                        Icon(
                          Icons.backpack_outlined,
                          size: 12.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        txt(
                          'بر اساس «وسایل من»',
                          style: context.textTheme.labelSmall,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //* task 4 - pending (bring first aid kit)
              HsContainer(
                radius: 16.r,
                color: context.colorScheme.surfaceContainer,
                borderColor: context.colorScheme.outline,
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* task header
                    Row(
                      children: [
                        //* pending icon
                        HsContainer(
                          width: 28.w,
                          height: 28.w,
                          radius: 999.r,
                          color: context.colorScheme.secondaryContainer,
                          borderColor: context.colorScheme.outline,
                          child: Icon(
                            Icons.medical_services_outlined,
                            size: 16.sp,
                            color: context.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        //* task title
                        Expanded(
                          child: txt(
                            'همراه آوردن جعبه کمک‌های اولیه',
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    //* assigned to
                    Row(
                      children: [
                        //* avatar
                        CircleAvatar(
                          radius: 10.r,
                          backgroundColor: AppColors.avatars[2],
                          child: txt(
                            'ن',
                            color: Colors.white,
                            size: 8.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        txt('نگار احمدی', style: context.textTheme.bodySmall),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    //* based on items note
                    Row(
                      children: [
                        Icon(
                          Icons.backpack_outlined,
                          size: 12.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        txt(
                          'بر اساس «وسایل من»',
                          style: context.textTheme.labelSmall,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              //* add new task button (leader only)
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: context.colorScheme.primary),
                  ),
                  icon: Icon(
                    Icons.add_task,
                    size: 18.sp,
                    color: context.colorScheme.primary,
                  ),
                  label: txt(
                    'تعیین وظیفه جدید (لیدر)',
                    style: context.textTheme.labelLarge,
                    color: context.colorScheme.primary,
                  ),
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
                        'لیدر پس از بسته شدن عضوگیری، مسئولیت‌ها را با توجه به پروفایل و «وسایل من» هر عضو تعیین می‌کند تا کسی زیر بار مسئولیت نرود.',
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
