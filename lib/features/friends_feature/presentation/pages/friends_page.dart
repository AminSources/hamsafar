import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: List.generate(
        4,
        (index) => InkWell(
          onTap: () {
            //? push to friend profile page
            context.push("/friend-profile");
          },
          child: HsContainer(
            padding: EdgeInsets.all(16.w),
            radius: 16.r,
            color: context.colorScheme.surface,
            child: Row(
              children: [
                //* avatar
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.avatars[index % 6],
                  child: txt(
                    ['م', 'ن', 'ع', 'ا'][index],
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
                        [
                          'مهدی رضایی',
                          'نگار احمدی',
                          'علی کریمی',
                          'الناز شریفی',
                        ][index],
                        fontWeight: FontWeight.w800,
                        size: 14.sp,
                      ),

                      SizedBox(height: 4.h),

                      //* username and stats
                      Row(
                        children: [
                          txt(
                            [
                              '@mahdi_r',
                              '@negar_a',
                              '@ali_k',
                              '@elnaz_sh',
                            ][index],
                            color: context.colorScheme.onSurfaceVariant,
                            size: 11.sp,
                          ),

                          SizedBox(width: 12.w),

                          //* rating
                          Icon(
                            Icons.star_rounded,
                            size: 14.sp,
                            color: context.colorScheme.secondary,
                          ),

                          SizedBox(width: 4.w),

                          txt(
                            ['۴.۸', '۴.۹', '۴.۶', '۴.۵'][index],
                            color: context.colorScheme.onSurfaceVariant,
                            size: 11.sp,
                          ),

                          SizedBox(width: 12.w),

                          //* trips count
                          Icon(
                            Icons.trip_origin_rounded,
                            size: 14.sp,
                            color: context.colorScheme.onSurfaceVariant,
                          ),

                          SizedBox(width: 4.w),

                          txt(
                            ['۱۲ سفر', '۸ سفر', '۵ سفر', '۲ سفر'][index],
                            color: context.colorScheme.onSurfaceVariant,
                            size: 11.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //* remove button
                HsContainer(
                  width: 36.w,
                  height: 36.w,
                  radius: 10.r,
                  onTap: () {},
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: context.colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
