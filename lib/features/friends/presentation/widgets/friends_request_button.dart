import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsRequestButton extends StatelessWidget {
  final bool isSended;
  final ValueChanged<bool> onSend;

  const FriendsRequestButton({
    super.key,
    required this.isSended,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return HsButton(
      height: 40.h,
      hsButtonType: isSended ? HsButtonType.outline : HsButtonType.filled,
      backgroundColor: isSended ? context.colorScheme.surfaceContainer : null,
      borderColor: context.colorScheme.surfaceContainer,
      onTap: () => onSend(isSended),
      child: txt(
        isSended ? "درخواست ارسال شد" : "ارسال درخواست دوستی",
        color: isSended ? context.colorScheme.onSurfaceVariant : null,
      ),
    );
  }
}
