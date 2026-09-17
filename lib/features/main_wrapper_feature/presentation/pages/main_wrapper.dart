import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamsafar/features/main_wrapper_feature/presentation/cubit/bottom_nav_cubit.dart';
import 'package:hamsafar/features/friends_feature/presentation/pages/friends_wrapper.dart';
import 'package:hamsafar/features/home_feature/presentation/pages/home_page.dart';
import 'package:hamsafar/features/main_wrapper_feature/presentation/widgets/bottom_nav.dart';
import 'package:hamsafar/features/profile_feature/presentation/pages/profile_page.dart';
import 'package:hamsafar/features/trips_feature/presentation/pages/trips_page.dart';

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
                return BottomNav(
                  pageController: _pageController,
                  bottomNavIndex: state,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
