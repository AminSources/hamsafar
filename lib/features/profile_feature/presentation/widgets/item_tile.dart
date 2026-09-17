import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class ItemTile extends StatelessWidget {
  final String itemName;
  final bool? itemStatus;
  final ValueChanged<bool>? onChanged;

  const ItemTile({
    super.key,
    required this.itemName,
    this.itemStatus = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 6.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* tool name
              txt("چادر", style: context.textTheme.titleSmall),

              //* tool status (available or not)
              Row(
                spacing: 6.w,
                children: [
                  Icon(
                    Icons.circle_rounded,
                    size: 8.sp,
                    color: itemStatus!
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurfaceVariant,
                  ),
                  txt(
                    itemStatus! ? 'اماده برای سفر' : "دردسترس نیست",
                    color: itemStatus!
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),

          //* switch
          Switch(value: itemStatus!, onChanged: onChanged),
        ],
      ),
    );
  }
}
