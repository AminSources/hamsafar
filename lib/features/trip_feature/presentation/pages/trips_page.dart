import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/app_bar_widget.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_feature/presentation/widgets/trip_item.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                //* appbar of page
                AppBarWidget(
                  title: "سفر های من",
                  leading: SizedBox(
                    width: 140.w,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      label: txt("سفر جدید"),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),

                //* space
                SizedBox(height: 15.h),

                //* trips
                Column(
                  children: List.generate(5, (index) {
                    return TripItem();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
