import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripDetailsSnackBar {
  final bool isJoined;

  const TripDetailsSnackBar({required this.isJoined});

  SnackBar toSnackBar(BuildContext context) {
    return SnackBar(
      content: Row(
        children: [
          //* icon
          Icon(
            isJoined
                ? LucideIcons.userRoundArrowLeft
                : LucideIcons.userRoundPlus,
            color: isJoined ? context.colorScheme.error : AppColors.success,
          ),

          //* text
          SizedBox(width: 12.w),
          txt(
            isJoined ? "شما سفر را ترک کردید" : "درخواست عضویت شما ارسال شد",
            color: isJoined ? context.colorScheme.error : AppColors.success,
            fontWeight: FontWeight.w800,
            size: 14.sp,
          ),
        ],
      ),
      backgroundColor: context.colorScheme.surfaceContainer,
      duration: const Duration(milliseconds: 1500),
    );
  }
}
