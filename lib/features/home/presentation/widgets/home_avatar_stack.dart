import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/txt.dart';

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
            children: List.generate(letters.length + 1, (index) {
              final lastIndex = index == letters.length;
              final lastItemSpace = letters.length * 22.w;

              return Positioned(
                right: lastIndex ? lastItemSpace : (index * 22.w),
                child: HsAvatar(
                  label: lastIndex ? txt("+۲") : txt(letters[index]),
                  size: 30.w,
                  color: AppColors.avatars[index],
                  type: HsAvatarType.profile,
                ),
              );
            }),
          ),
        ),
        const Spacer(),
        txt('مشاهده', size: 11.sp),
        Icon(Icons.chevron_right_rounded, size: 16.sp),
      ],
    );
  }
}
