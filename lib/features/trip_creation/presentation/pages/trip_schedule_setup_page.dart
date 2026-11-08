import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/date_time_option.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';

class TripScheduleSetupPage extends StatelessWidget {
  const TripScheduleSetupPage({super.key});

  Future<DateTime?> _pickDateTime(BuildContext context, DateTime initial) async {
    final date = await showDatePicker(
      context: context, initialDate: initial.isBefore(DateTime(2000)) ? DateTime.now() : initial,
      firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (date == null || !context.mounted) return null;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initial));
    if (time == null || !context.mounted) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String _dateTime(DateTime value) =>
      '${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}  ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  Widget _dateField(BuildContext context, String label, DateTime value, VoidCallback onTap) =>
      Expanded(child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(12.r)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            txt(label, size: 11.sp, color: Theme.of(context).colorScheme.onSurfaceVariant),
            SizedBox(height: 5.h),
            txt(_dateTime(value), size: 12.sp, fontWeight: FontWeight.w700),
          ]),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<TripDraftCubit, TripDraft>(
        builder: (context, draft) {
          final cubit = context.read<TripDraftCubit>();
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              ScheduleOption(title: 'زمان قطعی', selected: draft.scheduleType == 'fixed', onTap: () => cubit.setScheduleType('fixed')),
              SizedBox(width: 10.w),
              ScheduleOption(title: 'رأی‌گیری اعضا', selected: draft.scheduleType == 'voting', onTap: () => cubit.setScheduleType('voting')),
            ]),
            SizedBox(height: 16.h),
            if (draft.scheduleType == 'fixed') ...[
              const HsNote(note: 'زمان شروع و پایان سفر را دقیق مشخص کنید. این زمان پس از ایجاد سفر برای اعضا نمایش داده می‌شود.', noteMode: HsNoteType.info),
              SizedBox(height: 14.h),
              Row(children: [
                _dateField(context, 'شروع سفر', draft.departureAt, () async {
                  final value = await _pickDateTime(context, draft.departureAt);
                  if (value != null) cubit.setDepartureAt(value);
                }),
                SizedBox(width: 10.w),
                _dateField(context, 'پایان سفر', draft.returnAt, () async {
                  final value = await _pickDateTime(context, draft.returnAt);
                  if (value != null) cubit.setReturnAt(value);
                }),
              ]),
            ] else ...[
              const HsNote(note: 'برای هر پیشنهاد، یک بازهٔ شروع و پایان انتخاب کنید. اعضای پذیرفته‌شدهٔ سفر در صفحهٔ خانه یکی از این بازه‌ها را انتخاب می‌کنند.', noteMode: HsNoteType.info),
              SizedBox(height: 12.h),
              ...draft.departureOptions.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: HsContainer(
                    padding: EdgeInsets.all(12.w), radius: 14.r,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        txt('پیشنهاد ${index + 1}', fontWeight: FontWeight.w800, size: 13.sp),
                        const Spacer(),
                        if (draft.departureOptions.length > 2)
                          IconButton(onPressed: () => cubit.removeDepartureOption(index), icon: const Icon(Icons.delete_outline), visualDensity: VisualDensity.compact),
                      ]),
                      Row(children: [
                        _dateField(context, 'از', option.startsAt, () async {
                          final value = await _pickDateTime(context, option.startsAt);
                          if (value != null) cubit.updateDepartureOption(index, option.copyWith(startsAt: value));
                        }),
                        SizedBox(width: 8.w),
                        _dateField(context, 'تا', option.endsAt, () async {
                          final value = await _pickDateTime(context, option.endsAt);
                          if (value != null) cubit.updateDepartureOption(index, option.copyWith(endsAt: value));
                        }),
                      ]),
                      if (!option.endsAt.isAfter(option.startsAt))
                        Padding(padding: EdgeInsets.only(top: 6.h), child: txt('پایان بازه باید بعد از شروع آن باشد.', color: Theme.of(context).colorScheme.error, size: 11.sp)),
                    ]),
                  ),
                );
              }),
              OutlinedButton.icon(
                onPressed: draft.departureOptions.length >= 10 ? null : () {
                  final start = draft.departureOptions.isEmpty ? DateTime.now().add(const Duration(days: 1)) : draft.departureOptions.last.startsAt.add(const Duration(hours: 2));
                  cubit.addDepartureOption(start, start.add(const Duration(hours: 2)));
                },
                icon: const Icon(Icons.add), label: const Text('افزودن بازهٔ پیشنهادی'),
              ),
              SizedBox(height: 6.h),
              txt('حداقل ۲ و حداکثر ۱۰ بازه می‌توانید ثبت کنید.', size: 11.sp, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ],
            SizedBox(height: 24.h),
          ]);
        },
      ),
    );
  }
}
