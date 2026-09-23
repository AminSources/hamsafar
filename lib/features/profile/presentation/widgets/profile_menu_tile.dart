import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileMenuTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HsTile(
      onTap: onTap,
      leading: HsAvatar(
        size: 40.w,
        label: Icon(icon, color: context.colorScheme.primary, size: 20.sp),
        type: HsAvatarType.icon,
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: context.colorScheme.onSurfaceVariant,
        size: 24.sp,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          txt(title, style: context.textTheme.titleSmall),

          if (subtitle != null) ...[
            SizedBox(height: 4.h),
            txt(subtitle!, style: context.textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
}
