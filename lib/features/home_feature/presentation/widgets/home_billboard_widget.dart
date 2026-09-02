import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/chip_widget.dart';
import 'package:hamsafar/core/widgets/trip_detail_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/enums/chip_mode.dart';

class HomeBillboardWidget extends StatelessWidget {
  const HomeBillboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.h,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: .end,
        children: [
          //* title
          Row(
            textDirection: .rtl,
            children: [
              //* icon
              Icon(Icons.pin_drop_outlined),

              //* txt
              txt("سفر بعدی"),
            ],
          ),

          //* space
          SizedBox(height: 10.h),

          //* trip title
          txt("کوه عینالی", style: context.textTheme.displayMedium),

          //* space
          SizedBox(height: 10.h),

          //* trip detail
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 10.w,
            runSpacing: 10.w,
            children: [
              //* date
              TripDetailWidget(
                label: "سه‌شنبه ۳۰ مرداد",
                icon: Icons.date_range_rounded,
              ),

              //* trip time
              TripDetailWidget(
                label: "حرکت ۰۸:۰۰",
                icon: Icons.watch_later_outlined,
              ),

              //* members detail
              TripDetailWidget(
                label: "۴ عضو · ۲ تأیید حضور",
                icon: Icons.people_alt_outlined,
              ),
            ],
          ),

          //* space
          const Spacer(),

          //* deadline info and show trip button
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              //* show trip detail button
              SizedBox(
                width: 140.w,
                height: 50.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: context.textTheme.bodyMedium!.color!,
                    ),
                  ),
                  onPressed: () {},
                  child: txt("مشاهده سفر", style: context.textTheme.bodyMedium),
                ),
              ),

              //* deadline
              ChipWidget(label: txt("۳ روز مانده"), chipMode: ChipMode.warning),
            ],
          ),
        ],
      ),
    );
  }
}
