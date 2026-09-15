import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_action_card.dart';

class HomeActionCardsRow extends StatelessWidget {
  final bool isInTrip;

  const HomeActionCardsRow({super.key, required this.isInTrip});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: HomeActionCard(
            icon: Icons.how_to_vote_outlined,
            title: 'رای‌گیری',
            subtitle: isInTrip ? 'برنامه فردا' : '۱ رای‌گیری فعال',
            bg: context.colorScheme.tertiaryContainer,
            fg: context.colorScheme.onTertiaryContainer,
            onTap: () {
              //? push to trip vote page
              context.push("/trip-vote");
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: HomeActionCard(
            icon: Icons.payments_outlined,
            title: 'پرداخت سهم',
            subtitle: isInTrip ? 'تسویه پرداخت شد ✓' : '۴۵۰٬۰۰۰ تومان',
            bg: context.colorScheme.secondaryContainer,
            fg: context.colorScheme.onSecondaryContainer,
            onTap: () {
              //? push to trip budget page
              context.push("/trip-budget");
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: HomeActionCard(
            icon: Icons.checklist_outlined,
            title: 'وظایف سفر',
            subtitle: isInTrip ? '۲ وظیفه امروز' : '۴ وظیفه',
            bg: context.colorScheme.primaryContainer,
            fg: context.colorScheme.onPrimaryContainer,
            onTap: () {
              //? push to trip tasks page
              context.push("/trip-tasks");
            },
          ),
        ),
      ],
    );
  }
}
