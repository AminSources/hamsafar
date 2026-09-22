import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_coordination/enums/payment_member_status.dart';
import 'package:hamsafar/features/trip_coordination/presentation/widgets/budget_summary_card.dart';
import 'package:hamsafar/features/trip_coordination/presentation/widgets/payment_member_tile.dart';

class TripBudgetPage extends StatelessWidget {
  const TripBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              const HsAppBar(
                title: 'پرداخت و بودجه',
                hasBack: true,
                leading: HsBadge(label: '۲ در انتظار'),
              ),
              SizedBox(height: 16.h),

              //* budget summary card
              BudgetSummaryCard(),
              SizedBox(height: 16.h),

              //* description
              HsNote(
                note:
                    'پرداخت سهم به لیدر به‌صورت نقدی یا کارت‌به‌کارت انجام می‌شود و پس از تأیید لیدر، وضعیت شما «پرداخت شده» می‌شود.',
              ),
              SizedBox(height: 16.h),

              //* pay button
              HsButton(child: txt('پرداخت سهم')),

              SizedBox(height: 24.h),

              //* payment status header
              HsHeader(title: 'وضعیت پرداخت‌ها', actionLabel: '۴ از ۶ نفر'),
              SizedBox(height: 16.h),

              //* members list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
                  child: PaymentMemberTile(
                    name: [
                      "سارا محمدی",
                      "مهدی رضایی",
                      'نگار احمدی',
                      'علی کریمی',
                    ][index],
                    paymentStatus: [
                      PaymentMemberStatus.paid,
                      PaymentMemberStatus.paid,
                      PaymentMemberStatus.pending,
                      PaymentMemberStatus.notPaid,
                    ][index],
                    share: 450000,
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
