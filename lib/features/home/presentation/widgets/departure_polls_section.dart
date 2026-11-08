import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeparturePollsSection extends StatefulWidget {
  const DeparturePollsSection({super.key});

  @override
  State<DeparturePollsSection> createState() => _DeparturePollsSectionState();
}

class _DeparturePollsSectionState extends State<DeparturePollsSection> {
  final _client = Supabase.instance.client;
  List<Map<String, dynamic>> _polls = [];
  bool _loading = true;
  final Set<int> _submitting = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final result = await _client.rpc('get_my_departure_polls');
      if (!mounted) return;
      setState(() {
        _polls = List<Map<String, dynamic>>.from(result as List);
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _format(DateTime value) =>
      '${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}  ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  Future<void> _vote(int tripId, int optionId) async {
    if (_submitting.contains(tripId)) return;
    setState(() => _submitting.add(tripId));
    try {
      await _client.rpc('cast_departure_vote', params: {
        'p_trip_id': tripId,
        'p_option_id': optionId,
      });
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('رأی شما ثبت شد.')));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ثبت رأی انجام نشد؛ دوباره تلاش کنید.')));
      }
    } finally {
      if (mounted) setState(() => _submitting.remove(tripId));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Padding(padding: EdgeInsets.all(12), child: Center(child: CircularProgressIndicator()));
    if (_polls.isEmpty) return const SizedBox.shrink();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      txt('رأی‌گیری زمان حرکت', style: context.textTheme.titleMedium, fontWeight: FontWeight.w800),
      SizedBox(height: 10.h),
      ..._polls.map((poll) {
        final tripId = (poll['trip_id'] as num).toInt();
        final options = List<Map<String, dynamic>>.from(poll['options'] as List? ?? const []);
        final myOption = (poll['my_option_id'] as num?)?.toInt();
        final totalVotes = options.fold<int>(0, (sum, option) => sum + ((option['vote_count'] as num?)?.toInt() ?? 0));
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: HsContainer(
            padding: EdgeInsets.all(14.w),
            radius: 16.r,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              txt(poll['trip_name'] as String? ?? 'سفر', fontWeight: FontWeight.w800, size: 14.sp),
              if ((poll['location'] as String?)?.isNotEmpty == true)
                Padding(padding: EdgeInsets.only(top: 3.h), child: txt(poll['location'] as String, size: 11.sp, color: context.colorScheme.onSurfaceVariant)),
              SizedBox(height: 12.h),
              ...options.map((option) {
                final id = (option['id'] as num).toInt();
                final count = (option['vote_count'] as num?)?.toInt() ?? 0;
                final selected = myOption == id;
                final start = DateTime.parse(option['starts_at'] as String).toLocal();
                final end = DateTime.parse(option['ends_at'] as String).toLocal();
                final percent = totalVotes == 0 ? 0.0 : count / totalVotes;
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: InkWell(
                    onTap: _submitting.contains(tripId) ? null : () => _vote(tripId, id),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.all(11.w),
                      decoration: BoxDecoration(
                        color: selected ? context.colorScheme.primaryContainer : context.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: selected ? context.colorScheme.primary : context.colorScheme.outlineVariant),
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Expanded(child: txt('${_format(start)} تا ${_format(end)}', size: 11.sp, fontWeight: FontWeight.w700)),
                          if (selected) Icon(Icons.check_circle, size: 17.sp, color: context.colorScheme.primary),
                        ]),
                        SizedBox(height: 7.h),
                        Row(children: [
                          Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(5.r), child: LinearProgressIndicator(value: percent, minHeight: 6.h))),
                          SizedBox(width: 8.w),
                          txt('$count رأی', size: 10.sp),
                        ]),
                      ]),
                    ),
                  ),
                );
              }),
              Row(children: [
                Expanded(child: txt(myOption == null ? 'برای ثبت رأی، یک بازه را انتخاب کنید.' : 'برای تغییر رأی، بازهٔ دیگری را انتخاب کنید.', size: 10.sp, color: context.colorScheme.onSurfaceVariant)),
                if (_submitting.contains(tripId)) SizedBox(width: 16.w, height: 16.w, child: const CircularProgressIndicator(strokeWidth: 2)),
              ]),
            ]),
          ),
        );
      }),
    ]);
  }
}
