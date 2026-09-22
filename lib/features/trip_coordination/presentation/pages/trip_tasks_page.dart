import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trip_coordination/presentation/widgets/trip_task_tile.dart';

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
                child: const HsAppBar(
                  title: 'وظایف سفر',
                  hasBack: true,
                  leading: HsBadge(
                    label: '۲ از ۴ انجام شد',
                    type: HsBadgeType.success,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              //* tasks list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
                  child: TripTaskTile(
                    task: [
                      "رزرو اقامتگاه بوم‌گردی",
                      "خرید صبحانه روز اول",
                      "همراه آوردن اجاق گاز",
                      "همراه آوردن جعبه کمک‌های اولیه",
                    ][index],
                    isDone: [true, true, false, false][index],
                    onDone: (value) {},
                    name: [
                      "سارا محمدی",
                      "مهدی رضایی",
                      'نگار احمدی',
                      'علی کریمی',
                    ][index],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              //* info note
              HsNote(
                note:
                    'لیدر پس از بسته شدن عضوگیری، مسئولیت‌ها را با توجه به پروفایل و «وسایل من» هر عضو تعیین می‌کند تا کسی زیر بار مسئولیت نرود.',
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
