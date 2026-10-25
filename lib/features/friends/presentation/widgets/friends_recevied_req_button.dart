import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class FriendsReceviedReqButton extends StatelessWidget {
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final bool isLoading;

  const FriendsReceviedReqButton({
    super.key,
    this.onAccept,
    this.onReject,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: HsButton(
            height: 40.h,
            onTap: isLoading ? null : onAccept,
            hsButtonType: HsButtonType.outline,
            borderColor: context.colorScheme.primary,
            child: isLoading
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : txt('پذیرفتن', color: context.colorScheme.primary),
          ),
        ),
        Expanded(
          child: HsButton(
            height: 40.h,
            onTap: isLoading ? null : onReject,
            hsButtonType: HsButtonType.outline,
            borderColor: context.colorScheme.error,
            child: txt('رد کردن', color: context.colorScheme.error),
          ),
        ),
      ],
    );
  }
}
