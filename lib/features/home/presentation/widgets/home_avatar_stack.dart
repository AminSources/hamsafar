import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home/domain/entities/home_trip_member_entity.dart';

class HomeAvatarStack extends StatelessWidget {
  final List<HomeTripMemberEntity> members;

  const HomeAvatarStack({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 34.w + members.length * 22.w,
          height: 34.w,
          child: Stack(
            children: List.generate(
              members.length > 5 ? members.length + 1 : members.length,
              (index) {
                final lastIndex = index == members.length;
                final lastItemSpace = members.length * 22.w;

                return Positioned(
                  right: lastIndex ? lastItemSpace : (index * 22.w),
                  child: HsAvatar(
                    label: lastIndex
                        ? txt("+۲")
                        : Icon(
                            AvatarConverter.stringToIconData(
                              avatarName: members[index].avatarIcon,
                            ),
                          ),
                    size: 30.w,
                    color: getAvatarColor(
                      '${members[index].firstName} ${members[index].lastName}',
                    ),
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
