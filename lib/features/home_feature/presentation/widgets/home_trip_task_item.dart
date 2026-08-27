import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/avatar_icon_widget.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HomeTripTaskItem extends StatelessWidget {
  final String? title;
  final String? description;
  final IconData? avatarIcon;
  final VoidCallback? onTap;

  const HomeTripTaskItem({
    super.key,
    this.title,
    this.description,
    this.avatarIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      height: 75.h,
      padding: EdgeInsets.all(10.w),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: .rtl,
        children: [
          Row(
            textDirection: .rtl,
            children: [
              //* avatar
              AvatarIconWidget(width: 50.w, height: 50.w, icon: avatarIcon),

              //* space
              SizedBox(width: 10.w),

              Column(
                crossAxisAlignment: .end,
                children: [
                  //* title
                  txt(title ?? "", style: context.textTheme.bodyLarge),

                  //* description
                  txt(description ?? "", style: context.textTheme.bodySmall),
                ],
              ),
            ],
          ),

          //* icon
          Icon(Icons.chevron_left_rounded),
        ],
      ),
    );
  }
}
