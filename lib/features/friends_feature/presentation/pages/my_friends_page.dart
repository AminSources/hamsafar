import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/friend_enums.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_tile.dart';

class MyFriendsPage extends StatelessWidget {
  const MyFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
        child: FriendsTile(
          name: ['مهدی رضایی', 'نگار احمدی', 'علی کریمی', 'الناز شریفی'][index],
          userName: ['@mahdi_r', '@negar_a', '@ali_k', '@elnaz_sh'][index],
          rate: ['۴.۸', '۴.۹', '۴.۶', '۴.۵'][index],
          tripCount: [12, 8, 6, 4][index],
          friendType: FriendType.friend,
        ),
      ),
    );
  }
}
