import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/presentation/bloc/trips_state.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripdetailsBottomNav extends StatelessWidget {
  final TripEntity trip;
  final TripsState state;

  const TripdetailsBottomNav({
    super.key,
    required this.trip,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        spacing: 6.w,
        children: [
          Expanded(
            child: HsButton(
              child: txt(
                state.isUpdatingStatus ? 'در حال شروع سفر...' : 'شروع سفر',
              ),
            ),
          ),

          HsButton(
            width: 50.w,
            height: 50.h,
            hsButtonType: HsButtonType.outline,
            child: Icon(LucideIcons.mapPinPen),
          ),

          HsButton(
            width: 50.w,
            height: 50.h,
            hsButtonType: HsButtonType.outline,
            borderColor: context.colorScheme.error,
            child: Icon(LucideIcons.trash, color: context.colorScheme.error),
          ),
        ],
      ),
    );
  }
}
