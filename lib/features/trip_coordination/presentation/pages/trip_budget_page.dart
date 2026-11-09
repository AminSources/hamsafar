import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trip_coordination/enums/payment_member_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/localization/app_translations.dart';
class TripBudgetPage extends StatefulWidget {
  const TripBudgetPage({super.key});

  @override
  State<TripBudgetPage> createState() => _TripBudgetPageState();
}

class _TripBudgetPageState extends State<TripBudgetPage> {
  final _client = Supabase.instance.client;
  Map<String, dynamic>? _budget;
  bool _loading = true, _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (mounted) setState(() => _loading = true);
    try {
      final rows = await _client.rpc('get_my_trip_budget');
      if (!mounted) return;
      setState(
        () => _budget = (rows as List).isEmpty
            ? null
            : Map<String, dynamic>.from(rows.first as Map),
      );
    } catch (_) {
      if (mounted) _message('دریافت اطلاعات بودجه انجام نشد.', false);
    }
    if (mounted) setState(() => _loading = false);
  }

  void _message(String text, bool success) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: txt(text),
          backgroundColor: success ? Colors.green : null,
        ),
      );

  String _money(dynamic value) => ((value as num?)?.toInt() ?? 0)
      .toString()
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '٬');

  String _name(Map<String, dynamic> m) {
    final n = '${m['first_name'] ?? ''} ${m['last_name'] ?? ''}';
    return n.trim().isEmpty ? 'عضو سفر' : n.trim();
  }

  Widget _copyRow(BuildContext context, String label, String value) => Padding(
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

  Future<void> _openPaymentSheet() async {
    final data = _budget;
    if (data == null || !mounted) return;

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

    if (!mounted || result == null) return;
    await _submitPayment(result.method, result.reference);
  }

  Future<void> _submitPayment(String method, String? reference) async {
    if (!mounted) return;
    setState(() => _busy = true);
    try {
      await _client.rpc(
        'submit_trip_payment',
        params: {
          'p_trip_id': _budget!['trip_id'],
          'p_method': method,
          'p_reference': reference,
        },
      );
      await _load();
      if (mounted) {
        _message('پرداخت ثبت شد و در انتظار تأیید لیدر است.', true);
      }
    } catch (_) {
      if (mounted) {
        _message('ثبت پرداخت انجام نشد. دوباره تلاش کنید.', false);
      }
    }
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _confirm(String userId) async {
    if (!mounted) return;
    setState(() => _busy = true);
    try {
      await _client.rpc(
        'confirm_trip_payment',
        params: {'p_trip_id': _budget!['trip_id'], 'p_user_id': userId},
      );
      await _load();
      if (mounted) _message('پرداخت عضو تأیید شد.', true);
    } catch (_) {
      if (mounted) _message('تأیید پرداخت انجام نشد.', false);
    }
    if (mounted) setState(() => _busy = false);
  }

  Widget _memberTile(Map<String, dynamic> member, bool leader) {
    final status = PaymentMemberStatus.fromValue(
      member['pay_status'] as String?,
    );
    final canConfirm = leader &&
        member['member_type'] != 'leader' &&
        member['pay_status'] == 'under_review';
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
                    _name(member),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  txt('${_money(member['share'])} تومان'),
                  txt(
                    status.label,
                    style: TextStyle(
                      color: status == PaymentMemberStatus.paid
                          ? Colors.green
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 12.sp,
                    ),
                  ),
                  if (member['payment_method'] == 'bank_transfer' &&
                      (member['payment_reference'] ?? '')
                          .toString()
                          .isNotEmpty)
                    txt('شماره پیگیری: ${member['payment_reference']}'),
                  if (member['payment_method'] == 'cash')
                    const txt('پرداخت نقدی'),
                ],
              ),
            ),
            if (canConfirm)
              TextButton(
                onPressed: _busy
                    ? null
                    : () => _confirm(member['user_id'] as String),
                child: const txt('تأیید پرداخت'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = _budget;
    final leader = data?['is_leader'] == true;
    final members = (data?['members'] as List? ?? const [])
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    final myStatus = PaymentMemberStatus.fromValue(
      data?['my_pay_status'] as String?,
    );

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            children: [
              const HsAppBar(title: 'پرداخت و بودجه', hasBack: true),
              SizedBox(height: 18.h),
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (data == null)
                const HsNote(
                  note: 'در حال حاضر سفر فعالی برای نمایش بودجه وجود ندارد.',
                )
              else ...[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        txt(
                          data['trip_name'] as String? ?? 'سفر',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8.h),
                        txt(
                          'بودجه کل: ${_money(data['total_budget'])} تومان',
                        ),
                        txt('تعداد اعضا: ${members.length} نفر'),
                        const Divider(),
                        txt(
                          'سهم شما: ${_money(data['my_share'])} تومان',
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
                        onPressed: _busy ? null : _openPaymentSheet,
                        child: _busy
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
                ...members.map((m) => _memberTile(m, leader)),
              ],
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
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

  final Map<String, dynamic> data;
  final String Function(dynamic value) moneyFormatter;
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
                'مبلغ سهم شما: ${widget.moneyFormatter(data['my_share'])} تومان',
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
                  (data['bank_card_number'] ?? '').toString(),
                ),
                widget.copyRowBuilder(
                  context,
                  'نام صاحب حساب',
                  (data['bank_account_name'] ?? '').toString(),
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
