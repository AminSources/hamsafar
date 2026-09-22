import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HomeActivityTile extends StatelessWidget {
  final String title;
  final String time;
  final IconData icon;
  final Color color;

  const HomeActivityTile({
    super.key,
    required this.title,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return HsTile(
      child: Row(
        children: [
          //* activity icon
          HsAvatar(
            type: HsAvatarType.none,
            label: Icon(icon),
            labelSize: 18.sp,
            labelColor: color,
            color: color.withValues(alpha: 0.12),
            isCircle: true,
            size: 40.w,
          ),
          SizedBox(width: 12.w),

          //* activity details
          Expanded(
            child: Column(
              spacing: 2.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* activity title
                txt(
                  title,
                  size: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onSurface,
                ),

                //* activity time
                txt(
                  time,
                  size: 10.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
