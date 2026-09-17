import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/features/main_wrapper_feature/presentation/cubit/bottom_nav_cubit.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/features/main_wrapper_feature/presentation/widgets/bottom_nav_item.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BottomNav extends StatelessWidget {
  final PageController pageController;
  final int bottomNavIndex;

  const BottomNav({
    super.key,
    required this.pageController,
    required this.bottomNavIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: .spaceEvenly,
        children: List.generate(4, (index) {
          return BottomNavItem(
            label: ["خانه", "سفرها", "دوستان", "پروفایل"][index],
            icon: [
              LucideIcons.home,
              LucideIcons.map,
              LucideIcons.usersRound,
              LucideIcons.userRound,
            ][index],
            isSelected: bottomNavIndex == index,
            value: index,
            onSelect: (value) {
              //? change bottom nav state index
              context.read<BottomNavCubit>().onChangePage(value);

              //? change page view page
              pageController.jumpToPage(value);
            },
          );
        }),
      ),
    );
  }
}
