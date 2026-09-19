import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';

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
        context.showHsSnackBar(
          text: "دوست حذف شد",
          hsSnackBarType: HsSnackBarType.error,
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
