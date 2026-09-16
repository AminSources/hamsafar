import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_action_cards_row.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_activities.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_trip_card.dart';
import 'package:hamsafar/core/widgets/section_header.dart';

enum HomeTripStatus { preparing, inTrip }

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.status = HomeTripStatus.preparing});

  final HomeTripStatus status;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool get _isInTrip => widget.status == HomeTripStatus.preparing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              HsAppBar(
                title: _isInTrip ? 'سفر خوبی داشته باشی!' : 'سلام، سارا! 👋',
                subtitle: _isInTrip
                    ? 'روز دوم از سفر شمال'
                    : 'آماده‌ی سفر بعدی هستی؟',
                leading: Row(
                  children: [
                    HsContainer(
                      width: 42.w,
                      height: 42.w,
                      onTap: () {},
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.notifications_none_rounded,
                              size: 22.sp,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Positioned(
                            top: 9.h,
                            right: 11.w,
                            child: Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: context.colorScheme.error,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: context.colorScheme.surface,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),
                    CircleAvatar(
                      radius: 23.r,
                      backgroundColor: AppColors.avatars[0],
                      child: txt(
                        'س',
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              //* section header
              SectionHeader(
                title: "سفر فعلی",
                actionLabel: "جزئیات کامل",
                onTap: () {
                  //? navigate to trip details
                  context.push('/trip-detail');
                },
              ),
              SizedBox(height: 12.h),

              //* trip card
              HomeTripCard(isInTrip: _isInTrip),
              SizedBox(height: 16.h),

              //* action cards
              HomeActionCardsRow(isInTrip: _isInTrip),
              SizedBox(height: 24.h),

              //* recent activities header
              SectionHeader(title: 'فعالیت‌های اخیر'),
              SizedBox(height: 12.h),

              //* recent activities list
              HomeActivities(isInTrip: _isInTrip),
              SizedBox(height: 65.h),
            ],
          ),
        ),
      ),
    );
  }
}
