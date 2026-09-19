import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile/presentation/widgets/profile_available_day_chip.dart';
import 'package:hamsafar/features/profile/presentation/widgets/time_range_tile.dart';

class AvailableDaysPage extends StatefulWidget {
  const AvailableDaysPage({super.key});

  @override
  State<AvailableDaysPage> createState() => _AvailableDaysPageState();
}

class _AvailableDaysPageState extends State<AvailableDaysPage> {
  //* day labels
  final List<String> _days = [
    'شنبه',
    'یکشنبه',
    'دوشنبه',
    'سه شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
  ];

  //* selected states: Wed, Thu, Fri selected by default
  final List<bool> _selectedDays = [
    false,
    false,
    false,
    false,
    true,
    true,
    true,
  ];

  //* time range
  TimeOfDay _startTime = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 23, minute: 0);

  //* show time picker
  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  //* format time to Persian style
  String _formatTime(TimeOfDay time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              HsAppBar(title: 'روزهای آزاد من', hasBack: true),
              SizedBox(height: 16.h),

              //* description box
              HsNote(
                note:
                    'روزهای آزاد هفته‌ات را انتخاب کن تا هماهنگی زمان سفرها راحت‌تر انجام شود.',
                noteMode: HsNoteType.success,
              ),
              SizedBox(height: 24.h),

              //* days section title
              HsHeader(title: "روزهای هفته"),
              SizedBox(height: 16.h),

              //* days grid
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: List.generate(
                  7,
                  (index) => ProfileAvailableDayChip(
                    title: _days[index],
                    isSelected: _selectedDays[index],
                    onSelect: (value) {
                      setState(() {
                        _selectedDays[index] = !value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              //* time range section title
              HsHeader(title: "بازه زمانی "),
              SizedBox(height: 16.h),

              //* time pickers row
              HsContainer(
                padding: EdgeInsets.all(16.w),
                color: context.colorScheme.surface,
                child: Row(
                  spacing: 12.w,
                  children: List.generate(
                    2,
                    (index) => TimeRangeTile(
                      title: ["از ساعت", "تا ساعت"][index],
                      value: _formatTime([_startTime, _endTime][index]),
                      onTap: () {
                        _selectTime(context, [true, false][index]);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              //* info note box
              HsNote(
                note:
                    'روزهای آزاد شما در پروفایلتان به دوستان نمایش داده می‌شود و لیدر هنگام برنامه‌ریزی سفر آن‌ها را در نظر می‌گیرد.',
                noteMode: HsNoteType.info,
              ),
              SizedBox(height: 32.h),

              //* save button
              HsButton(onTap: () => context.pop(), child: txt("ذخیره تغییرات")),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
