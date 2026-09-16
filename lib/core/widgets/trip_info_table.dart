import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/info_table_item.dart';

class TripInfoTable extends StatelessWidget {
  final List<String> labels;
  final List<String> values;
  final Color? borderColor;
  final Color? valueColor;
  final Color? labelColor;

  const TripInfoTable({
    super.key,
    this.borderColor,
    required this.labels,
    required this.values,
    this.valueColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: double.infinity,
      height: 75.h,
      radius: 15.r,
      borderColor: borderColor,
      alignment: Alignment.center,
      child: Center(
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          crossAxisAlignment: .center,
          children: List.generate(5, (index) {
            if (index.isOdd) {
              return Container(
                width: 1.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              );
            }

            //? this code (index >> 1) convert index 1,3,5 to 0,1,2
            final dataIndex = index >> 1;
            return InfoTableItem(
              label: labels[dataIndex],
              value: values[dataIndex],
              labelColor: labelColor,
              valueColor: valueColor,
            );
          }),
        ),
      ),
    );
  }
}
