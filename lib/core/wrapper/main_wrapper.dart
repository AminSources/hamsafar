import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/constants/app_strings.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home_feature/presentation/pages/home_page.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70.h,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: context.colorScheme.outline)),
        ),
        child: Row(
          textDirection: .rtl,
          mainAxisAlignment: .spaceAround,
          children: List.generate(
            4,
            (index) => Column(
              mainAxisAlignment: .center,
              children: [
                //* icon
                Icon(
                  AppStrings.bottomNavBarIcons[index],
                  color: index == 0 ? context.colorScheme.primary : null,
                ),

                //* title
                txt(
                  AppStrings.bottomNavBarTitle[index],
                  style: context.textTheme.bodySmall,
                  color: index == 0 ? context.colorScheme.primary : null,
                ),
              ],
            ),
          ),
        ),
      ),

      body: SizedBox.expand(child: PageView(children: [HomePage()])),
    );
  }
}
