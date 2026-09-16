import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/member_tile_status_enums.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/section_header.dart';
import 'package:hamsafar/features/trips_feature/presentation/widgets/member_tile.dart';

class TdMembers extends StatelessWidget {
  const TdMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* section header
        SectionHeader(title: "اعضای سفر (۶)", actionLabel: "همه"),
        SizedBox(height: 12.h),

        //* Members list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
            child: MemberTile(
              name: [
                "سارا محمدی",
                "مهدی رضایی",
                "نگار احمدی",
                "علی کریمی",
              ][index],
              username: [
                "@sara_travel",
                "@mahdi_r",
                "@negar_a",
                "@ali_k",
              ][index],
              letter: ["س", "م", "ن", "ع"][index],
              avatarColor: AppColors.avatars[index],
              statusLabel: [
                "لیدر",
                "تایید شده",
                "تایید شده",
                "در انتظار پرداخت",
              ][index],
              status: [
                MemberTileStatus.leader,
                MemberTileStatus.confirmed,
                MemberTileStatus.confirmed,
                MemberTileStatus.pending,
              ][index],
            ),
          ),
        ),
      ],
    );
  }
}
