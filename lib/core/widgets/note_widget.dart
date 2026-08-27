import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class NoteWidget extends StatelessWidget {
  final String noteText;
  final IconData? noteIcon;

  const NoteWidget({super.key, required this.noteText, this.noteIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        //* icon
        noteIcon != null
            ? Icon(
                noteIcon,
                size: 14.sp,
                color: context.textTheme.bodySmall!.color,
              )
            : SizedBox(),

        //* space
        SizedBox(width: 10.w),

        //* note text
        Expanded(
          child: txt(
            noteText,
            textAlign: TextAlign.right,
            style: context.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
