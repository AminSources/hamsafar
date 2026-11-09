import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hamsafar/core/localization/app_translations.dart';
class TripExpenseSetupPage extends StatefulWidget {
  const TripExpenseSetupPage({super.key});

  @override
  State<TripExpenseSetupPage> createState() => _TripExpenseSetupPageState();
}

class _TripExpenseSetupPageState extends State<TripExpenseSetupPage> {
  final TextEditingController _costItemController = TextEditingController();

  @override
  void dispose() {
    _costItemController.dispose();
    super.dispose();
  }

  void _addItem() {
    context.read<TripDraftCubit>().addCostItem(_costItemController.text);
    _costItemController.clear();
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
              txt(
                'هزینه تخمینی کل (تومان)',
                size: 12.sp,
                fontWeight: FontWeight.w700,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: 8.h),
              TextFormField(
                key: const ValueKey('trip-budget'),
                initialValue: draft.budget == 0 ? '' : draft.budget.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final normalized = value
                      .replaceAll(',', '')
                      .replaceAll('٬', '')
                      .replaceAll('۰', '0')
                      .replaceAll('۱', '1')
                      .replaceAll('۲', '2')
                      .replaceAll('۳', '3')
                      .replaceAll('۴', '4')
                      .replaceAll('۵', '5')
                      .replaceAll('۶', '6')
                      .replaceAll('۷', '7')
                      .replaceAll('۸', '8')
                      .replaceAll('۹', '9');
                  cubit.setBudget(int.tryParse(normalized) ?? 0);
                },
                decoration: InputDecoration(
                  hintText: AppTranslations.translate(context, 'مثلاً ۲۷۰۰۰۰۰'),
                  prefixIcon: Icon(Icons.money_rounded),
                ),
              ),
              SizedBox(height: 16.h),
              const HsNote(
                note:
                    'هزینه تخمینی پس از مشخص شدن تعداد اعضا قابل تقسیم خواهد بود.',
              ),
              SizedBox(height: 20.h),
              txt('اطلاعات کارت برای دریافت سهم', size: 13.sp, fontWeight: FontWeight.w800, color: context.colorScheme.onSurface),
              SizedBox(height: 8.h),
              TextFormField(
                key: const ValueKey('trip-bank-card'),
                initialValue: draft.bankCardNumber,
                keyboardType: TextInputType.number,
                onChanged: cubit.setBankCardNumber,
                decoration: InputDecoration(labelText: AppTranslations.translate(context, 'شماره کارت'), hintText: AppTranslations.translate(context, 'شماره کارت ۱۶ رقمی')),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                key: const ValueKey('trip-bank-account'),
                initialValue: draft.bankAccountName,
                onChanged: cubit.setBankAccountName,
                decoration: InputDecoration(labelText: AppTranslations.translate(context, 'نام صاحب حساب'), hintText: AppTranslations.translate(context, 'نام و نام خانوادگی')),
              ),
              SizedBox(height: 16.h),
              const HsNote(note: 'اعضای سفر برای کارت‌به‌کارت از این اطلاعات استفاده می‌کنند. پرداخت نقدی به لیدر هم امکان‌پذیر است.'),
              SizedBox(height: 20.h),
              txt(
                'آیتم‌های هزینه',
                size: 13.sp,
                fontWeight: FontWeight.w800,
                color: context.colorScheme.onSurface,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _costItemController,
                      onSubmitted: (_) => _addItem(),
                      decoration: InputDecoration(
                        hintText: AppTranslations.translate(context, 'مثلاً اقامت، سوخت، خوراک'),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  IconButton.filled(
                    onPressed: _addItem,
                    icon: const Icon(LucideIcons.plus),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: draft.costItems.map((item) {
                  return InputChip(
                    label: txt(item),
                    onDeleted: () => cubit.removeCostItem(item),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
            ],
          );
        },
      ),
    );
  }
}
