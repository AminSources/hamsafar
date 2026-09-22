import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trip_coordination/presentation/widgets/vote_option_card.dart';

class TripVotePage extends StatelessWidget {
  const TripVotePage({super.key});

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
                child: const HsAppBar(
                  title: 'رای‌گیری سفر فعال',
                  hasBack: true,
                ),
              ),

              SizedBox(height: 16.h),

              //* question title
              txt('زمان حرکت کی باشد؟', style: context.textTheme.titleLarge),

              SizedBox(height: 8.h),

              //* voting status info
              txt(
                'رای‌گیری پس از بسته شدن عضوگیری شروع شد · ۵ ساعت تا پایان',
                style: context.textTheme.bodySmall,
                color: context.colorScheme.onSurfaceVariant,
              ),

              SizedBox(height: 24.h),

              //* option 1 - 07:00 (selected with 67%)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
                  child: VoteOptionCard(
                    title: ['۰۸:۳۰ صبح', '۰۹:۰۰ صبح', '۱۰:۰۰ صبح'][index],
                    percent: [0.67, 0.17, 0.16][index],
                    memberCount: 6,
                    vote: [4, 1, 1][index],
                    isVoted: [true, false, false][index],
                    onVote: (value) {},
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              //* submit vote button
              HsButton(
                width: double.infinity,
                onTap: () {
                  //? show submit vote snack bar
                  context.showHsSnackBar(text: "رای با موفقیت ثبت شد");

                  //? close page
                  context.pop();
                },
                child: txt('ثبت رای برای «۰۷:۰۰»'),
              ),

              SizedBox(height: 16.h),

              //* info note
              HsNote(
                note:
                    'زمان سفر با بیشترین رای تعیین و به همه اعضا اعلام می‌شود',
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
