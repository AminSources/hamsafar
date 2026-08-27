import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/chip_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/enums/chip_mode.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_appbar_widget.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_billboard_widget.dart';
import 'package:hamsafar/features/home_feature/presentation/widgets/home_trip_task_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            //* app bar
            HomeAppbarWidget(),

            //* space
            SizedBox(height: 20.h),

            //* billboard
            HomeBillboardWidget(),

            //* space
            SizedBox(height: 20.h),

            //* trip tasks (title)
            Row(
              textDirection: .rtl,
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  textDirection: .rtl,
                  children: [
                    //* title
                    txt("کارهای در انتظار", style: context.textTheme.bodyLarge),

                    //* task count
                    ChipWidget(label: txt("3"), chipMode: ChipMode.warning),
                  ],
                ),

                //* see all button
                TextButton(onPressed: () {}, child: txt("همه")),
              ],
            ),

            //* space
            SizedBox(height: 10.h),

            //* trip tasks (list)
            Column(
              children: [
                HomeTripTaskItem(
                  title: "رای گیری",
                  description: "کوه عینالی - رای گیری فعال",
                  avatarIcon: Icons.payment_rounded,
                  onTap: () {},
                ),

                //* space
                SizedBox(height: 10.h),

                HomeTripTaskItem(
                  title: "پرداخت سهم",
                  description: "کوه عینالی - صندوق سفر",
                  avatarIcon: Icons.payment_rounded,
                  onTap: () {},
                ),

                //* space
                SizedBox(height: 10.h),
                HomeTripTaskItem(
                  title: "وظایف سفر",
                  description: "کوه عینالی - رای گیری فعال",
                  avatarIcon: Icons.payment_rounded,
                  onTap: () {},
                ),
              ],
            ),

            //* space
            SizedBox(height: 20.h),

            Row(
              textDirection: .rtl,
              mainAxisAlignment: .spaceBetween,
              children: [
                txt("فعالیت های اخیر", style: context.textTheme.bodyLarge),

                //* see all button
                TextButton(onPressed: () {}, child: txt("همه")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
