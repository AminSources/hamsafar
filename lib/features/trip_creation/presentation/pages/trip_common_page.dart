import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_draft_bloc.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';

import 'package:hamsafar/core/localization/app_translations.dart';
class TripCommonPage extends StatelessWidget {
  const TripCommonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripDraftBloc, TripDraft>(
      builder: (context, draft) {
        final cubit = context.read<TripDraftBloc>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel('نام سفر *'),
              TextFormField(
                key: const ValueKey('trip-name'),
                initialValue: draft.name,
                textInputAction: TextInputAction.next,
                onChanged: (value) => cubit.add(TripNameChanged(value)),
                decoration: InputDecoration(
                  hintText: AppTranslations.translate(context, 'مثلاً سفر جنگل‌گردی شمال'),
                ),
              ),
              SizedBox(height: 16.h),
              _FieldLabel('توضیح کوتاه'),
              TextFormField(
                key: const ValueKey('trip-description'),
                initialValue: draft.description,
                maxLines: 3,
                onChanged: (value) => cubit.add(TripDescriptionChanged(value)),
                decoration: InputDecoration(
                  hintText: AppTranslations.translate(context, 'درباره برنامه و فعالیت‌های سفر بنویسید...'),
                ),
              ),
              SizedBox(height: 16.h),
              _FieldLabel('مقصد *'),
              TextFormField(
                key: const ValueKey('trip-location'),
                initialValue: draft.location,
                textInputAction: TextInputAction.next,
                onChanged: (value) => cubit.add(TripLocationChanged(value)),
                decoration: InputDecoration(
                  hintText: AppTranslations.translate(context, 'شهر یا مقصد سفر'),
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    size: 20.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              _FieldLabel('محل تجمع'),
              TextFormField(
                key: const ValueKey('trip-meeting-point'),
                initialValue: draft.meetingPoint,
                onChanged: (value) => cubit.add(TripMeetingPointChanged(value)),
                decoration: InputDecoration(
                  hintText: AppTranslations.translate(context, 'آدرس یا محل قرار اعضا'),
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
      },
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: txt(
        text,
        size: 12.sp,
        fontWeight: FontWeight.w700,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
