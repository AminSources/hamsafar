import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/localization/app_translations.dart';
import 'package:hamsafar/features/trip_coordination/domain/entities/trip_coordination_entities.dart';
import 'package:hamsafar/features/trip_coordination/enums/payment_member_status.dart';
import 'package:hamsafar/features/trip_coordination/presentation/bloc/trip_budget_bloc.dart';

class TripBudgetPage extends StatelessWidget {
  const TripBudgetPage({super.key});

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<TripBudgetBloc>();
    if (bloc.state.isBusy || bloc.state.isLoading) return;
    bloc.add(const TripBudgetLoadRequested());
    await bloc.stream.firstWhere((state) => !state.isLoading);
  }

  String _money(num? value) => ((value ?? 0).toInt())
      .toString()
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '٬');

  Widget _copyRow(BuildContext context, String label, String value) =>
      Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  txt(label, style: Theme.of(context).textTheme.bodySmall),
                  SelectableText(
                    AppTranslations.translate(
                      context,
                      value.isEmpty ? 'ثبت نشده' : value,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: value.isEmpty
                  ? null
                  : () => Clipboard.setData(ClipboardData(text: value)),
              icon: const Icon(Icons.copy),
            ),
          ],
        ),
      );

  Future<void> _openPaymentSheet(
    BuildContext context,
    TripBudgetEntity data,
  ) async {
    final result = await showModalBottomSheet<_PaymentSubmission>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _TripPaymentSheet(
        data: data,
        moneyFormatter: _money,
        copyRowBuilder: _copyRow,
      ),
    );

    if (!context.mounted || result == null) return;
    context.read<TripBudgetBloc>().add(
      TripPaymentSubmissionRequested(
        method: result.method,
        reference: result.reference,
      ),
    );
  }

  Widget _memberTile(
    BuildContext context,
    TripBudgetMemberEntity member, {
    required bool leader,
    required bool isBusy,
  }) {
    final status = PaymentMemberStatus.fromValue(member.paymentStatus);
    final canConfirm = leader &&
        member.memberType != 'leader' &&
        member.paymentStatus == 'under_review';

    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  txt(
                    member.displayName,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  txt('${_money(member.share)} تومان'),
                  txt(
                    status.label,
                    style: TextStyle(
                      color: status == PaymentMemberStatus.paid
                          ? Colors.green
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 12.sp,
                    ),
                  ),
                  if (member.paymentMethod == 'bank_transfer' &&
                      (member.paymentReference ?? '').isNotEmpty)
                    txt('شماره پیگیری: ${member.paymentReference}'),
                  if (member.paymentMethod == 'cash')
                    const txt('پرداخت نقدی'),
                ],
              ),
            ),
            if (canConfirm)
              TextButton(
                onPressed: isBusy
                    ? null
                    : () => context.read<TripBudgetBloc>().add(
                          TripPaymentConfirmationRequested(member.userId),
                        ),
                child: const txt('تأیید پرداخت'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripBudgetBloc, TripBudgetState>(
      listener: (context, state) {
        final feedback = state.feedback;
        if (feedback == null) return;
        context.showHsSnackBar(
          text: feedback,
          hsSnackBarType: state.feedbackIsSuccess == true
              ? HsSnackBarType.success
              : HsSnackBarType.error,
        );
      },
      builder: (context, state) {
        final data = state.data;
        final leader = data?.isLeader == true;
        final members = data?.members ?? const <TripBudgetMemberEntity>[];
        final myStatus = PaymentMemberStatus.fromValue(data?.myPaymentStatus);

        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
                children: [
                  const HsAppBar(title: 'پرداخت و بودجه', hasBack: true),
                  SizedBox(height: 18.h),
                  if (state.isLoading && data == null)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (data == null)
                    Column(
                      children: [
                        HsNote(
                          note: state.errorMessage ??
                              'در حال حاضر سفر فعالی برای نمایش بودجه وجود ندارد.',
                        ),
                        if (state.errorMessage != null) ...[
                          SizedBox(height: 12.h),
                          FilledButton(
                            onPressed: () => context
                                .read<TripBudgetBloc>()
                                .add(const TripBudgetLoadRequested()),
                            child: const txt('تلاش مجدد'),
                          ),
                        ],
                      ],
                    )
                  else ...[
                    if (state.errorMessage != null)
                      HsNote(note: state.errorMessage!),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            txt(
                              data.tripName.isEmpty ? 'سفر' : data.tripName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8.h),
                            txt('بودجه کل: ${_money(data.totalBudget)} تومان'),
                            txt('تعداد اعضا: ${members.length} نفر'),
                            const Divider(),
                            txt(
                              'سهم شما: ${_money(data.myShare)} تومان',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            if (!leader)
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: txt(
                                  'وضعیت شما: ${myStatus.label}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    if (!leader && myStatus != PaymentMemberStatus.paid) ...[
                      if (myStatus == PaymentMemberStatus.underReview)
                        const HsNote(
                          note: 'پرداخت شما ثبت شده و در انتظار تأیید لیدر است.',
                        )
                      else
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: state.isBusy
                                ? null
                                : () => _openPaymentSheet(context, data),
                            child: state.isBusy
                                ? const CircularProgressIndicator()
                                : const txt('پرداخت سهم'),
                          ),
                        ),
                    ],
                    if (leader)
                      const HsNote(
                        note:
                            'پرداخت‌های ثبت‌شده اعضا را بررسی و پس از دریافت وجه تأیید کنید.',
                      ),
                    SizedBox(height: 20.h),
                    txt(
                      'وضعیت پرداخت اعضا',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    SizedBox(height: 10.h),
                    ...members.map(
                      (member) => _memberTile(
                        context,
                        member,
                        leader: leader,
                        isBusy: state.isBusy,
                      ),
                    ),
                    if (state.isBusy)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: LinearProgressIndicator(),
                      ),
                  ],
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PaymentSubmission {
  const _PaymentSubmission({
    required this.method,
    required this.reference,
  });

  final String method;
  final String? reference;
}

class _TripPaymentSheet extends StatefulWidget {
  const _TripPaymentSheet({
    required this.data,
    required this.moneyFormatter,
    required this.copyRowBuilder,
  });

  final TripBudgetEntity data;
  final String Function(num? value) moneyFormatter;
  final Widget Function(BuildContext, String, String) copyRowBuilder;

  @override
  State<_TripPaymentSheet> createState() => _TripPaymentSheetState();
}

class _TripPaymentSheetState extends State<_TripPaymentSheet> {
  late final TextEditingController _referenceController;
  String _method = 'bank_transfer';
  String? _referenceError;

  @override
  void initState() {
    super.initState();
    _referenceController = TextEditingController();
  }

  @override
  void dispose() {
    _referenceController.dispose();
    super.dispose();
  }

  void _submit() {
    final reference = _referenceController.text.trim();
    if (_method == 'bank_transfer' && reference.isEmpty) {
      setState(() => _referenceError = 'شماره پیگیری را وارد کنید.');
      return;
    }

    Navigator.of(context).pop(
      _PaymentSubmission(
        method: _method,
        reference: _method == 'bank_transfer' ? reference : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              txt(
                'پرداخت سهم سفر',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.h),
              txt(
                'مبلغ سهم شما: ${widget.moneyFormatter(data.myShare)} تومان',
              ),
              SizedBox(height: 16.h),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'bank_transfer',
                    label: txt('کارت‌به‌کارت'),
                    icon: Icon(Icons.credit_card),
                  ),
                  ButtonSegment(
                    value: 'cash',
                    label: txt('نقدی به لیدر'),
                    icon: Icon(Icons.payments_outlined),
                  ),
                ],
                selected: {_method},
                onSelectionChanged: (values) {
                  setState(() {
                    _method = values.first;
                    _referenceError = null;
                  });
                },
              ),
              if (_method == 'bank_transfer') ...[
                SizedBox(height: 16.h),
                widget.copyRowBuilder(
                  context,
                  'شماره کارت',
                  data.bankCardNumber ?? '',
                ),
                widget.copyRowBuilder(
                  context,
                  'نام صاحب حساب',
                  data.bankAccountName ?? '',
                ),
                TextField(
                  controller: _referenceController,
                  onChanged: (_) {
                    if (_referenceError != null) {
                      setState(() => _referenceError = null);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: AppTranslations.translate(context, 'شماره پیگیری تراکنش'),
                    hintText: AppTranslations.translate(context, 'شماره پیگیری را وارد کنید'),
                    errorText: _referenceError,
                  ),
                ),
              ] else
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: HsNote(
                    note:
                        'سهم خود را نقداً به لیدر تحویل دهید. پس از ثبت، پرداخت برای تأیید لیدر ارسال می‌شود.',
                  ),
                ),
              SizedBox(height: 18.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submit,
                  child: const txt('ثبت پرداخت برای بررسی'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
