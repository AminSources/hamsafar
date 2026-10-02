import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/hs_error.dart';
import 'package:hamsafar/features/friends/enums/friend_type.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friends_bloc.dart';
import 'package:hamsafar/features/friends/presentation/widgets/friends_tile.dart';

class MyFriendsPage extends StatefulWidget {
  const MyFriendsPage({super.key});

  @override
  State<MyFriendsPage> createState() => _MyFriendsPageState();
}

class _MyFriendsPageState extends State<MyFriendsPage> {
  @override
  void initState() {
    super.initState();

    context.read<FriendsBloc>().add(GetFriendsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        if (state is FriendsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FriendsFailure) {
          return HsError(
            illustrationPath: "lib/assets/images/error.svg",
            title: state.errorMessage,
          );
        }
        if (state is FriendsSuccess) {
          final friends = state.friends;

          if (friends.isEmpty) {
            return HsError(
              illustrationPath: "lib/assets/images/empty_friend.svg",
              title: "شما هنوز دوستی ندارید",
              subtitle:
                  "از قسمت جستجوی دوستان، دوستان خود را پیدا کنید و به لیست دوستان خود اضافه کنید",
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
              child: FriendsTile(
                name: "${friends[index].firstName} ${friends[index].lastName}",
                userName: friends[index].userName,
                rate: friends[index].rate.toString(),
                tripCount: friends[index].tripCount,
                friendType: FriendType.alreadyFriend,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
