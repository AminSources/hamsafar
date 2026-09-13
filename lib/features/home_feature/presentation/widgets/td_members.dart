import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/member_tile.dart';

class TdMembers extends StatelessWidget {
  const TdMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            txt('اعضای سفر (۶)', style: context.textTheme.titleMedium),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  txt(
                    'همه',
                    size: 11.5.sp,
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  Icon(
                    Icons.chevron_left,
                    size: 16.sp,
                    color: context.colorScheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        MemberTile(
          name: 'سارا محمدی',
          username: '@sara_travel',
          letter: 'س',
          avatarColor: AppColors.avatars[0],
          status: 'لیدر',
          chipBg: context.colorScheme.secondaryContainer,
          chipFg: context.colorScheme.onSecondaryContainer,
          chipIcon: Icons.workspace_premium_outlined,
        ),
        SizedBox(height: 10.h),
        MemberTile(
          name: 'مهدی رضایی',
          username: '@mahdi_r',
          letter: 'م',
          avatarColor: AppColors.avatars[1],
          status: 'تأیید شده',
          chipBg: AppColors.successContainer,
          chipFg: AppColors.onSuccessContainer,
          chipIcon: Icons.check_circle_outline,
        ),
        SizedBox(height: 10.h),
        MemberTile(
          name: 'نگار احمدی',
          username: '@negar_a',
          letter: 'ن',
          avatarColor: AppColors.avatars[2],
          status: 'تأیید شده',
          chipBg: AppColors.successContainer,
          chipFg: AppColors.onSuccessContainer,
          chipIcon: Icons.check_circle_outline,
        ),
        SizedBox(height: 10.h),
        MemberTile(
          name: 'علی کریمی',
          username: '@ali_k',
          letter: 'ع',
          avatarColor: AppColors.avatars[3],
          status: 'در انتظار پرداخت',
          chipBg: AppColors.accentContainer,
          chipFg: AppColors.onAccentContainer,
          chipIcon: Icons.hourglass_bottom_outlined,
        ),
      ],
    );
  }
}
