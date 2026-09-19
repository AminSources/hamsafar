import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/presentation/widgets/rules_tile.dart';

class TdRules extends StatelessWidget {
  final List<String> rules;

  const TdRules({super.key, required this.rules});

  @override
  Widget build(BuildContext context) {
    //* total widgets
    final totalWidgets = (rules.length * 2) - 1;

    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        txt('قوانین سفر', style: context.textTheme.titleMedium),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          child: Column(
            children: List.generate(totalWidgets, (index) {
              if (index.isOdd) {
                return Divider();
              }

              final rule = rules[index >> 1];
              return RulesTile(rule: rule);
            }),
          ),
        ),
      ],
    );
  }
}
