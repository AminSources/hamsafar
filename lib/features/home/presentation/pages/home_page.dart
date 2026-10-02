import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/hs_error.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home/enums/home_trip_enum.dart';
import 'package:hamsafar/features/home/presentation/bloc/home_bloc.dart';
import 'package:hamsafar/features/home/presentation/widgets/home_action_cards_row.dart';
import 'package:hamsafar/features/home/presentation/widgets/home_activities.dart';
import 'package:hamsafar/features/home/presentation/widgets/home_trip_card.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.status = HomeTripStatus.preparing});

  final HomeTripStatus status;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool get _isInTrip => widget.status == HomeTripStatus.inTrip;

  @override
  void initState() {
    context.read<HomeBloc>().add(LoadHomeEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  child: txt(
                    "How are you? (Something went wrong on the server)",
                  ),
                );
              }
              if (state is HomeSuccess) {
                //* cast
                final homeData = state.homeEntity;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* appbar
                    HsAppBar(
                      title: _isInTrip
                          ? 'سفر خوبی داشته باشی!'
                          : 'سلام، ${homeData.profile.firstName}! 👋',
                      subtitle: _isInTrip
                          ? 'روز دوم از سفر شمال'
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
                            color: AppColors.avatars[0],
                            type: HsAvatarType.profile,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    homeData.currentTrip.isNotEmpty
                        ? Column(
                            children: [
                              //* section header
                              HsHeader(
                                title: "سفر فعلی",
                                actionLabel: "جزئیات کامل",
                                onTap: () {
                                  //? navigate to trip details
                                  context.push('/trip-detail');
                                },
                              ),
                              SizedBox(height: 12.h),

                              //* trip card
                              HomeTripCard(isInTrip: _isInTrip),
                              SizedBox(height: 16.h),

                              //* action cards
                              HomeActionCardsRow(isInTrip: _isInTrip),
                              SizedBox(height: 24.h),

                              //* recent activities header
                              HsHeader(title: 'فعالیت‌های اخیر'),
                              SizedBox(height: 12.h),

                              //* recent activities list
                              HomeActivities(isInTrip: _isInTrip),
                              SizedBox(height: 65.h),
                            ],
                          )
                        : HsError(
                            illustrationPath:
                                "lib/assets/images/empty_trip.svg",
                            title: "شما هنوز عضو سفری نشده اید",
                            subtitle:
                                "برای عضویت یا ساخت سفر جدید به بخش سفرها مراجعه کنید",
                          ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
