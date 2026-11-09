import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';

import 'package:hamsafar/core/localization/app_translations.dart';
class TripRulesSetupPage extends StatefulWidget {
  const TripRulesSetupPage({super.key});

  @override
  State<TripRulesSetupPage> createState() => _TripRulesSetupPageState();
}

class _TripRulesSetupPageState extends State<TripRulesSetupPage> {
  final TextEditingController _ruleController = TextEditingController();

  @override
  void dispose() {
    _ruleController.dispose();
    super.dispose();
  }

  void _addRule() {
    context.read<TripDraftCubit>().addRule(_ruleController.text);
    _ruleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<TripDraftCubit, TripDraft>(
        builder: (context, draft) {
          final cubit = context.read<TripDraftCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ruleController,
                      onSubmitted: (_) => _addRule(),
                      decoration: InputDecoration(
                        hintText: AppTranslations.translate(context, 'قانون جدید را بنویسید...'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SizedBox(
                    height: 50.h,
                    child: HsButton(
                      onTap: _addRule,
                      child: const Icon(Icons.add_rounded),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              txt(
                'قوانین تعیین‌شده (${draft.rules.length})',
                size: 13.sp,
                fontWeight: FontWeight.w800,
                color: context.colorScheme.onSurface,
              ),
              SizedBox(height: 12.h),
              if (draft.rules.isEmpty)
                txt(
                  'هنوز قانونی اضافه نشده است.',
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ...draft.rules.map(
                (rule) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.rule_outlined),
                    title: txt(rule),
                    trailing: IconButton(
                      tooltip: AppTranslations.translate(context, 'حذف قانون'),
                      onPressed: () => cubit.removeRule(rule),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const HsNote(
                note:
                    'قوانین برای همه اعضای سفر نمایش داده می‌شوند و پس از عضویت قابل مشاهده هستند.',
              ),
              SizedBox(height: 24.h),
            ],
          );
        },
      ),
    );
  }
}
