import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              txt(
                'همسفر · نسخه ۱.۰.۰',
                style: context.textTheme.bodySmall,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: 4.h),
              txt(
                'ساخته‌شده با 💚 برای سفرهای دوستانه',
                style: context.textTheme.bodySmall,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
