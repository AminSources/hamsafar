import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/enums/chip_mode.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;
  final bool? centerTitle;
  final bool? hasBackButton;
  final bool? hasChip;
  final ChipMode? chipMode;

  const AppBarWidget({
    super.key,
    this.title,
    this.centerTitle,
    this.hasBackButton,
    this.hasChip = false,
    this.chipMode = ChipMode.info,
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
        const Spacer(),

        hasChip!
            ? Chip(
                label: txt(
                  "مرحله 1 از 1",
                  color: chipMode == ChipMode.info
                      ? context.colorScheme.primary
                      : context.colorScheme.secondary,
                ),
                backgroundColor: chipMode == ChipMode.info
                    ? context.colorScheme.primaryContainer
                    : context.colorScheme.secondaryContainer,
              )
            : const SizedBox(),
      ],
    );
  }
}
