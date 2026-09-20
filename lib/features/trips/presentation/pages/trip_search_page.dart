import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trips/presentation/widgets/trip_tile.dart';

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

              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
                  child: TripTile(
                    isInTrip: true,
                    tripName: 'سفر جنگل‌گردی شمال 🌲',
                    date: '۱۵ تا ۱۷ اردیبهشت ',
                    members: 6,
                    leaderName: "سارا محمدی",
                    time: "18:00",
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              HsNote(
                note: 'برای مشاهده جزئیات و ارسال درخواست، روی هر سفر بزنید',
                noteMode: HsNoteType.info,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
