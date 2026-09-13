import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamsafar/core/cubit/bottom_nav_cubit.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_page.dart';
import 'package:hamsafar/features/home_feature/presentation/pages/home_page.dart';
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
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            HomePage(),
            TripsPage(),
            FriendsPage(),
            ProfilePage(),
          ],
        ),
      ),

      //* bottom navigation bar
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state,
            onTap: (value) {
              //? change bottom nav state index
              context.read<BottomNavCubit>().onChangePage(value);

              //? scroll page
              _pageController.jumpToPage(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'خانه',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                activeIcon: Icon(Icons.map_rounded),
                label: "سفرها",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline_rounded),
                activeIcon: Icon(Icons.people_alt_rounded),
                label: "دوستان",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: "پروفایل",
              ),
            ],
          );
        },
      ),
    );
  }
}
