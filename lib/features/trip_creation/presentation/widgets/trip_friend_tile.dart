import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_check_box.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripFriendTile extends StatelessWidget {
  final String name;
  final String rate;
  final String tripCount;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final Color? avatarColor;

  const TripFriendTile({
    super.key,
    required this.name,
    required this.rate,
    required this.tripCount,
    required this.isSelected,
    required this.onSelected,
    this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),

      color: isSelected ? context.colorScheme.primaryContainer : null,
      borderColor: isSelected ? context.colorScheme.primary : null,
      radius: 14.r,
      child: Row(
        children: [
          //* avatar (م)
          Container(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: avatarColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: txt(
              name[0],
              size: 16.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          //* info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                txt(
                  name,
                  size: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                ),
                SizedBox(height: 4.h),
                txt(
                  '$tripCount سفر مشترک · امتیاز $rate',
                  size: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          //* checkbox
          HsCheckBox(value: isSelected, onTap: onSelected),
        ],
      ),
    );
  }
}
