import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';

import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_rule_tile.dart';

class TripRulesPage extends StatelessWidget {
  const TripRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //* add rule input row
          Row(
            children: [
              //* rule text field
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'قانون جدید را بنویسید...',
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              //* add button
              SizedBox(
                width: 100.w,
                height: 50.h,
                child: FilledButton(
                  onPressed: () {
                    //? show snack bar
                    context.showHsSnackBar(
                      text: "قانون جدید اضافه شد",
                      hsSnackBarType: HsSnackBarType.success,
                    );
                  },
                  child: txt(
                    'افزودن',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    size: 13.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          //* rules list title
          txt(
            'قوانین تعیین‌شده (۳)',
            size: 13.sp,
            fontWeight: FontWeight.w800,
            color: context.colorScheme.onSurface,
          ),
          SizedBox(height: 12.h),

          //* rules list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
                child: TripRuleTile(
                  rule: [
                    "حضور به‌موقع در محل تجمع (۱۵ دقیقه قبل از حرکت)",
                    'لغو برنامه کمتر از ۴۸ ساعت قبل از سفر ممنوع است',
                    'برگشت زودتر از موعد، فقط با هماهنگی لیدر مجاز است',
                  ][index],
                ),
              );
            },
          ),
          SizedBox(height: 20.h),

          //* info note
          HsNote(
            note:
                'قوانین برای جلوگیری از مشکلات حین سفر (برگشت زودهنگام، اختلاف مالی و...) تعیین می‌شوند و همه اعضا پس از عضویت آن‌ها را تأیید می‌کنند.',
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
