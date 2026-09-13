import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_info_item.dart';

class HomePreparingInfo extends StatelessWidget {
  const HomePreparingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      height: 75.h,
      radius: 15.r,
      alignment: Alignment.center,
      child: Center(
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeInfoItem(label: 'تاریخ', value: '۱۵ تا ۱۷ اردیبهشت'),

            Container(
              width: 1.w,
              height: 20.h,
              color: context.colorScheme.onSurfaceVariant,
            ),

            HomeInfoItem(label: 'زمان حرکت', value: '۰۷:۰۰'),

            Container(
              width: 1.w,
              height: 20.h,
              color: context.colorScheme.onSurfaceVariant,
            ),

            HomeInfoItem(label: 'اعضا', value: '۶ نفر'),
          ],
        ),
      ),
    );
  }
}
