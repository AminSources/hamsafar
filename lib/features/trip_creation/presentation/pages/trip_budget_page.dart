import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_budget_summary_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripBudgetPage extends StatelessWidget {
  const TripBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    //* cost items list
    final List<String> costItems = [
      "ورودی پارک",
      "سوخت",
      "اقامت",
      "خوراک",
      "عوارض مسیر",
      "افزودن",
    ];

    //
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //* budget summary card
          TripBudgetSummaryCard(),
          SizedBox(height: 20.h),

          //* total estimated cost input
          txt(
            'هزینه تخمینی کل',
            size: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '۲٬۷۰۰٬۰۰۰',
              prefixIcon: Icon(Icons.money_rounded),
            ),
          ),
          SizedBox(height: 16.h),

          //* info note
          HsNote(
            note:
                "هزینه تخمینی، هزینه ای هست که شما باید با توجه به سفر های قبلی خود وارد میکنید، ترجیحا حداکثر هزینه را وارد کنید.",
          ),
          SizedBox(height: 16.h),

          //* cost items title
          txt(
            'آیتم‌های هزینه',
            size: 13.sp,
            fontWeight: FontWeight.w800,
            color: context.colorScheme.onSurface,
          ),
          SizedBox(height: 12.h),

          //* cost chips
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.generate(costItems.length, (index) {
              final lastItem = index == costItems.length - 1;

              return HsBadge(
                backgroundColor: lastItem
                    ? context.colorScheme.surfaceContainerHigh
                    : context.colorScheme.primaryContainer,
                foregroundColor: lastItem
                    ? context.colorScheme.onSurface
                    : context.colorScheme.primary,
                icon: lastItem ? LucideIcons.plus : LucideIcons.x,
                label: costItems[index],
              );
            }),
          ),
          SizedBox(height: 20.h),

          //* info note
          HsNote(
            note:
                "هزینه تخمینی بعد از مشخص شدن تعداد اعضا، خودکار بین نفرات تقسیم میشود.",
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
