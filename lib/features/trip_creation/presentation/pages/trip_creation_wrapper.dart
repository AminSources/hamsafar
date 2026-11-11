import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friends_usecase.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_creation_initial_data.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_creation_bloc.dart';
import 'package:hamsafar/features/trip_creation/domain/usecases/save_trip_usecase.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_draft_bloc.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_stepper_bloc.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_common_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_expense_setup_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_invitation_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_rules_setup_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/pages/trip_schedule_setup_page.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_stepper.dart';

class TripCreationWrapper extends StatelessWidget {
  final TripCreationInitialData? initialData;
  final GetFriendsUsecase getFriendsUsecase;
  final SaveTripUseCase saveTripUseCase;

  const TripCreationWrapper({
    super.key,
    this.initialData,
    required this.getFriendsUsecase,
    required this.saveTripUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              TripStepperBloc()..add(const TripStepperResetRequested()),
        ),
        BlocProvider(
          create: (_) =>
              TripDraftBloc()..add(TripDraftInitialized(initialData)),
        ),
        BlocProvider(
          create: (_) => TripCreationBloc(saveTripUseCase: saveTripUseCase),
        ),
      ],
      child: _TripCreationContent(
        isEditing: initialData != null,
        tripId: initialData?.tripId,
        getFriendsUsecase: getFriendsUsecase,
      ),
    );
  }
}

class _TripCreationContent extends StatefulWidget {
  final bool isEditing;
  final int? tripId;
  final GetFriendsUsecase getFriendsUsecase;

  const _TripCreationContent({
    required this.isEditing,
    this.tripId,
    required this.getFriendsUsecase,
  });

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

  void _save(TripDraft draft) {
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
    if (draft.scheduleType == 'voting' && draft.departureOptions.length < 2) {
      context.showHsSnackBar(
        text: 'برای رأی‌گیری حداقل دو بازهٔ پیشنهادی ثبت کنید.',
        hsSnackBarType: HsSnackBarType.warning,
      );
      return;
    }
    if (draft.scheduleType == 'voting' &&
        draft.departureOptions.any(
          (option) => !option.endsAt.isAfter(option.startsAt),
        )) {
      context.showHsSnackBar(
        text: 'پایان هر بازه باید بعد از شروع آن باشد.',
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

    context.read<TripCreationBloc>().add(
      TripCreationSaveRequested(draft, tripId: widget.tripId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const TripCommonPage(),
      const TripScheduleSetupPage(),
      const TripExpenseSetupPage(),
      const TripRulesSetupPage(),
      TripInvitationPage(getFriendsUsecase: widget.getFriendsUsecase),
    ];

    return Scaffold(
      body: BlocListener<TripCreationBloc, TripCreationState>(
        listener: (context, state) {
          if (state.isSaving) return;
          if (state.errorMessage != null) {
            context.showHsSnackBar(
              text: state.errorMessage!,
              hsSnackBarType: HsSnackBarType.error,
            );
            return;
          }
          final savedTripId = state.savedTripId;
          if (savedTripId == null) return;

          context.read<TripStepperBloc>().add(
            const TripStepperResetRequested(),
          );
          context.pop(savedTripId);
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: BlocBuilder<TripStepperBloc, int>(
              builder: (context, step) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: HsAppBar(
                        title: widget.isEditing
                            ? 'ویرایش سفر'
                            : 'ایجاد سفر جدید',
                        hasBack: true,
                        onTapBackButton: () {
                          if (step == 0) {
                            context.read<TripStepperBloc>().add(
                              const TripStepperResetRequested(),
                            );
                            context.pop();
                          } else {
                            context.read<TripStepperBloc>().add(
                              const TripStepperPreviousRequested(),
                            );
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
                        child: BlocBuilder<TripCreationBloc, TripCreationState>(
                          builder: (context, state) {
                            return HsButton(
                              onTap: state.isSaving
                                  ? null
                                  : () {
                                      if (step >= 4) {
                                        _save(
                                          context.read<TripDraftBloc>().state,
                                        );
                                      } else {
                                        context.read<TripStepperBloc>().add(
                                          const TripStepperNextRequested(),
                                        );
                                      }
                                    },
                              child: state.isSaving
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
                                          ? (widget.isEditing
                                                ? 'ذخیره تغییرات'
                                                : 'ایجاد سفر')
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
      ),
    );
  }
}
