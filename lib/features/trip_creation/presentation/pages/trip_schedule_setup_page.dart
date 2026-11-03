import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/date_time_option.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_input.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';

class TripScheduleSetupPage extends StatelessWidget {
  const TripScheduleSetupPage({super.key});

  Future<void> _pickDateTime(
    BuildContext context, {
    required DateTime initial,
    required ValueChanged<DateTime> onChanged,
  }) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null || !context.mounted) return;

    onChanged(DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ));
  }

  String _dateTime(DateTime value) =>
      '${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}  ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<TripDraftCubit, TripDraft>(
        builder: (context, draft) {
          final cubit = context.read<TripDraftCubit>();
          return Column(
            children: [
              Row(
                children: [
                  ScheduleOption(
                    title: 'تعیین قطعی',
                    selected: draft.scheduleType == 'fixed',
                    onTap: () => cubit.setScheduleType('fixed'),
                  ),
                  SizedBox(width: 10.w),
                  ScheduleOption(
                    title: 'رأی‌گیری از اعضا',
                    selected: draft.scheduleType == 'voting',
                    onTap: () => cubit.setScheduleType('voting'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              if (draft.scheduleType == 'voting')
                const HsNote(
                  note: 'تاریخ‌های زیر زمان پیشنهادی هستند و انتخاب نهایی با رأی اعضا انجام می‌شود.',
                  noteMode: HsNoteType.warning,
                ),
              if (draft.scheduleType == 'voting') SizedBox(height: 12.h),
              Row(
                children: [
                  TripInput(
                    title: 'تاریخ و ساعت رفت',
                    value: _dateTime(draft.departureAt),
                    icon: Icons.calendar_today_outlined,
                    onTap: () => _pickDateTime(
                      context,
                      initial: draft.departureAt,
                      onChanged: cubit.setDepartureAt,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  TripInput(
                    title: 'تاریخ و ساعت برگشت',
                    value: _dateTime(draft.returnAt),
                    icon: Icons.calendar_today_outlined,
                    onTap: () => _pickDateTime(
                      context,
                      initial: draft.returnAt,
                      onChanged: cubit.setReturnAt,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          );
        },
      ),
    );
  }
}
