import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HomeAvatarStack extends StatelessWidget {
  final List<String> membersNames;

  const HomeAvatarStack({super.key, required this.membersNames});

  @override
  Widget build(BuildContext context) {
    final letters = membersNames
        .map((name) => name.isNotEmpty ? name[0] : '')
        .toList();
    return Row(
      children: [
        SizedBox(
          width: 34.w + letters.length * 22.w,
          height: 34.w,
          child: Stack(
            children: List.generate(
              letters.length > 5 ? letters.length + 1 : letters.length,
              (index) {
                final lastIndex = index == letters.length;
                final lastItemSpace = letters.length * 22.w;

                return Positioned(
                  right: lastIndex ? lastItemSpace : (index * 22.w),
                  child: HsAvatar(
                    label: lastIndex ? txt("+۲") : txt(letters[index]),
                    size: 30.w,
                    color: getAvatarColor(membersNames[index]),
                    type: HsAvatarType.profile,
                  ),
                );
              },
            ),
          ),
        ),
        const Spacer(),
        txt('مشاهده', size: 11.sp),
        Icon(Icons.chevron_right_rounded, size: 16.sp),
      ],
    );
  }
}
