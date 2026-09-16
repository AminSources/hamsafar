import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/widgets/section_header.dart';
import 'package:hamsafar/features/trips_feature/presentation/widgets/trip_item.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HsAppBar(title: "سفرها"),
              SizedBox(height: 20.h),

              TextField(
                onTap: () => context.push('/trip-search'),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'جستجوی سفر...',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              HsButton(
                onTap: () {
                  //? push trip creation page
                  context.push('/trip-create');
                },
                child: txt(
                  'ایجاد سفر جدید',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  size: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),

              SectionHeader(title: 'سفرهای من'),
              SizedBox(height: 12.h),

              TripItem(
                status: 'در حال آماده‌سازی',
                statusColor: context.colorScheme.primaryContainer,
                statusTextColor: context.colorScheme.primary,
                badge: '۳ روز مانده',
                badgeColor: context.colorScheme.secondary,
                badgeTextColor: context.colorScheme.onSecondary,
                title: 'سفر جنگل‌گردی شمال 🌲',
                date: '۱۵ تا ۱۷ اردیبهشت ۱۴۰۴',
                members: '۶ عضو · لیدر: سارا محمدی',
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
