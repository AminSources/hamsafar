import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TdRules extends StatelessWidget {
  const TdRules({super.key});

  @override
  Widget build(BuildContext context) {
    final rules = [
      'حضور به‌موقع در محل تجمع (۱۵ دقیقه قبل از حرکت)',
      'لغو برنامه کمتر از ۴۸ ساعت قبل از سفر ممنوع است',
      'تقسیم مساوی هزینه‌ها و احترام به طبیعت 🌱',
    ];
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
            children: [
              for (int i = 0; i < rules.length; i++) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.gpp_good_outlined,
                        size: 18.sp,
                        color: context.colorScheme.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: txt(
                          rules[i],
                          size: 12.5.sp,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < rules.length - 1)
                  Divider(height: 1, color: context.colorScheme.outlineVariant),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
