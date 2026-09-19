import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripStepper extends StatelessWidget {
  final String title;
  final int stepperIndex;

  const TripStepper({
    super.key,
    required this.title,
    required this.stepperIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 3.w,
              mainAxisAlignment: .spaceBetween,
              children: List.generate(9, (index) {
                if (index % 2 == 1) {
                  return Expanded(
                    child: Container(
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: context.colorScheme.outline,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  );
                } else {
                  // محاسبه شماره مرحله (از 1 تا 5)
                  final int stepNumber = (index ~/ 2) + 1;

                  // تعیین رنگ پس‌زمینه بر اساس موقعیت مرحله
                  final Color bgColor;
                  final Color fgColor;

                  if (stepNumber == stepperIndex + 1) {
                    // مرحله جاری
                    bgColor = context.colorScheme.primary;
                    fgColor = Colors.white;
                  } else if (stepNumber < stepperIndex + 1) {
                    // مراحل قبل‌تر
                    bgColor = context.colorScheme.primaryContainer;
                    fgColor = Colors.white;
                  } else {
                    // مراحل بعدی
                    bgColor = context.colorScheme.surfaceContainerHigh;
                    fgColor = context.colorScheme.onSurfaceVariant;
                  }

                  return CircleAvatar(
                    radius: 15.r,
                    backgroundColor: bgColor,
                    foregroundColor: Colors.white,
                    child: (stepNumber < stepperIndex + 1)
                        ? Icon(Icons.check_rounded)
                        : txt(
                            stepNumber.toString(),
                            style: context.textTheme.titleSmall,
                            color: fgColor,
                          ),
                  );
                }
              }),
            ),
            SizedBox(height: 8.h),

            //* step title
            txt(
              title,
              size: 15.sp,
              fontWeight: FontWeight.w800,
              color: context.colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
