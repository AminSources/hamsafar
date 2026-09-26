import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: txt(
            'پروفایلت رو کامل کن ✨',
            style: context.textTheme.headlineLarge,
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: txt(
            'این اطلاعات به دوستانت کمک می‌کند تو را پیدا کنند',
            style: context.textTheme.bodyMedium,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
