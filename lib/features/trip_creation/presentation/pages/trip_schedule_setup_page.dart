import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_date_coordination_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/date_time_option.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_input.dart';

class TripScheduleSetupPage extends StatelessWidget {
  const TripScheduleSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
      child: BlocBuilder<TripDateCoordinationCubit, bool>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                spacing: 10.w,
                children: [
                  //* option 1 - fixed
                  ScheduleOption(
                    title: "تعیین قطعی",
                    selected: state,
                    onTap: () {
                      context.read<TripDateCoordinationCubit>().onChangeValue(
                        true,
                      );
                    },
                  ),

                  //* option 2 - voting
                  ScheduleOption(
                    title: "رای گیری از اعضا",
                    selected: !state,
                    onTap: () {
                      context.read<TripDateCoordinationCubit>().onChangeValue(
                        false,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              //* body contents
              state == true
                  ? Column(
                      children: [
                        //* date inputs row
                        Row(
                          spacing: 10.w,
                          children: [
                            //* departure date
                            TripInput(
                              title: "تاریخ رفت",
                              value: "۱۷ اردیبهشت",
                              icon: Icons.calendar_today_outlined,
                            ),

                            //* return date
                            TripInput(
                              title: "تاریخ برگشت",
                              value: "۱۷ اردیبهشت",
                              icon: Icons.calendar_today_outlined,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        //* time inputs row
                        Row(
                          spacing: 10.w,
                          children: [
                            //* departure time
                            TripInput(
                              title: "ساعت حرکت",
                              value: "۰۷:۰۰",
                              icon: Icons.access_time_outlined,
                            ),

                            //* return time
                            TripInput(
                              title: "ساعت برگشت",
                              value: "۰۷:۰۰",
                              icon: Icons.access_time_outlined,
                            ),
                          ],
                        ),
                      ],
                    )
                  : //* info note
                    HsNote(
                      note:
                          "در حالت (رای گیری) زمان و تاریخ حرکت و برگشت با رای گیری از اعضا انتخاب میشود، میتوانید یک مورد یا همه را باهم به رای گیری گذاشته میشود.",
                      noteMode: HsNoteType.warning,
                    ),

              SizedBox(height: 24.h),
            ],
          );
        },
      ),
    );
  }
}
