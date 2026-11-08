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
import 'package:hamsafar/features/trip_coordination/presentation/widgets/vote_option_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripVotePage extends StatefulWidget {
  const TripVotePage({super.key});

  @override
  State<TripVotePage> createState() => _TripVotePageState();
}

class _TripVotePageState extends State<TripVotePage> {
  final SupabaseClient _client = Supabase.instance.client;
  final Map<int, int?> _selectedOptionIds = {};
  final Set<int> _submittingTripIds = {};

  List<Map<String, dynamic>> _polls = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPolls();
  }

  Future<void> _loadPolls({bool showLoading = true}) async {
    if (showLoading && mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final response = await _client.rpc('get_my_departure_polls');
      final rows = List<Map<String, dynamic>>.from(
        (response as List).map(
          (row) => Map<String, dynamic>.from(row as Map),
        ),
      );

      if (!mounted) return;

      final selectedOptions = <int, int?>{};
      for (final poll in rows) {
        final tripId = (poll['trip_id'] as num).toInt();
        selectedOptions[tripId] = (poll['my_option_id'] as num?)?.toInt();
      }

      setState(() {
        _polls = rows;
        _selectedOptionIds
          ..clear()
          ..addAll(selectedOptions);
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'دریافت رأی‌گیری‌ها انجام نشد. اتصال اینترنت را بررسی کنید.';
      });
    }
  }

  String _formatDateTime(String value) {
    final date = DateTime.parse(value).toLocal();
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$year/$month/$day - $hour:$minute';
  }

  String _optionTitle(Map<String, dynamic> option) {
    final start = _formatDateTime(option['starts_at'] as String);
    final end = _formatDateTime(option['ends_at'] as String);
    return '$start تا $end';
  }

  Future<void> _submitVote(int tripId) async {
    final optionId = _selectedOptionIds[tripId];
    if (optionId == null || _submittingTripIds.contains(tripId)) return;

    setState(() => _submittingTripIds.add(tripId));

    try {
      await _client.rpc(
        'cast_departure_vote',
        params: {
          'p_trip_id': tripId,
          'p_option_id': optionId,
        },
      );

      await _loadPolls(showLoading: false);
      if (!mounted) return;

      context.showHsSnackBar(
        text: 'رأی شما با موفقیت ثبت شد.',
        hsSnackBarType: HsSnackBarType.success,
      );
    } catch (_) {
      if (!mounted) return;
      context.showHsSnackBar(
        text: 'ثبت رأی انجام نشد. دوباره تلاش کنید.',
        hsSnackBarType: HsSnackBarType.error,
      );
    } finally {
      if (mounted) {
        setState(() => _submittingTripIds.remove(tripId));
      }
    }
  }

  Widget _buildPollCard(Map<String, dynamic> poll) {
    final tripId = (poll['trip_id'] as num).toInt();
    final options = List<Map<String, dynamic>>.from(
      (poll['options'] as List? ?? const []).map(
        (option) => Map<String, dynamic>.from(option as Map),
      ),
    );
    final selectedOptionId = _selectedOptionIds[tripId];
    final savedOptionId = (poll['my_option_id'] as num?)?.toInt();
    final totalVotes = options.fold<int>(
      0,
      (sum, option) => sum + ((option['vote_count'] as num?)?.toInt() ?? 0),
    );
    final hasChangedVote = selectedOptionId != null &&
        selectedOptionId != savedOptionId;
    final canSubmit = selectedOptionId != null &&
        hasChangedVote &&
        !_submittingTripIds.contains(tripId);

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
            poll['trip_name'] as String? ?? 'سفر',
            style: context.textTheme.titleMedium,
            fontWeight: FontWeight.w800,
          ),
          if ((poll['location'] as String?)?.trim().isNotEmpty == true) ...[
            SizedBox(height: 4.h),
            txt(
              poll['location'] as String,
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
          if (options.isEmpty)
            const HsNote(note: 'برای این سفر هنوز بازه‌ای ثبت نشده است.'),
          ...options.map((option) {
            final optionId = (option['id'] as num).toInt();
            final voteCount = (option['vote_count'] as num?)?.toInt() ?? 0;
            final isSelected = selectedOptionId == optionId;
            final percent = totalVotes == 0 ? 0.0 : voteCount / totalVotes;

            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: VoteOptionCard(
                title: _optionTitle(option),
                percent: percent,
                vote: voteCount,
                isVoted: isSelected,
                onVote: (selected) {
                  if (!selected) return;
                  setState(() => _selectedOptionIds[tripId] = optionId);
                },
              ),
            );
          }),
          SizedBox(height: 4.h),
          HsButton(
            width: double.infinity,
            onTap: canSubmit ? () => _submitVote(tripId) : null,
            child: _submittingTripIds.contains(tripId)
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
    return Scaffold(
      body: SafeArea(
        child: _isLoading
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
                onRefresh: () => _loadPolls(showLoading: false),
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
                      SizedBox(height: 8.h),
                      if (_errorMessage != null) ...[
                        HsNote(
                          note: _errorMessage!,
                        ),
                        SizedBox(height: 12.h),
                        HsButton(
                          width: double.infinity,
                          onTap: _loadPolls,
                          child: txt(
                            'تلاش مجدد',
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ] else if (_polls.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 80.h),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.how_to_vote_outlined,
                                  size: 54.sp,
                                  color: context.colorScheme.onSurfaceVariant,
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
                                  color: context.colorScheme.onSurfaceVariant,
                                  size: 12.sp,
                                ),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        HsNote(
                          note: 'برای هر سفر یکی از بازه‌های پیشنهادی را انتخاب کنید. بعد از ثبت رأی هم می‌توانید انتخاب خود را تغییر دهید.',
                        ),
                        SizedBox(height: 16.h),
                        ..._polls.map(_buildPollCard),
                      ],
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
