import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/presentation/bloc/trip_vote_bloc.dart';
import 'package:hamsafar/features/trip_coordination/presentation/widgets/vote_option_card.dart';

class TripVotePage extends StatelessWidget {
  const TripVotePage({super.key});

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<TripVoteBloc>();
    if (bloc.state.isLoading || bloc.state.submittingTripIds.isNotEmpty) {
      return;
    }

    final completed = bloc.stream.firstWhere((state) => !state.isLoading);
    bloc.add(const TripVotesLoadRequested());
    await completed;
  }

  String _formatDateTime(DateTime value) {
    final date = value.toLocal();
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$year/$month/$day - $hour:$minute';
  }

  Widget _buildPollCard(
    BuildContext context,
    DeparturePollEntity poll,
    TripVoteState state,
  ) {
    final selectedOptionId = state.selectedOptionIds[poll.tripId];
    final savedOptionId = poll.myOptionId;
    final totalVotes = poll.options.fold<int>(
      0,
      (sum, option) => sum + option.voteCount,
    );
    final hasChangedVote =
        selectedOptionId != null && selectedOptionId != savedOptionId;
    final isSubmitting = state.submittingTripIds.contains(poll.tripId);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          txt(
            poll.tripName.isEmpty ? 'سفر' : poll.tripName,
            style: context.textTheme.titleMedium,
            fontWeight: FontWeight.w800,
          ),
          if (poll.location?.trim().isNotEmpty == true) ...[
            SizedBox(height: 4.h),
            txt(
              poll.location!,
              style: context.textTheme.bodySmall,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
          SizedBox(height: 16.h),
          txt(
            'زمان حرکت چه موقع باشد؟',
            style: context.textTheme.titleSmall,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 10.h),
          if (poll.options.isEmpty)
            const HsNote(note: 'برای این سفر هنوز بازه‌ای ثبت نشده است.'),
          ...poll.options.map((option) {
            final percent =
                totalVotes == 0 ? 0.0 : option.voteCount / totalVotes;
            final isSelected = selectedOptionId == option.id;
            final title =
                '${_formatDateTime(option.startsAt)} تا '
                '${_formatDateTime(option.endsAt)}';

            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: VoteOptionCard(
                title: title,
                percent: percent,
                vote: option.voteCount,
                isVoted: isSelected,
                onVote: (selected) {
                  if (!selected || isSubmitting) return;
                  context.read<TripVoteBloc>().add(
                        TripVoteSelectionChanged(
                          tripId: poll.tripId,
                          optionId: option.id,
                        ),
                      );
                },
              ),
            );
          }),
          SizedBox(height: 4.h),
          HsButton(
            width: double.infinity,
            onTap: hasChangedVote && !isSubmitting
                ? () => context
                    .read<TripVoteBloc>()
                    .add(TripVoteSubmissionRequested(poll.tripId))
                : null,
            child: isSubmitting
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : txt(
                    savedOptionId == null
                        ? 'ثبت رأی'
                        : hasChangedVote
                            ? 'ثبت تغییر رأی'
                            : 'رأی شما ثبت شده است',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripVoteBloc, TripVoteState>(
      listener: (context, state) {
        if (state.feedback == null) return;
        context.showHsSnackBar(
          text: state.feedback!,
          hsSnackBarType: state.feedbackIsSuccess == true
              ? HsSnackBarType.success
              : HsSnackBarType.error,
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state.isLoading && state.polls.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        child: const HsAppBar(
                          title: 'رأی‌گیری سفرها',
                          hasBack: true,
                        ),
                      ),
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  )
                : RefreshIndicator(
                    onRefresh: () => _refresh(context),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: const HsAppBar(
                              title: 'رأی‌گیری سفرها',
                              hasBack: true,
                            ),
                          ),
                          if (state.isLoading) const LinearProgressIndicator(),
                          SizedBox(height: 8.h),
                          if (state.errorMessage != null &&
                              state.polls.isEmpty) ...[
                            HsNote(note: state.errorMessage!),
                            SizedBox(height: 12.h),
                            HsButton(
                              width: double.infinity,
                              onTap: () => context.read<TripVoteBloc>().add(
                                    const TripVotesLoadRequested(),
                                  ),
                              child: txt(
                                'تلاش مجدد',
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ] else if (state.polls.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 80.h),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.how_to_vote_outlined,
                                      size: 54.sp,
                                      color:
                                          context.colorScheme.onSurfaceVariant,
                                    ),
                                    SizedBox(height: 16.h),
                                    txt(
                                      'رأی‌گیری فعالی وجود ندارد.',
                                      style: context.textTheme.titleMedium,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(height: 8.h),
                                    txt(
                                      'وقتی برای یکی از سفرهای شما رأی‌گیری زمان حرکت ایجاد شود، اینجا نمایش داده می‌شود.',
                                      textAlign: TextAlign.center,
                                      color:
                                          context.colorScheme.onSurfaceVariant,
                                      size: 12.sp,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else ...[
                            const HsNote(
                              note:
                                  'برای هر سفر یکی از بازه‌های پیشنهادی را انتخاب کنید. بعد از ثبت رأی هم می‌توانید انتخاب خود را تغییر دهید.',
                            ),
                            SizedBox(height: 16.h),
                            ...state.polls.map(
                              (poll) => _buildPollCard(context, poll, state),
                            ),
                          ],
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
