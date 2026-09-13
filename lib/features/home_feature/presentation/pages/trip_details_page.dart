import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_appbar.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/td_members.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/td_rules.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/td_trip_card.dart';

class TripDetailsPage extends StatelessWidget {
  const TripDetailsPage({super.key});

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
                child: const HsAppbar(title: 'جزئیات سفر', hasBack: true),
              ),

              //* TD trip card
              TdTripCard(),
              SizedBox(height: 24.h),

              //* TD members list
              TdMembers(),
              SizedBox(height: 24.h),

              //* TD rules list
              TdRules(),
              SizedBox(height: 24.h),

              //* TD exit trip button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: context.colorScheme.error),
                  ),
                  icon: Icon(
                    Icons.logout,
                    size: 18.sp,
                    color: context.colorScheme.error,
                  ),
                  label: txt(
                    'ترک سفر',
                    color: context.colorScheme.error,
                    fontWeight: FontWeight.w800,
                    size: 14.sp,
                  ),
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
