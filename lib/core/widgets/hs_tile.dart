import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';

class HsTile extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const HsTile({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      onTap: onTap,
      child: Row(
        children: [
          //* member avatar
          if (leading != null) ...[leading!, SizedBox(width: 12.w)],

          //* member name and username
          Expanded(child: child),

          //* member status
          if (trailing != null) ...[trailing!],
        ],
      ),
    );
  }
}
