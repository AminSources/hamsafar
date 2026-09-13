import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_member_circle.dart';

class HomeAvatarStack extends StatelessWidget {
  const HomeAvatarStack({super.key});

  @override
  Widget build(BuildContext context) {
    const letters = ['س', 'م', 'ن', 'ع'];
    return Row(
      children: [
        SizedBox(
          width: 34.w + letters.length * 22.w,
          height: 34.w,
          child: Stack(
            children: [
              for (int i = 0; i < letters.length; i++)
                Positioned(
                  right: i * 22.w,
                  child: HomeMemberCircle(
                    label: letters[i],
                    bg: AppColors.avatars[i],
                  ),
                ),
              Positioned(
                right: letters.length * 22.w,
                child: HomeMemberCircle(
                  label: '+۲',
                  bg: Colors.white,
                  fg: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        txt('مشاهده', size: 11.sp),
        Icon(Icons.chevron_right_rounded, size: 16.sp),
      ],
    );
  }
}
