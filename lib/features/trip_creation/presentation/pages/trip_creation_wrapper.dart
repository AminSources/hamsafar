import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_stepper_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_common_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_expense_setup_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_invitation_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_rules_setup_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_schedule_setup_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_stepper.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_entity.dart';
import 'package:hamsafar/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:hamsafar/locator.dart';

class TripCreationWrapper extends StatelessWidget {
  final TripEntity? trip;

  const TripCreationWrapper({super.key, this.trip});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TripDraftCubit>()..initialize(trip),
      child: _TripCreationContent(trip: trip),
    );
  }
}

class _TripCreationContent extends StatefulWidget {
  final TripEntity? trip;

  const _TripCreationContent({this.trip});

  @override
  State<_TripCreationContent> createState() => _TripCreationContentState();
}

class _TripCreationContentState extends State<_TripCreationContent> {
  final List<String> _titles = const [
    'جزئیات عمومی سفر',
    'تاریخ و ساعت سفر',
    'هزینه و بودجه سفر',
    'قوانین سفر',
    'دعوت اعضا از لیست دوستان',
  ];

  @override
  void initState() {
    super.initState();
    context.read<TripStepperCubit>().reset();
  }

  Future<void> _save(TripDraft draft) async {
    if (draft.name.trim().isEmpty) {
      context.showHsSnackBar(
        text: 'نام سفر را وارد کنید.',
        hsSnackBarType: HsSnackBarType.warning,
      );
      return;
    }
    if (draft.location.trim().isEmpty) {
      context.showHsSnackBar(
        text: 'مقصد سفر را وارد کنید.',
        hsSnackBarType: HsSnackBarType.warning,
      );
      return;
    }
    if (!draft.returnAt.isAfter(draft.departureAt)) {
      context.showHsSnackBar(
        text: 'زمان برگشت باید بعد از زمان رفت باشد.',
        hsSnackBarType: HsSnackBarType.warning,
      );
      return;
    }

    final tripId = await context.read<TripsCubit>().saveTrip(
          draft,
          tripId: widget.trip?.id,
        );
    if (!mounted) return;

    if (tripId == null) {
      final message = context.read<TripsCubit>().state.errorMessage ??
          'ذخیره سفر انجام نشد.';
      context.showHsSnackBar(
        text: message,
        hsSnackBarType: HsSnackBarType.error,
      );
      return;
    }

    context.read<TripStepperCubit>().reset();
    if (widget.trip != null) {
      context.pop(true);
    } else {
      context.go('/trip-success', extra: tripId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [
      TripCommonPage(),
      TripScheduleSetupPage(),
      TripExpenseSetupPage(),
      TripRulesSetupPage(),
      TripInvitationPage(),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocBuilder<TripStepperCubit, int>(
            builder: (context, step) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: HsAppBar(
                      title: widget.trip == null ? 'ایجاد سفر جدید' : 'ویرایش سفر',
                      hasBack: true,
                      onTapBackButton: () {
                        if (step == 0) {
                          context.read<TripStepperCubit>().reset();
                          context.pop();
                        } else {
                          context.read<TripStepperCubit>().previousStep();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TripStepper(title: _titles[step], stepperIndex: step),
                  SizedBox(height: 20.h),
                  pages[step],
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: BlocBuilder<TripsCubit, TripsState>(
                        builder: (context, tripsState) {
                          return HsButton(
                            onTap: tripsState.isSaving
                                ? null
                                : () {
                                    if (step >= 4) {
                                      _save(context.read<TripDraftCubit>().state);
                                    } else {
                                      context.read<TripStepperCubit>().nextStep();
                                    }
                                  },
                            child: tripsState.isSaving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : txt(
                                    step == 4
                                        ? (widget.trip == null
                                            ? 'ایجاد سفر'
                                            : 'ذخیره تغییرات')
                                        : 'ادامه',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    size: 14.sp,
                                  ),
                          );
                        },
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
