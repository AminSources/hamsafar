import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class VoteOptionCard extends StatelessWidget {
  final String title;
  final int memberCount;
  final int vote;
  final double percent;
  final bool isVoted;
  final ValueChanged<bool> onVote;

  const VoteOptionCard({
    super.key,
    required this.title,
    required this.memberCount,
    required this.vote,
    required this.percent,
    required this.isVoted,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      radius: 16.r,
      color: isVoted
          ? context.colorScheme.primaryContainer
          : context.colorScheme.surfaceContainer,
      borderColor: isVoted ? context.colorScheme.primary : null,
      padding: EdgeInsets.all(16.w),
      onTap: () => onVote(!isVoted),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* option time and icon
          Row(
            children: [
              Icon(
                Icons.wb_twilight,
                size: 20.sp,
                color: isVoted
                    ? context.colorScheme.onPrimaryContainer
                    : context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 8.w),
              txt(
                title,
                style: context.textTheme.titleMedium,
                color: isVoted ? context.colorScheme.onPrimaryContainer : null,
              ),
              const Spacer(),
              //* selected badge
              txt('رای شما', style: context.textTheme.labelSmall),
            ],
          ),

          SizedBox(height: 12.h),

          //* vote count and percentage
          Row(
            children: [
              txt(
                '$vote رای از $memberCount عضو',
                style: context.textTheme.bodySmall,
              ),
              const Spacer(),
              txt(
                '${(percent * 100).round()}%',
                style: context.textTheme.labelMedium,
              ),
            ],
          ),

          SizedBox(height: 8.h),

          //* progress bar
          LinearProgressIndicator(
            value: percent,
            color: isVoted ? null : context.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
