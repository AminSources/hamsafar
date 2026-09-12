import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsAppbar extends StatelessWidget {
  final String? title;
  final bool? hasBack;
  final Widget? leading;

  const HsAppbar({super.key, this.title, this.hasBack, this.leading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          //* back button
          hasBack ?? false
              ? HsContainer(
                  width: 40.w,
                  height: 40.w,
                  onTap: () => context.pop(),
                  child: Center(child: Icon(Icons.chevron_left_sharp)),
                )
              : const SizedBox.shrink(),

          //* space
          SizedBox(width: 16.w),

          //* title
          txt(title ?? "title", style: context.textTheme.headlineLarge),

          //* leading
          leading ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
