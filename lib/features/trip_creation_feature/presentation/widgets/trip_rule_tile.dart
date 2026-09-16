import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_enums.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_snack_bar.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripRuleTile extends StatelessWidget {
  final String rule;

  const TripRuleTile({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      color: context.colorScheme.surface,
      radius: 14.r,
      child: Row(
        spacing: 10.w,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //* icon
          Icon(
            LucideIcons.scale,
            size: 20.sp,
            color: context.colorScheme.primary,
          ),

          //* rule txt
          Expanded(
            child: txt(
              rule,
              size: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),

          //* remove icon
          IconButton(
            onPressed: () {
              //? show snack bar
              ScaffoldMessenger.of(context).showSnackBar(
                HsSnackBar(
                  text: "قانون حذف شد",
                  mode: HsSnackBarMode.error,
                  icon: LucideIcons.trash,
                ).toSnackBar(context),
              );
            },
            icon: Icon(
              LucideIcons.trash,
              size: 18.sp,
              color: context.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
