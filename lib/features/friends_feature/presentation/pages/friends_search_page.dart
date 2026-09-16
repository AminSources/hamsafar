import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/friend_enums.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_enums.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_snack_bar.dart';
import 'package:hamsafar/features/friends_feature/presentation/widgets/friends_tile.dart';

class FriendsSearchPage extends StatelessWidget {
  const FriendsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* search input section
        TextField(
          decoration: InputDecoration(
            hintText: 'جستجوی نام کاربری...',
            prefixIcon: Icon(
              Icons.search,
              size: 20.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),

        SizedBox(height: 16.h),

        //* search results section
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 8.0),
              child: FriendsTile(
                name: ["رضا قاسمی", "الناز شریفی"][index],
                userName: ["@rashid_q", "@elnaz_sh"][index],
                rate: ["۴.۸", "۴.۹"][index],
                tripCount: [2, 15][index],
                friendType: FriendType.request,
                isSended: [false, true][index],
                onSend: index == 0
                    ? (value) {
                        //? show send req snack bar
                        ScaffoldMessenger.of(context).showSnackBar(
                          HsSnackBar(
                            text: "درخواست شما ارسال شد",
                            mode: HsSnackBarMode.info,
                          ).toSnackBar(context),
                        );
                      }
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }
}
