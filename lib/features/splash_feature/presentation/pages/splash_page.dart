import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.splashGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.route,
              size: 80.sp,
              color: context.colorScheme.onPrimary,
            ),
            SizedBox(height: 24.h),
            Text(
              'همسفر',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(color: AppColors.onPrimary),
            ),
            SizedBox(height: 12.h),
            Text(
              'سفرِ کوتاه، هماهنگیِ آسان',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.onPrimary.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 24.h),
        child: Text(
          'نسخه ۱.۰.۰',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.onPrimary.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
