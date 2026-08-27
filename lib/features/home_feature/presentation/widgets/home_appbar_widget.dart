import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/avatar_icon_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HomeAppbarWidget extends StatelessWidget {
  const HomeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        //* profile avatar
        AvatarIconWidget(
          width: 50.w,
          height: 50.w,
          isCircle: true,
          icon: Icons.person_rounded,
          iconSize: 20.sp,
        ),

        //* date and welcome
        Column(
          crossAxisAlignment: .end,
          children: [
            //* date
            txt("شنبه ۲۷ مرداد", style: context.textTheme.bodyMedium),

            //* good morning txt
            txt("صبح بخیر، امین", style: context.textTheme.headlineLarge),
          ],
        ),
      ],
    );
  }
}
