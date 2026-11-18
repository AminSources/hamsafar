import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:shamsi_date/shamsi_date.dart';

class TripDateTimeCard extends StatelessWidget {
  final TripEntity trip;

  const TripDateTimeCard({super.key, required this.trip});

  //? Convert DateTime to Jalali and format it as yyyy/mm/dd
  String _date(DateTime dateTime) {
    final Jalali value = Jalali.fromDateTime(dateTime);

    return '${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}';
  }

  //? Format time as hh:mm
  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: context.textTheme.bodySmall!.color,
                size: context.textTheme.bodySmall!.fontSize,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Row(
                  spacing: 10.w,
                  children: [
                    txt("تاریخ رفت", style: context.textTheme.bodySmall),
                    Flexible(
                      child: txt(
                        '${_date(trip.departureAt)} ساعت ${_time(trip.departureAt)}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(
              right: (context.textTheme.bodySmall!.fontSize ?? 14) / 2 - 1.w,
              top: 4.h,
              bottom: 4.h,
            ),
            child: Container(
              width: 2.w,
              height: 20.h,
              color: context.theme.dividerColor,
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: context.textTheme.bodySmall!.color,
                size: context.textTheme.bodySmall!.fontSize,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Row(
                  spacing: 10.w,
                  children: [
                    txt("تاریخ بازگشت", style: context.textTheme.bodySmall),
                    Flexible(
                      child: txt(
                        '${_date(trip.returnAt)} ساعت ${_time(trip.returnAt)}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
