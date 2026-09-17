import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/cubit/trip_stepper_cubit.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/pages/trip_budget_page.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/pages/trip_common_page.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/pages/trip_date_time_page.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/pages/trip_invitation_page.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/pages/trip_rules_page.dart';
import 'package:hamsafar/features/trip_creation_feature/presentation/widgets/trip_stepper.dart';

class TripCreationWrapper extends StatefulWidget {
  const TripCreationWrapper({super.key});

  @override
  State<TripCreationWrapper> createState() => _TripCreationWrapperState();
}

class _TripCreationWrapperState extends State<TripCreationWrapper> {
  final List<Widget> _pages = [
    TripCommonPage(),
    TripDateTimePage(),
    TripBudgetPage(),
    TripRulesPage(),
    TripInvitationPage(),
  ];

  final List<String> _titles = [
    "جزییات عمومی سفر",
    "تاریخ و ساعت سفر",
    "هزینه و بودجه سفر",
    "قوانین سفر",
    "دعوت اعضا از لیست دوستان",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocBuilder<TripStepperCubit, int>(
            builder: (context, state) {
              return Column(
                children: [
                  //* appbar
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: HsAppBar(
                      title: "ایجاد سفر جدید",
                      hasBack: true,
                      onTapBackButton: () {
                        if (state == 0) {
                          //? reset state
                          context.read<TripStepperCubit>().reset();

                          //? go to home page
                          context.pop();
                        } else {
                          //? go to previous step
                          context.read<TripStepperCubit>().previousStep();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),

                  //* step indicator card
                  TripStepper(title: _titles[state], stepperIndex: state),
                  SizedBox(height: 20.h),

                  //* step content
                  _pages[state],

                  //* continue button
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: HsButton(
                        onTap: () {
                          if (state >= 4) {
                            //? go to trip success page
                            context.push('/trip-success');

                            //? reset trip stepper state
                            context.read<TripStepperCubit>().reset();
                          } else {
                            //? go to next step
                            context.read<TripStepperCubit>().nextStep();
                          }
                        },
                        child: txt(
                          state == 4 ? 'ایجاد سفر' : 'ادامه',
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          size: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
