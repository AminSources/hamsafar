import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsNote extends StatelessWidget {
  final String note;
  final HsNoteType? noteMode;

  const HsNote({super.key, required this.note, this.noteMode});

  @override
  Widget build(BuildContext context) {
    //? note bg , text color
    Color noteBg;
    Color noteFg;

    switch (noteMode) {
      case HsNoteType.info:
        noteBg = context.colorScheme.surfaceContainer;
        noteFg = context.colorScheme.onSurfaceVariant;
        break;
      case HsNoteType.warning:
        noteBg = context.colorScheme.onSecondaryContainer;
        noteFg = context.colorScheme.onSecondary;
        break;
      case HsNoteType.error:
        noteBg = context.colorScheme.errorContainer;
        noteFg = context.colorScheme.onErrorContainer;
        break;
      case HsNoteType.success:
        noteBg = context.colorScheme.onPrimaryContainer;
        noteFg = context.colorScheme.onPrimary;
        break;
      default:
        noteBg = context.colorScheme.surfaceContainer;
        noteFg = context.colorScheme.onSurfaceVariant;
        break;
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: noteBg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 18.sp, color: noteFg),
          SizedBox(width: 8.w),
          Expanded(
            child: txt(
              note,
              size: 12.sp,
              color: noteFg,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
