import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class InviteCodeCard extends StatelessWidget {
  const InviteCodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      color: context.colorScheme.surface,
      radius: 16.r,
      child: Column(
        children: [
          //* label
          txt(
            'کد دعوت سفر',
            size: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 12.h),

          //* code display
          HsContainer(
            height: 60.h,
            color: context.colorScheme.primaryContainer,
            borderColor: context.colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copy_outlined,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                SizedBox(width: 10.w),
                txt(
                  'HMS-84Z2K',
                  size: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: context.colorScheme.onPrimaryContainer,
                  fontFamily: 'vazirmatn',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
