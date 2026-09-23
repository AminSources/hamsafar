import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_tools_tile.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendsToolsCard extends StatelessWidget {
  const FriendsToolsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(16.w),
      radius: 16.r,
      color: context.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* section title
          Row(
            children: [
              Icon(
                Icons.backpack_outlined,
                size: 18.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              txt('وسایل من', fontWeight: FontWeight.w800, size: 14.sp),
            ],
          ),

          SizedBox(height: 16.h),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
                child: FriendsToolsTile(
                  itemName: ["چادر", "گاز", "دوربین", "قطب نما"][index],
                  icon: [
                    LucideIcons.tent,
                    LucideIcons.flame,
                    LucideIcons.camera,
                    LucideIcons.compass,
                  ][index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
