import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsItemTile extends StatelessWidget {
  final String itemName;
  final IconData icon;

  const FriendsItemTile({
    super.key,
    required this.itemName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          //* icon
          Icon(icon, size: 20.sp, color: context.colorScheme.primary),

          SizedBox(width: 12.w),

          //* item name
          Expanded(
            child: txt(itemName, fontWeight: FontWeight.w700, size: 13.sp),
          ),

          //* status indicator
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
