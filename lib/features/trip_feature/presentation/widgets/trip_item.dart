import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/chip_widget.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/trip_detail_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/enums/chip_mode.dart';

class TripItem extends StatelessWidget {
  const TripItem({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      height: 225.h,
      margin: EdgeInsets.symmetric(vertical: 5.w),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: .end,
        children: [
          //* status detail
          Row(
            textDirection: .rtl,
            children: [
              ChipWidget(label: txt("تایید شده"), chipMode: ChipMode.success),

              //* space
              SizedBox(width: 10.w),

              ChipWidget(label: txt("۳ روز مانده"), chipMode: ChipMode.info),
            ],
          ),

          //* trip name
          txt("سفر به کوه عینالی", style: context.textTheme.titleLarge),

          //* date and location details
          Row(
            spacing: 10.w,
            textDirection: .rtl,
            children: [
              TripDetailWidget(label: "تبریز", icon: Icons.pin_drop_outlined),
              TripDetailWidget(
                label: "جمعه ۳۰ مرداد",
                icon: Icons.calendar_month,
              ),
              TripDetailWidget(label: "۰۸:۰۰", icon: Icons.access_time),
            ],
          ),

          //* space
          SizedBox(height: 15.h),

          //* group readiness
          txt("%امادگی گروه - ۷۰", color: context.colorScheme.primary),

          //* space
          SizedBox(height: 5.h),

          LinearProgressIndicator(value: 0.7),

          //* space
          SizedBox(height: 10.h),

          //* divider
          Divider(),

          //* space
          SizedBox(height: 10.h),

          //* people
          Row(
            textDirection: .rtl,
            children: [
              //* people avatars
              Expanded(
                child: Stack(
                  textDirection: .rtl,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: index * 25.w),
                      child: CircleAvatar(
                        radius: 22.5.r,
                        backgroundColor: context.theme.scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 20.r,
                          child: txt("${index + 1}"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //* people count
              TripDetailWidget(label: "۴ نفر", icon: Icons.people_alt_outlined),

              //* space
              const Spacer(),

              //* see details button
              Icon(Icons.chevron_left_sharp),
            ],
          ),
        ],
      ),
    );
  }
}
