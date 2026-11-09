import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_error.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:hamsafar/features/trips/presentation/widgets/trip_tile.dart';

import 'package:hamsafar/core/localization/app_translations.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TripsCubit>().loadMyTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HsAppBar(title: 'سفرها'),
              SizedBox(height: 20.h),
              TextField(
                readOnly: true,
                onTap: () => context.push('/trip-search'),
                decoration: InputDecoration(
                  hintText: AppTranslations.translate(context, 'جستجوی سفر...'),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              HsButton(
                onTap: () => context.push('/trip-create'),
                child: txt(
                  'ایجاد سفر جدید',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  size: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),
              txt(
                'سفر های من',
                style: context.textTheme.titleMedium,
                fontWeight: FontWeight.w800,
              ),
              SizedBox(height: 12.h),
              BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  if (state.isLoadingMyTrips) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state.errorMessage != null && state.myTrips.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          txt(state.errorMessage!, textAlign: TextAlign.center),
                          TextButton(
                            onPressed: () =>
                                context.read<TripsCubit>().loadMyTrips(),
                            child: const txt('تلاش دوباره'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state.myTrips.isEmpty) {
                    return const HsError(
                      illustrationPath: 'lib/assets/images/empty_trip.svg',
                      title: 'هنوز عضو سفری نیستید',
                      subtitle:
                          'می‌توانید یک سفر جدید ایجاد کنید یا سفرهای دیگران را جستجو کنید.',
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.myTrips.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) =>
                        TripTile(trip: state.myTrips[index]),
                  );
                },
              ),
              SizedBox(height: 65.h),
            ],
          ),
        ),
      ),
    );
  }
}
