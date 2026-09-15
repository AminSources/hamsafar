import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripCommonPage extends StatelessWidget {
  const TripCommonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //* trip name label
          txt(
            "نام سفر *",
            size: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          //* trip name field
          TextField(
            decoration: InputDecoration(hintText: 'سفر جنگل‌گردی شمال'),
          ),
          SizedBox(height: 16.h),

          //* description label
          txt(
            "توضیح کوتاه",
            size: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          //* description field
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  'دو روز طبیعت‌گردی در جنگل‌های چالوس همراه با کمپینگ و آبشارگردی 🌲',
            ),
          ),
          SizedBox(height: 16.h),

          //* destination label
          txt(
            "مقصد *",
            size: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          //* destination field
          TextField(
            readOnly: true,
            onTap: () {},
            decoration: InputDecoration(
              hintText: 'تعیین آدرس دقیق روی نقشه',
              prefixIcon: Icon(
                Icons.location_on_outlined,
                size: 20.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          //* gathering point label
          txt(
            "محل تجمع",
            size: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          //* gathering point field
          TextField(
            decoration: InputDecoration(
              hintText: 'میدان ونک، جنب پمپ بنزین',
              prefixIcon: Icon(
                Icons.place_outlined,
                size: 20.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
