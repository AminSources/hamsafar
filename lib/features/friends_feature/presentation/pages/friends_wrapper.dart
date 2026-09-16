import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/features/friends_feature/presentation/cubit/friends_tab_bar_cubit.dart';
import 'package:hamsafar/features/friends_feature/presentation/pages/friends_page.dart';
import 'package:hamsafar/features/friends_feature/presentation/pages/friends_requests_page.dart';
import 'package:hamsafar/features/friends_feature/presentation/pages/friends_search_page.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_tab_bar.dart';

class FriendsWrapper extends StatefulWidget {
  const FriendsWrapper({super.key});

  @override
  State<FriendsWrapper> createState() => _FriendsWrapperState();
}

class _FriendsWrapperState extends State<FriendsWrapper> {
  final List<Widget> _pages = const [
    FriendsPage(),
    FriendsRequestsPage(),
    FriendsSearchPage(),
  ];

  Widget _pageContent = FriendsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: BlocBuilder<FriendsTabBarCubit, int>(
                builder: (context, state) {
                  switch (state) {
                    case 0:
                      _pageContent = _pages[0];
                      break;
                    case 1:
                      _pageContent = _pages[1];
                      break;
                    case 2:
                      _pageContent = _pages[2];
                      break;
                    default:
                      _pageContent = _pages[0];
                  }

                  return Column(
                    children: [
                      //* app bar
                      HsAppBar(title: "دوستان من"),

                      //* tabbar section
                      FriendsTabBar(tabbarIndex: state),

                      //* page contents
                      _pageContent,
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
