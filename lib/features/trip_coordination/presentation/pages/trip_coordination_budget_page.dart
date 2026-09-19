import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TripCoordinationBudgetPage extends StatelessWidget {
  const TripCoordinationBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: const HsAppBar(title: 'پرداخت و بودجه', hasBack: true),
              ),

              //* pending badge
              HsContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                radius: 999.r,
                color: context.colorScheme.errorContainer,
                child: txt(
                  '۲ در انتظار',
                  size: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onErrorContainer,
                ),
              ),

              SizedBox(height: 16.h),

              //* budget summary card
              HsContainer(
                padding: EdgeInsets.all(20.w),
                radius: 20.r,
                color: context.colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* total budget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          'بودجه کل سفر',
                          size: 12.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        txt(
                          '۲,۷۰۰,۰۰۰ تومان',
                          size: 12.5.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    //* share per person
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          'سهم هر نفر',
                          size: 12.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        txt(
                          '۴۵۰,۰۰۰ ت',
                          size: 12.5.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    //* divider
                    Divider(
                      color: context.colorScheme.outlineVariant,
                      height: 1,
                    ),

                    SizedBox(height: 12.h),

                    //* received amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          'دریافت‌شده',
                          size: 12.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16.sp,
                              color: context.colorScheme.primary,
                            ),
                            SizedBox(width: 4.w),
                            txt(
                              '۱,۸۰۰,۰۰۰ ت',
                              size: 12.5.sp,
                              fontWeight: FontWeight.w700,
                              color: context.colorScheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    //* remaining amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          'باقی‌مانده',
                          size: 12.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pending_actions_rounded,
                              size: 16.sp,
                              color: context.colorScheme.error,
                            ),
                            SizedBox(width: 4.w),
                            txt(
                              '۹۰۰,۰۰۰ ت',
                              size: 12.5.sp,
                              fontWeight: FontWeight.w700,
                              color: context.colorScheme.error,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              //* description
              txt(
                'پرداخت سهم به لیدر به‌صورت نقدی یا کارت‌به‌کارت انجام می‌شود و پس از تأیید لیدر، وضعیت شما «پرداخت شده» می‌شود.',
                size: 11.5.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurfaceVariant,
                textAlign: TextAlign.right,
              ),

              SizedBox(height: 20.h),

              //* pay button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: txt(
                    'پرداخت سهم',
                    size: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              //* payment status header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  txt(
                    'وضعیت پرداخت‌ها',
                    size: 15.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: txt(
                      '۴ از ۶ نفر',
                      size: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              //* member 1 - leader (settled)
              _PaymentMemberTile(
                name: 'سارا محمدی',
                username: '@sara_travel',
                status: 'تسویه',
                statusColor: context.colorScheme.primary,
                statusBgColor: context.colorScheme.primaryContainer,
                isLeader: true,
              ),

              SizedBox(height: 8.h),

              //* member 2 - paid
              _PaymentMemberTile(
                name: 'مهدی رضایی',
                amount: '۴۵۰,۰۰۰ تومان',
                status: 'پرداخت شده',
                statusColor: context.colorScheme.primary,
                statusBgColor: AppColors.successContainer,
                statusIcon: Icons.check_circle_rounded,
              ),

              SizedBox(height: 8.h),

              //* member 3 - paid
              _PaymentMemberTile(
                name: 'نگار احمدی',
                amount: '۴۵۰,۰۰۰ تومان',
                status: 'پرداخت شده',
                statusColor: context.colorScheme.primary,
                statusBgColor: AppColors.successContainer,
                statusIcon: Icons.check_circle_rounded,
              ),

              SizedBox(height: 8.h),

              //* member 4 - pending confirmation
              _PaymentMemberTile(
                name: 'علی کریمی',
                amount: '۴۵۰,۰۰۰ تومان',
                status: 'در انتظار تأیید',
                statusColor: context.colorScheme.secondary,
                statusBgColor: context.colorScheme.secondaryContainer,
                statusIcon: Icons.pending_rounded,
              ),

              SizedBox(height: 8.h),

              //* member 5 - unpaid
              _PaymentMemberTile(
                name: 'رضا قاسمی',
                amount: '۴۵۰,۰۰۰ تومان',
                status: 'پرداخت نشده',
                statusColor: context.colorScheme.error,
                statusBgColor: context.colorScheme.errorContainer,
                statusIcon: Icons.cancel_rounded,
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

//* Payment Member Tile Widget
class _PaymentMemberTile extends StatelessWidget {
  final String name;
  final String? username;
  final String? amount;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final IconData? statusIcon;
  final bool isLeader;

  const _PaymentMemberTile({
    required this.name,
    this.username,
    this.amount,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    this.statusIcon,
    this.isLeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      padding: EdgeInsets.all(12.w),
      radius: 14.r,
      color: context.colorScheme.surface,
      child: Row(
        children: [
          //* avatar
          CircleAvatar(
            radius: 20.r,
            backgroundColor:
                AppColors.avatars[name.hashCode % AppColors.avatars.length],
            child: txt(
              name[0],
              size: 14.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          SizedBox(width: 12.w),

          //* name and details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    txt(name, size: 12.5.sp, fontWeight: FontWeight.w700),
                    if (isLeader) ...[
                      SizedBox(width: 6.w),
                      HsContainer(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        radius: 4.r,
                        color: context.colorScheme.primaryContainer,
                        child: txt(
                          'لیدر',
                          size: 9.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
                if (username != null) ...[
                  txt(
                    username!,
                    size: 10.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ] else if (amount != null) ...[
                  SizedBox(height: 2.h),
                  txt(
                    amount!,
                    size: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ],
            ),
          ),

          //* status badge
          HsContainer(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            radius: 8.r,
            color: statusBgColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (statusIcon != null) ...[
                  Icon(statusIcon, size: 14.sp, color: statusColor),
                  SizedBox(width: 4.w),
                ],
                txt(
                  status,
                  size: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: statusColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
