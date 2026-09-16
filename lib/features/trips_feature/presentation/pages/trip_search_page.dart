import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/note_enums.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trips_feature/presentation/widgets/trip_item.dart';

class TripSearchPage extends StatelessWidget {
  const TripSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HsAppBar(title: 'جستجوی سفر', hasBack: true),
              SizedBox(height: 20.h),

              TextField(
                onChanged: (value) {},
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

              TripItem(
                status: "عضوگیری باز",
                statusColor: context.colorScheme.primaryContainer,
                statusTextColor: context.colorScheme.primary,
                badge: '۳ روز مانده',
                badgeColor: context.colorScheme.secondary,
                badgeTextColor: context.colorScheme.onSecondary,
                title: 'سفر جنگل‌گردی شمال 🌲',
                date: '۱۵ تا ۱۷ اردیبهشت ۱۴۰۴',
                members: '۶ عضو · لیدر: سارا محمدی',
              ),
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
              SizedBox(height: 16.h),

              HsNote(
                note: 'برای مشاهده جزئیات و ارسال درخواست، روی هر سفر بزنید',
                noteMode: NoteMode.info,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
