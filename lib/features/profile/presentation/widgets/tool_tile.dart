import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class ToolTile extends StatelessWidget {
  final String toolName;
  final bool? toolStatus;
  final ValueChanged<bool>? onChanged;

  const ToolTile({
    super.key,
    required this.toolName,
    this.toolStatus = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return HsTile(
      trailing: Switch(value: toolStatus!, onChanged: onChanged),

      child: Column(
        spacing: 6.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* tool name
          txt(toolName, style: context.textTheme.titleSmall),

          //* tool status (available or not)
          Row(
            spacing: 6.w,
            children: [
              Icon(
                Icons.circle_rounded,
                size: 8.sp,
                color: toolStatus!
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurfaceVariant,
              ),
              txt(
                toolStatus! ? 'اماده برای سفر' : "دردسترس نیست",
                color: toolStatus!
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
