import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_info_box.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_avatar_stack.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeTripCard extends StatelessWidget {
  final bool isInTrip;

  const HomeTripCard({super.key, required this.isInTrip});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      color: context.colorScheme.surface,
      radius: 20.r,
      onTap: () {
        //? push to trip details page
        context.push('/trip-detail');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* status chips
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              HsBadge(
                label: isInTrip ? '🚗 در حال سفر' : 'در حال آماده‌سازی',
                backgroundColor: context.colorScheme.surfaceContainerHigh,
                foregroundColor: context.colorScheme.onSurface,
              ),
              isInTrip
                  ? HsBadge(
                      label: 'موقعیت فعال',
                      backgroundColor: context.colorScheme.surfaceContainer,
                      foregroundColor: context.colorScheme.onSurface,
                      icon: Icons.my_location,
                    )
                  : HsBadge(
                      label: '۳ روز مانده',
                      backgroundColor: context.colorScheme.secondary,
                      foregroundColor: context.colorScheme.onSecondary,
                    ),
            ],
          ),
          SizedBox(height: 14.h),

          //* trip title
          txt('سفر جنگل‌گردی شمال 🌲', style: context.textTheme.headlineSmall),
          SizedBox(height: 5.h),

          //* trip location
          Row(
            children: [
              Icon(
                LucideIcons.mapPin,
                size: 15.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: txt(
                  isInTrip
                      ? 'اقامتگاه بوم‌گردی، کلاردشت'
                      : 'جاده چالوس، آبشار شکرآب',
                  style: context.textTheme.bodySmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          //* trip info
          HsInfoBox(
            labels: isInTrip
                ? ["تاریخ", "زمان برگشت", "اعضا"]
                : ["تاریخ", "زمان حرکت", "اعضا"],
            values: ["۱۵ تا ۱۷ اردیبهشت", "۰۷:۰۰", '۶ نفر'],
          ),
          SizedBox(height: 16.h),

          //* divider
          Divider(color: Colors.white24, height: 1),
          SizedBox(height: 14.h),

          //* members profiles stack
          HomeAvatarStack(),
        ],
      ),
    );
  }
}
