import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/cubit/bottom_nav_cubit.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/features/friends_feature/presentation/pages/friends_wrapper.dart';
import 'package:hamsafar/features/home_feature/presentation/pages/home_page.dart';
import 'package:hamsafar/features/main_wrapper_feature/presentation/widgets/bottom_nav_item.dart';
import 'package:hamsafar/features/profile_feature/presentation/pages/profile_page.dart';
import 'package:hamsafar/features/trips_feature/presentation/pages/trips_page.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* body
      body: SizedBox.expand(
        child: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            //* body contents
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: const [
                HomePage(),
                TripsPage(),
                FriendsWrapper(),
                ProfilePage(),
              ],
            ),

            //* bottom navigation bar
            BlocBuilder<BottomNavCubit, int>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  height: 60.h,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 30.h,
                  ),
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
                        isSelected: state == index,
                        value: index,
                        onSelect: (value) {
                          //? change bottom nav state index
                          context.read<BottomNavCubit>().onChangePage(value);

                          //? change page view page
                          _pageController.jumpToPage(value);
                        },
                      );
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
