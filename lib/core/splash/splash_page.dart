import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/avatar_icon_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    //? push auth page
    Future.delayed(
      const Duration(seconds: 2),
      () => mounted ? Navigator.pushNamed(context, "/auth") : null,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            //* Logo
            AvatarIconWidget(
              width: 100.w,
              height: 100.w,
              icon: Icons.train_rounded,
            ),

            // space
            SizedBox(height: 50.h),

            //* Title
            txt("همسفر", style: context.textTheme.displayLarge),

            // space
            SizedBox(height: 10.h),

            //* Description
            txt(
              "هماهنگی سفر های گروهی دوستانه، ساده و متمرکز",
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
