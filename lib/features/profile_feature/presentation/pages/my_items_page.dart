import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/note_enums.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile_feature/presentation/widgets/item_tile.dart';

class MyItemsPage extends StatefulWidget {
  const MyItemsPage({super.key});

  @override
  State<MyItemsPage> createState() => _MyItemsPageState();
}

class _MyItemsPageState extends State<MyItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              HsAppBar(title: 'وسایل من', hasBack: true),
              SizedBox(height: 16.h),

              //* description box
              HsNote(
                note:
                    'وسایلی که می‌توانید در سفرها همراه بیاورید؛ لیدر بر اساس این لیست وظایف را تقسیم می‌کند.',
                noteMode: NoteMode.success,
              ),
              SizedBox(height: 24.h),

              //* categories list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
                    child: ItemTile(
                      itemName: [
                        "چادر",
                        "گاز",
                        "زیر انداز",
                        "پاسور",
                        "دوربین عکاسی",
                        "پتو",
                      ][index],
                      itemStatus: [
                        true,
                        true,
                        false,
                        false,
                        true,
                        false,
                      ][index],
                      onChanged: (value) {},
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),

              //* add new item button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_rounded, size: 20.sp),
                  label: txt(
                    'افزودن وسیله جدید',
                    style: context.textTheme.labelLarge,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
