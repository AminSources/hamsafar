import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class MyItemsPage extends StatefulWidget {
  const MyItemsPage({super.key});

  @override
  State<MyItemsPage> createState() => _MyItemsPageState();
}

class _MyItemsPageState extends State<MyItemsPage> {
  //* items data model
  final Map<String, List<Map<String, dynamic>>> _itemsByCategory = {
    'کمپینگ 🏕': [
      {'name': 'چادر ۲ نفره', 'status': 'آماده برای سفر', 'available': true},
      {'name': 'کیسه خواب', 'status': 'آماده برای سفر', 'available': true},
    ],
    'آشپزخانه 🍳': [
      {
        'name': 'اجاق گاز مسافرتی',
        'status': 'آماده برای سفر',
        'available': true,
      },
      {'name': 'ست ظروف پخت', 'status': 'در دسترس نیست', 'available': false},
    ],
    'ابزار 🔧': [
      {
        'name': 'جعبه کمک‌های اولیه',
        'status': 'در دسترس نیست',
        'available': false,
      },
      {'name': 'چراغ‌قوه', 'status': 'آماده برای سفر', 'available': true},
    ],
  };

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
              HsAppBar(title: 'وسایل من 🎒', hasBack: true),
              SizedBox(height: 16.h),

              //* description box
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 12.r,
                color: context.colorScheme.primaryContainer,
                borderColor: Colors.transparent,
                child: txt(
                  'وسایلی که می‌توانید در سفرها همراه بیاورید؛ لیدر بر اساس این لیست وظایف را تقسیم می‌کند.',
                  style: context.textTheme.bodyMedium,
                  color: context.colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(height: 24.h),

              //* categories list
              ..._itemsByCategory.entries.map((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* category title
                    txt(category.key, style: context.textTheme.titleMedium),
                    SizedBox(height: 12.h),

                    //* items in category
                    ...category.value.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final item = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: HsContainer(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          radius: 14.r,
                          color: context.colorScheme.surface,
                          child: Row(
                            children: [
                              //* item info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //* item name
                                    txt(
                                      item['name'],
                                      style: context.textTheme.titleSmall,
                                    ),
                                    SizedBox(height: 6.h),

                                    //* status row
                                    Row(
                                      children: [
                                        //* status dot
                                        Container(
                                          width: 8.w,
                                          height: 8.w,
                                          decoration: BoxDecoration(
                                            color: item['available']
                                                ? context.colorScheme.primary
                                                : context
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 6.w),

                                        //* status text
                                        txt(
                                          item['status'],
                                          style: context.textTheme.bodySmall,
                                          color: item['available']
                                              ? context.colorScheme.primary
                                              : context
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              //* toggle switch
                              Switch.adaptive(
                                value: item['available'],
                                onChanged: (value) {
                                  setState(() {
                                    _itemsByCategory[category
                                            .key]![idx]['available'] =
                                        value;
                                    _itemsByCategory[category
                                        .key]![idx]['status'] = value
                                        ? 'آماده برای سفر'
                                        : 'در دسترس نیست';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 8.h),
                  ],
                );
              }),

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
