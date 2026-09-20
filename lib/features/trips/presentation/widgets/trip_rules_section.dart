import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/hs_icon_label.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripRulesSection extends StatelessWidget {
  const TripRulesSection({super.key});

  @override
  Widget build(BuildContext context) {
    //* total widgets
    final rules = [
      'حضور به‌موقع در محل تجمع (۱۵ دقیقه قبل از حرکت)',
      'لغو برنامه کمتر از ۴۸ ساعت قبل از سفر ممنوع است',
      'تقسیم مساوی هزینه‌ها و احترام به طبیعت 🌱',
    ];

    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* header
        HsHeader(title: "قوانین سفر"),
        SizedBox(height: 12.h),

        //* rules
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rules
                .map(
                  (rule) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HsIconLabel(
                          label: rule,
                          icon: LucideIcons.shieldCheck,
                          iconColor: context.colorScheme.primary,
                        ),
                        if (rule != rules.last) Divider(height: 16.h),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
