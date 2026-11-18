import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';

class TripSummaryCard extends StatelessWidget {
  final TripEntity trip;

  const TripSummaryCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: .spaceEvenly,
        children: List.generate(
          5,
          (index) => index % 2 == 0
              ? Column(
                  children: [
                    //* value
                    txt(
                      [
                        trip.memberCount,
                        (trip.returnAt.difference(trip.departureAt).inDays + 1),
                        trip.budget,
                      ][index ~/ 2].toString(),
                      style: context.textTheme.titleMedium,
                    ),

                    //* label
                    txt(
                      ['اعضا', 'روز', 'تومان / نفر'][index ~/ 2],
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                )
              : Container(
                  width: 1.w,
                  height: 20.h,
                  color: context.theme.dividerColor,
                ),
        ),
      ),
    );
  }
}
