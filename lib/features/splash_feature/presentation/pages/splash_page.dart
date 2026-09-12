import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    //? navigate to login
    _navigateToLogin();
  }

  //? navigate to login page after 2 seconds
  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    context.go("/login");
  }

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
            const Spacer(),

            Icon(
              Icons.route,
              size: 80.sp,
              color: context.colorScheme.onPrimary,
            ),

            SizedBox(height: 24.h),

            txt("همسفر", style: context.textTheme.displayLarge),

            SizedBox(height: 12.h),

            txt(
              'سفرِ کوتاه، هماهنگیِ آسان',
              style: context.textTheme.bodyLarge,
            ),

            const Spacer(),

            txt(
              'نسخه ۱.۰.۰',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall,
            ),

            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
