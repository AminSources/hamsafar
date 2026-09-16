import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_enums.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_snack_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendsRemoveButton extends StatelessWidget {
  const FriendsRemoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: 40.w,
      height: 40.w,
      onTap: () {
        //? show remove snack bar
        ScaffoldMessenger.of(context).showSnackBar(
          HsSnackBar(
            text: "دوست حذف شد",
            icon: LucideIcons.userRoundMinus,
            mode: HsSnackBarMode.error,
          ).toSnackBar(context),
        );
      },
      child: Icon(
        LucideIcons.userRoundMinus,
        size: 18.sp,
        color: context.colorScheme.error,
      ),
    );
  }
}
