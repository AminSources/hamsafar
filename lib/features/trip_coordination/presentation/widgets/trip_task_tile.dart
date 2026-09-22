import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_check_box.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripTaskTile extends StatelessWidget {
  final String task;
  final bool isDone;
  final ValueChanged<bool> onDone;
  final String name;

  const TripTaskTile({
    super.key,
    required this.task,
    required this.isDone,
    required this.onDone,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return HsTile(
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8.h,
        children: [
          //* task details
          Row(
            spacing: 8.w,
            children: [
              //* task checkbox
              HsCheckBox(value: isDone, onTap: onDone),

              //* task title
              txt(task),
            ],
          ),

          //* user details
          Row(
            spacing: 8.w,
            children: [
              //* profile avatar
              HsAvatar(
                label: txt(name[0]),
                size: 24.w,
                color: getAvatarColor(name),
                type: HsAvatarType.profile,
              ),

              //* name
              txt(name, style: context.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
