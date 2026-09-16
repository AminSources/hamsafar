import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsAppBar extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool? hasBack;
  final Widget? leading;
  final VoidCallback? onTapBackButton;

  const HsAppBar({
    super.key,
    this.title,
    this.hasBack,
    this.leading,
    this.subtitle,
    this.onTapBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          //* back button
          hasBack ?? false
              ? Row(
                  children: [
                    HsContainer(
                      width: 40.w,
                      height: 40.w,
                      onTap: onTapBackButton ?? () => context.pop(),
                      child: Center(child: Icon(Icons.chevron_left_sharp)),
                    ),

                    //* space
                    SizedBox(width: 16.w),
                  ],
                )
              : const SizedBox.shrink(),

          //* title
          subtitle != null
              ? Column(
                  crossAxisAlignment: .start,
                  children: [
                    txt(
                      title ?? "title",
                      style: context.textTheme.headlineLarge,
                    ),

                    SizedBox(height: 2.h),

                    txt(
                      subtitle ?? "subtitle",
                      style: context.textTheme.bodyMedium,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ],
                )
              : txt(title ?? "title", style: context.textTheme.headlineLarge),

          //* space
          const Spacer(),

          //* leading
          leading ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
