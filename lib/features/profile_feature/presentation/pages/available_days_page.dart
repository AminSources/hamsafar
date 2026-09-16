import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class AvailableDaysPage extends StatefulWidget {
  const AvailableDaysPage({super.key});

  @override
  State<AvailableDaysPage> createState() => _AvailableDaysPageState();
}

class _AvailableDaysPageState extends State<AvailableDaysPage> {
  //* day labels
  final List<String> _days = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

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
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 12.r,
                color: context.colorScheme.primaryContainer,
                borderColor: Colors.transparent,
                child: txt(
                  'روزهای آزاد هفته‌ات را انتخاب کن تا هماهنگی زمان سفرها راحت‌تر انجام شود.',
                  style: context.textTheme.bodyMedium,
                  color: context.colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(height: 24.h),

              //* days section title
              txt('روزهای هفته', style: context.textTheme.titleMedium),
              SizedBox(height: 16.h),

              //* days grid
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: List.generate(
                  7,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDays[index] = !_selectedDays[index];
                      });
                    },
                    child: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: _selectedDays[index]
                            ? context.colorScheme.primary
                            : context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: _selectedDays[index]
                              ? context.colorScheme.primary
                              : context.colorScheme.outline,
                        ),
                      ),
                      child: Center(
                        child: txt(
                          _days[index],
                          style: context.textTheme.titleSmall,
                          color: _selectedDays[index]
                              ? context.colorScheme.onPrimary
                              : context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              //* time range section title
              txt('بازه زمانی', style: context.textTheme.titleMedium),
              SizedBox(height: 4.h),

              //* time range subtitle
              txt(
                'روزهای انتخابی در این بازه آزاد هستید',
                style: context.textTheme.bodySmall,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: 16.h),

              //* time pickers row
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 14.r,
                color: context.colorScheme.surface,
                child: Row(
                  children: [
                    //* start time column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt(
                            'از ساعت',
                            style: context.textTheme.bodySmall,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(height: 8.h),

                          //* start time picker
                          GestureDetector(
                            onTap: () => _selectTime(context, true),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: txt(
                                _formatTime(_startTime),
                                style: context.textTheme.titleSmall,
                                color: context.colorScheme.onPrimaryContainer,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),

                    //* arrow icon
                    Icon(
                      Icons.arrow_back_rounded,
                      color: context.colorScheme.onSurfaceVariant,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),

                    //* end time column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt(
                            'تا ساعت',
                            style: context.textTheme.bodySmall,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(height: 8.h),

                          //* end time picker
                          GestureDetector(
                            onTap: () => _selectTime(context, false),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: txt(
                                _formatTime(_endTime),
                                style: context.textTheme.titleSmall,
                                color: context.colorScheme.onPrimaryContainer,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              //* info note box
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 12.r,
                color: context.colorScheme.secondaryContainer,
                borderColor: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: context.colorScheme.onSecondaryContainer,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),

                    //* info text
                    Expanded(
                      child: txt(
                        'روزهای آزاد شما در پروفایلتان به دوستان نمایش داده می‌شود و لیدر هنگام برنامه‌ریزی سفر آن‌ها را در نظر می‌گیرد.',
                        style: context.textTheme.bodySmall,
                        color: context.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              //* save button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: FilledButton(
                  onPressed: () {},
                  child: txt(
                    'ذخیره تغییرات',
                    style: context.textTheme.labelLarge,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
