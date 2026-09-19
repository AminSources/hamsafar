import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/presentation/cubit/friends_tab_bar_cubit.dart';

class FriendsTabBar extends StatefulWidget {
  final int tabbarIndex;

  const FriendsTabBar({super.key, required this.tabbarIndex});

  @override
  State<FriendsTabBar> createState() => _FriendsTabBarState();
}

class _FriendsTabBarState extends State<FriendsTabBar> {
  final List<String> _titles = ["دوستان من", "درخواست‌ها", "جستجو"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: List.generate(
          3,
          (index) => Expanded(
            child: InkWell(
              onTap: () {
                //? change tab
                context.read<FriendsTabBarCubit>().onChangeTabbar(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: index == widget.tabbarIndex
                      ? context.colorScheme.primary
                      : null,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: txt(
                    _titles[index],
                    color: index == widget.tabbarIndex
                        ? context.colorScheme.onPrimary
                        : context.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    size: 12.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Expanded(
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 10.h),
//               decoration: BoxDecoration(
//                 color: context.colorScheme.primary,
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Center(
//                 child: txt(
//                   'دوستان من',
//                   color: context.colorScheme.onPrimary,
//                   fontWeight: FontWeight.w700,
//                   size: 12.sp,
//                 ),
//               ),
//             ),
//           ),

//           //* requests tab
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 10.h),
//               child: Center(
//                 child: txt(
//                   'درخواست‌ها',
//                   color: context.colorScheme.onSurfaceVariant,
//                   fontWeight: FontWeight.w700,
//                   size: 12.sp,
//                 ),
//               ),
//             ),
//           ),
