import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_error.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home/presentation/bloc/home_bloc.dart';
import 'package:hamsafar/features/home/presentation/widgets/home_action_cards_row.dart';
import 'package:hamsafar/features/home/presentation/widgets/home_activities.dart';
import 'package:hamsafar/features/home/presentation/widgets/home_trip_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final bloc = context.read<HomeBloc>();
            bloc.add(LoadHomeEvent());
            await bloc.stream.firstWhere(
              (state) => state is HomeSuccess || state is HomeFailed,
            );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeFailed) {
                  context.showHsSnackBar(
                    text: state.message,
                    hsSnackBarType: HsSnackBarType.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HomeFailed) {
                  return Center(child: txt(state.message));
                }
                if (state is HomeInitial) {
                  return const Center(
                    child: txt('اطلاعات صفحهٔ خانه هنوز بارگذاری نشده است.'),
                  );
                }
                if (state is! HomeSuccess) return const SizedBox.shrink();

                final homeData = state.homeEntity;
                final currentTrip = homeData.currentTrip.isEmpty
                    ? null
                    : homeData.currentTrip.first;
                final isInTrip = currentTrip?.isInTrip ?? false;
                final tripId = int.tryParse(currentTrip?.id ?? '');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HsAppBar(
                      title: isInTrip
                          ? 'سفر خوبی داشته باشی!'
                          : 'سلام، ${homeData.profile.firstName}! 👋',
                      subtitle: isInTrip
                          ? 'سفر شما در حال اجراست'
                          : 'آماده‌ی سفر بعدی هستی؟',
                      leading: Row(
                        children: [
                          HsContainer(
                            width: 42.w,
                            height: 42.w,
                            onTap: () {},
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.notifications_none_rounded,
                                    size: 22.sp,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Positioned(
                                  top: 9.h,
                                  right: 11.w,
                                  child: Container(
                                    width: 8.w,
                                    height: 8.w,
                                    decoration: BoxDecoration(
                                      color: context.colorScheme.error,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: context.colorScheme.surface,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          HsAvatar(
                            label: Icon(
                              AvatarConverter.stringToIconData(
                                avatarName: homeData.profile.avatarIcon,
                              ),
                            ),
                            size: 42.w,
                            color: getAvatarColor(
                              '${homeData.profile.firstName} ${homeData.profile.lastName}',
                            ),
                            type: HsAvatarType.profile,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    if (currentTrip != null)
                      Column(
                        children: [
                          HsHeader(
                            title: 'سفر فعلی',
                            actionLabel: 'جزئیات کامل',
                            onTap: tripId == null
                                ? null
                                : () => context.push(
                                    '/trip-detail',
                                    extra: tripId,
                                  ),
                          ),
                          SizedBox(height: 12.h),
                          HomeTripCard(trip: currentTrip, isInTrip: isInTrip),
                          SizedBox(height: 16.h),
                          HomeActionCardsRow(
                            isInTrip: isInTrip,
                            tripId: tripId,
                          ),
                          SizedBox(height: 24.h),
                          HsHeader(title: 'فعالیت‌های اخیر'),
                          SizedBox(height: 12.h),
                          HomeActivities(activities: homeData.activities),
                          SizedBox(height: 65.h),
                        ],
                      )
                    else
                      const HsError(
                        illustrationPath: 'lib/assets/images/empty_trip.svg',
                        title: 'شما هنوز عضو سفری نشده اید',
                        subtitle:
                            'برای عضویت یا ساخت سفر جدید به بخش سفرها مراجعه کنید',
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
