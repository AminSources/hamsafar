import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_button_enums.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_enums.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips_feature/presentation/widgets/td_members.dart';
import 'package:hamsafar/features/trips_feature/presentation/widgets/td_rules.dart';
import 'package:hamsafar/features/trips_feature/presentation/widgets/td_trip_card.dart';
import 'package:hamsafar/core/widgets/hs_snack_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TripDetailsPage extends StatelessWidget {
  final bool? isJoined;

  const TripDetailsPage({super.key, this.isJoined = true});

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
                child: HsAppBar(
                  title: 'جزئیات سفر',
                  hasBack: true,
                  leading: HsContainer(
                    width: 40.w,
                    height: 40.w,
                    child: Icon(
                      isJoined! ? Icons.settings_outlined : Icons.flag_outlined,
                    ),
                  ),
                ),
              ),

              //* TD trip card
              TdTripCard(),
              SizedBox(height: 24.h),

              //* TD members list
              TdMembers(),
              SizedBox(height: 14.h),

              //* TD rules list
              TdRules(
                rules: [
                  'حضور به‌موقع در محل تجمع (۱۵ دقیقه قبل از حرکت)',
                  'لغو برنامه کمتر از ۴۸ ساعت قبل از سفر ممنوع است',
                  'تقسیم مساوی هزینه‌ها و احترام به طبیعت 🌱',
                ],
              ),
              SizedBox(height: 24.h),

              //* TD exit trip button
              HsButton(
                hsButtonMode: isJoined!
                    ? HsButtonMode.outline
                    : HsButtonMode.filled,
                borderColor: context.colorScheme.error,
                onTap: () {
                  //? exit/join trip and close the page
                  context.pop();

                  //? show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    HsSnackBar(
                      text: isJoined!
                          ? "شما سفر را ترک کردید"
                          : "درخواست عضویت شما ارسال شد",
                      mode: isJoined!
                          ? HsSnackBarMode.error
                          : HsSnackBarMode.success,
                      icon: isJoined!
                          ? LucideIcons.userRoundMinus
                          : LucideIcons.userRoundPlus,
                    ).toSnackBar(context),
                  );
                },
                child: txt(
                  isJoined! ? 'ترک سفر' : "درخواست عضویت",
                  color: isJoined! ? context.colorScheme.error : Colors.white,
                  fontWeight: FontWeight.w800,
                  size: 14.sp,
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
