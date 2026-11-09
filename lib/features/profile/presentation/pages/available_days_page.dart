import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile/domain/params/save_availability_params.dart';
import 'package:hamsafar/features/profile/presentation/cubit/profile_preferences_cubit.dart';
import 'package:hamsafar/features/profile/presentation/widgets/profile_available_day_chip.dart';
import 'package:hamsafar/features/profile/presentation/widgets/time_range_tile.dart';

class AvailableDaysPage extends StatefulWidget {
  const AvailableDaysPage({super.key});

  @override
  State<AvailableDaysPage> createState() => _AvailableDaysPageState();
}

class _AvailableDaysPageState extends State<AvailableDaysPage> {
  static const List<String> _days = [
    'شنبه', 'یکشنبه', 'دوشنبه', 'سه شنبه',
    'چهارشنبه', 'پنجشنبه', 'جمعه',
  ];
  static const List<String> _dayCodes = [
    'sat', 'sun', 'mon', 'tue', 'wed', 'thu', 'fri',
  ];

  final Set<String> _selectedDays = {};
  TimeOfDay _startTime = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 23, minute: 0);
  bool _initialized = false;

  void _initializeForm(ProfilePreferencesState state) {
    if (_initialized) return;
    setState(() {
      _selectedDays
        ..clear()
        ..addAll(state.availability.map((item) => item.dayOfWeek));
      if (state.availability.isNotEmpty) {
        _startTime = _parseTime(state.availability.first.timeFrom);
        _endTime = _parseTime(state.availability.first.timeTo);
      }
      _initialized = true;
    });
  }

  TimeOfDay _parseTime(String value) {
    final parts = value.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _selectTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (context, child) {
        return Directionality(textDirection: Directionality.of(context), child: child!);
      },
    );
    if (!mounted || picked == null) return;
    setState(() {
      if (isStart) {
        _startTime = picked;
      } else {
        _endTime = picked;
      }
    });
  }

  Future<void> _save() async {
    final startMinutes = _startTime.hour * 60 + _startTime.minute;
    final endMinutes = _endTime.hour * 60 + _endTime.minute;
    if (endMinutes <= startMinutes) {
      context.showHsSnackBar(
        text: 'ساعت پایان باید بعد از ساعت شروع باشد',
        hsSnackBarType: HsSnackBarType.error,
      );
      return;
    }

    final cubit = context.read<ProfilePreferencesCubit>();
    final saved = await cubit.saveAvailability(SaveAvailabilityParams(
      days: _dayCodes.where(_selectedDays.contains).toList(),
      timeFrom: _formatTime(_startTime),
      timeTo: _formatTime(_endTime),
    ));
    if (!mounted) return;

    if (saved) {
      context.showHsSnackBar(
        text: 'روزها و ساعت آزاد با موفقیت ذخیره شد',
        hsSnackBarType: HsSnackBarType.success,
      );
      context.pop(true);
    } else {
      context.showHsSnackBar(
        text: cubit.state.message ?? 'ذخیره تغییرات ناموفق بود',
        hsSnackBarType: HsSnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfilePreferencesCubit, ProfilePreferencesState>(
          listener: (context, state) {
            if (state.isLoaded && !_initialized) _initializeForm(state);
          },
          builder: (context, state) {
            if (state.isLoading || (!state.isLoaded && state.message == null)) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!state.isLoaded) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      txt(state.message ?? 'دریافت اطلاعات ناموفق بود',
                          textAlign: TextAlign.center),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () =>
                            context.read<ProfilePreferencesCubit>().load(),
                        child: const txt('تلاش دوباره'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HsAppBar(title: 'روزهای آزاد من', hasBack: true),
                  SizedBox(height: 16.h),
                  HsNote(
                    note: 'روزهای آزاد هفته‌ات را انتخاب کن تا هماهنگی زمان سفرها راحت‌تر انجام شود.',
                    noteMode: HsNoteType.success,
                  ),
                  SizedBox(height: 24.h),
                  HsHeader(title: 'روزهای هفته'),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: List.generate(_days.length, (index) {
                      final code = _dayCodes[index];
                      final isSelected = _selectedDays.contains(code);
                      return ProfileAvailableDayChip(
                        title: _days[index],
                        isSelected: isSelected,
                        onSelect: (value) {
                          setState(() {
                            if (value) {
                              _selectedDays.remove(code);
                            } else {
                              _selectedDays.add(code);
                            }
                          });
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 24.h),
                  HsHeader(title: 'بازه زمانی'),
                  SizedBox(height: 16.h),
                  HsContainer(
                    padding: EdgeInsets.all(16.w),
                    color: context.colorScheme.surface,
                    child: Row(
                      spacing: 12.w,
                      children: [
                        TimeRangeTile(
                          title: 'از ساعت',
                          value: _formatTime(_startTime),
                          onTap: () => _selectTime(true),
                        ),
                        TimeRangeTile(
                          title: 'تا ساعت',
                          value: _formatTime(_endTime),
                          onTap: () => _selectTime(false),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  HsNote(
                    note: 'روزهای آزاد شما در پروفایلتان به دوستان نمایش داده می‌شود و لیدر هنگام برنامه‌ریزی سفر آن‌ها را در نظر می‌گیرد.',
                    noteMode: HsNoteType.info,
                  ),
                  SizedBox(height: 32.h),
                  HsButton(
                    onTap: state.isSaving ? null : _save,
                    child: state.isSaving
                        ? SizedBox(
                            width: 22.w,
                            height: 22.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : txt('ذخیره تغییرات'),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
