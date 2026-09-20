import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/features/trips/enums/member_rule.dart';
import 'package:hamsafar/features/trips/enums/member_status.dart';
import 'package:hamsafar/features/trips/presentation/widgets/member_tile.dart';

class TripMembersSection extends StatelessWidget {
  const TripMembersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* section header
        HsHeader(title: "اعضای سفر (۶)", actionLabel: "همه"),
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
              memberStatus: [
                MemberStatus.none,
                MemberStatus.confirmed,
                MemberStatus.confirmed,
                MemberStatus.pending,
              ][index],
              memberRule: index == 0 ? MemberRule.owner : MemberRule.member,
              isInTrip: true,
            ),
          ),
        ),
      ],
    );
  }
}
