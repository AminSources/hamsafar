import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;
  final bool? centerTitle;
  final bool? hasBackButton;

  const AppBarWidget({
    super.key,
    this.title,
    this.centerTitle,
    this.hasBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: centerTitle ?? false
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        //* back button
        hasBackButton != null
            ? HsContainer(
                width: 40.w,
                height: 40.w,
                onTap: () {
                  //? pop page
                  Navigator.pop(context);
                },
                child: Center(child: Icon(Icons.chevron_right_rounded)),
              )
            : SizedBox(),

        //* space
        SizedBox(width: 15.w),

        //* title
        txt(title ?? "title", style: context.textTheme.headlineLarge),

        //* space
        const SizedBox(),
      ],
    );
  }
}
