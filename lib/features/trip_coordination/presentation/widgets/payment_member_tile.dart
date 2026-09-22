import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_coordination/enums/payment_member_status.dart';

class PaymentMemberTile extends StatelessWidget {
  final String name;
  final int share;
  final PaymentMemberStatus paymentStatus;

  const PaymentMemberTile({
    super.key,
    required this.name,
    required this.share,
    required this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return HsTile(
      leading: HsAvatar(
        size: 40.w,
        label: txt(
          name[0],
          size: 14.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        color: getAvatarColor(name),
        type: HsAvatarType.profile,
      ),
      trailing: HsBadge(
        label: paymentStatus.label,
        icon: paymentStatus.icon,
        type: paymentStatus.badgeType,
      ),
      child: Row(
        children: [
          //* name and details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* name
                txt(name, style: context.textTheme.bodyLarge),

                //* share
                txt("$share تومان", style: context.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
