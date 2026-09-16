import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendsTileInfo extends StatelessWidget {
  final String rate;
  final int tripCount;

  const FriendsTileInfo({
    super.key,
    required this.rate,
    required this.tripCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //* rating
        Icon(
          LucideIcons.star,
          size: 14.sp,
          color: context.colorScheme.secondary,
        ),

        SizedBox(width: 4.w),

        txt(rate, color: context.colorScheme.onSurfaceVariant, size: 11.sp),

        SizedBox(width: 12.w),

        //* trips count
        Icon(
          LucideIcons.mapPinCheck,
          size: 14.sp,
          color: context.colorScheme.onSurfaceVariant,
        ),

        SizedBox(width: 4.w),

        txt(
          "$tripCount سفر",
          color: context.colorScheme.onSurfaceVariant,
          size: 11.sp,
        ),
      ],
    );
  }
}
