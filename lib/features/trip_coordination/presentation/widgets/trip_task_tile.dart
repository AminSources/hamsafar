import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_check_box.dart';
import 'package:hamsafar/core/widgets/hs_tile.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripTaskTile extends StatelessWidget {
  final String task;
  final bool isDone;
  final ValueChanged<bool>? onDone;
  final String name;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TripTaskTile({
    super.key,
    required this.task,
    required this.isDone,
    required this.onDone,
    required this.name,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return HsTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Row(
            children: [
              HsCheckBox(value: isDone, onTap: onDone),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  task,
                  style: context.textTheme.bodyMedium?.copyWith(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    color: isDone
                        ? context.colorScheme.onSurfaceVariant
                        : context.colorScheme.onSurface,
                  ),
                ),
              ),
              if (onEdit != null || onDelete != null)
                PopupMenuButton<String>(
                  tooltip: 'مدیریت وظیفه',
                  onSelected: (value) {
                    if (value == 'edit') onEdit?.call();
                    if (value == 'delete') onDelete?.call();
                  },
                  itemBuilder: (context) => [
                    if (onEdit != null)
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('ویرایش وظیفه'),
                      ),
                    if (onDelete != null)
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('حذف وظیفه'),
                      ),
                  ],
                ),
            ],
          ),
          Row(
            spacing: 8.w,
            children: [
              HsAvatar(
                label: txt(name.isEmpty ? '؟' : name[0]),
                size: 24.w,
                color: getAvatarColor(name),
                type: HsAvatarType.profile,
              ),
              txt(name, style: context.textTheme.bodySmall),
              if (isDone)
                Icon(
                  Icons.check_circle,
                  size: 15.sp,
                  color: context.colorScheme.primary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
