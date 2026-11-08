import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class VoteOptionCard extends StatelessWidget {
  final String title;
  final int vote;
  final double percent;
  final bool isVoted;
  final ValueChanged<bool> onVote;

  const VoteOptionCard({
    super.key,
    required this.title,
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
              Expanded(
                child: txt(
                  title,
                  style: context.textTheme.titleSmall,
                  color: isVoted
                      ? context.colorScheme.onPrimaryContainer
                      : null,
                ),
              ),
              if (isVoted) ...[
                SizedBox(width: 8.w),
                txt(
                  'رأی شما',
                  style: context.textTheme.labelSmall,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              txt('$vote رأی', style: context.textTheme.bodySmall),
              const Spacer(),
              txt(
                '${(percent * 100).round()}%',
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: percent.clamp(0.0, 1.0),
            color: isVoted ? null : context.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
