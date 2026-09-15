import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsSearchPage extends StatelessWidget {
  const FriendsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* search input section
        TextField(
          decoration: InputDecoration(
            hintText: 'جستجوی نام کاربری...',
            prefixIcon: Icon(
              Icons.search,
              size: 20.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),

        SizedBox(height: 16.h),

        //* search results section
        Column(
          spacing: 12.h,
          children: List.generate(2, (index) {
            return HsContainer(
              padding: EdgeInsets.all(16.w),
              radius: 16.r,
              color: context.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //* avatar
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: AppColors.avatars[index + 1],
                        child: txt(
                          ['ن', 'ن'][index],
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          size: 18.sp,
                        ),
                      ),

                      SizedBox(width: 12.w),

                      //* friend info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* name
                            txt(
                              ['نگار احمدی', 'نیلوفر نادری'][index],
                              fontWeight: FontWeight.w800,
                              size: 14.sp,
                            ),

                            SizedBox(height: 4.h),

                            //* username and stats
                            Row(
                              children: [
                                txt(
                                  ['@negar_a', '@negar_n'][index],
                                  color: context.colorScheme.onSurfaceVariant,
                                  size: 11.sp,
                                ),

                                SizedBox(width: 12.w),

                                //* mutual friends
                                Icon(
                                  Icons.people_outline_rounded,
                                  size: 14.sp,
                                  color: context.colorScheme.onSurfaceVariant,
                                ),

                                SizedBox(width: 4.w),

                                txt(
                                  ['۳ دوست مشترک', '۱ دوست مشترک'][index],
                                  color: context.colorScheme.onSurfaceVariant,
                                  size: 11.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //* rating
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 14.sp,
                            color: context.colorScheme.secondary,
                          ),
                          SizedBox(width: 4.w),
                          txt(
                            ['۴.۹', '۴.۳'][index],
                            color: context.colorScheme.onSurfaceVariant,
                            size: 11.sp,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  //* action button
                  if (index == 0)
                    HsButton(
                      width: double.infinity,
                      height: 40.h,
                      child: txt(
                        'ارسال درخواست دوستی',
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                        size: 12.sp,
                      ),
                    )
                  else
                    HsContainer(
                      width: double.infinity,
                      height: 40.h,
                      radius: 12.r,
                      color: context.colorScheme.surfaceContainer,
                      child: Center(
                        child: txt(
                          'درخواست ارسال شده',
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                          size: 12.sp,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
