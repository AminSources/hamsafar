import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';

import 'package:hamsafar/core/widgets/txt.dart';

class FriendsReceviedReqButton extends StatelessWidget {
  const FriendsReceviedReqButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        //* accept button
        Expanded(
          child: HsButton(
            height: 40.h,
            onTap: () {
              //? show accepr snack bar
              context.showHsSnackBar(
                text: "درخواست کاربر مورد نظر پذیرفته شد",
                hsSnackBarType: HsSnackBarType.success,
              );
            },
            hsButtonType: HsButtonType.outline,
            borderColor: context.colorScheme.primary,
            child: txt("پذیرفتن", color: context.colorScheme.primary),
          ),
        ),

        //* reject button
        Expanded(
          child: HsButton(
            height: 40.h,
            onTap: () {
              //? show reject snack bar
              context.showHsSnackBar(
                text: "درخواست کاربر مورد نظر رد شد",
                hsSnackBarType: HsSnackBarType.error,
              );
            },
            hsButtonType: HsButtonType.outline,
            borderColor: context.colorScheme.error,
            child: txt("رد کردن", color: context.colorScheme.error),
          ),
        ),
      ],
    );
  }
}
