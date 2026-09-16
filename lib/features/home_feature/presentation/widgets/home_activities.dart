import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_activity_tile.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeActivities extends StatelessWidget {
  final bool isInTrip;

  const HomeActivities({super.key, required this.isInTrip});

  @override
  Widget build(BuildContext context) {
    if (isInTrip) {
      return Column(
        children: [
          HomeActivityTile(
            title: 'لیدر پرداخت نگار را تأیید کرد',
            time: '۲۰ دقیقه پیش',
            icon: LucideIcons.info,
            color: AppColors.success,
          ),
          SizedBox(height: 10.h),
          HomeActivityTile(
            title: 'وظیفه «خرید صبحانه» انجام شد',
            time: '۲ ساعت پیش',
            icon: LucideIcons.circleCheck,
            color: AppColors.primary,
          ),
        ],
      );
    }
    return Column(
      children: [
        HomeActivityTile(
          title: 'مهدی به سفر پیوست',
          time: '۱۰ دقیقه پیش',
          icon: Icons.person_add_alt_1_outlined,
          color: AppColors.tertiary,
        ),
        SizedBox(height: 10.h),
        HomeActivityTile(
          title: 'رای‌گیری زمان حرکت شروع شد',
          time: '۱ ساعت پیش',
          icon: Icons.how_to_vote_outlined,
          color: AppColors.accent,
        ),
      ],
    );
  }
}
