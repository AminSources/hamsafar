import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/home/domain/entities/home_activity_entity.dart';
import 'package:hamsafar/features/home/presentation/widgets/home_activity_tile.dart';

class HomeActivities extends StatelessWidget {
  final List<HomeActivityEntity> activities;

  const HomeActivities({super.key, required this.activities});

  String _statusLabel(String? status, {required bool isEnglish}) {
    if (isEnglish) {
      return switch (status) {
        'preparing' => 'Preparing',
        'active' => 'In progress',
        'completed' => 'Completed',
        'cancelled' => 'Cancelled',
        _ => 'Unknown',
      };
    }

    return switch (status) {
      'preparing' => 'در حال آماده‌سازی',
      'active' => 'در حال اجرا',
      'completed' => 'پایان‌یافته',
      'cancelled' => 'لغوشده',
      _ => 'نامشخص',
    };
  }

  String _title(HomeActivityEntity activity, {required bool isEnglish}) {
    final actor = activity.actorName;
    final subject = activity.subjectName ?? (isEnglish ? 'a trip member' : 'عضو سفر');

    if (isEnglish) {
      return switch (activity.activityType) {
        'member_joined' => '$subject joined the trip',
        'member_left' => '$subject left the trip',
        'member_removed' => '$subject was removed from the trip',
        'payment_confirmed' => '$actor confirmed $subject payment',
        'task_completed' =>
          '$actor completed the task "${activity.taskName ?? 'Trip task'}"',
        'trip_status_changed' =>
          '$actor changed the trip status to "${_statusLabel(activity.newStatus, isEnglish: true)}"',
        'membership_closed' => '$actor closed trip registration',
        'membership_opened' => '$actor reopened trip registration',
        _ => 'A new trip activity was recorded',
      };
    }

    return switch (activity.activityType) {
      'member_joined' => '$subject به سفر پیوست',
      'member_left' => '$subject از سفر خارج شد',
      'member_removed' => '$subject از سفر اخراج شد',
      'payment_confirmed' => '$actor پرداخت $subject را تأیید کرد',
      'task_completed' =>
        '$actor وظیفه «${activity.taskName ?? 'وظیفه سفر'}» را انجام داد',
      'trip_status_changed' =>
        '$actor وضعیت سفر را به «${_statusLabel(activity.newStatus, isEnglish: false)}» تغییر داد',
      'membership_closed' => '$actor عضوگیری سفر را بست',
      'membership_opened' => '$actor عضوگیری سفر را باز کرد',
      _ => 'فعالیت جدیدی در سفر ثبت شد',
    };
  }

  IconData _icon(String activityType) {
    return switch (activityType) {
      'member_joined' => Icons.person_add_alt_1_outlined,
      'member_left' => Icons.logout,
      'member_removed' => Icons.person_remove_alt_1_outlined,
      'payment_confirmed' => Icons.verified_outlined,
      'task_completed' => Icons.task_alt,
      'trip_status_changed' => Icons.flight_takeoff_outlined,
      'membership_closed' || 'membership_opened' => Icons.group_outlined,
      _ => Icons.info_outline,
    };
  }

  Color _color(String activityType) {
    return switch (activityType) {
      'member_joined' => AppColors.tertiary,
      'member_left' => AppColors.accent,
      'member_removed' => AppColors.accent,
      'payment_confirmed' => AppColors.success,
      'task_completed' => AppColors.primary,
      'trip_status_changed' => AppColors.accent,
      'membership_closed' || 'membership_opened' => AppColors.tertiary,
      _ => AppColors.primary,
    };
  }

  String _persianDigits(String value) {
    const digits = '۰۱۲۳۴۵۶۷۸۹';
    return value.replaceAllMapped(
      RegExp(r'[0-9]'),
      (match) => digits[int.parse(match.group(0)!)],
    );
  }

  String _timeAgo(DateTime createdAt, {required bool isEnglish}) {
    final difference = DateTime.now().difference(createdAt);
    if (difference.isNegative || difference.inSeconds < 60) {
      return isEnglish ? 'Just now' : 'لحظاتی پیش';
    }
    if (difference.inMinutes < 60) {
      final value = difference.inMinutes.toString();
      if (isEnglish) return '$value ${value == '1' ? 'minute' : 'minutes'} ago';
      return '${_persianDigits(value)} دقیقه پیش';
    }
    if (difference.inHours < 24) {
      final value = difference.inHours.toString();
      if (isEnglish) return '$value ${value == '1' ? 'hour' : 'hours'} ago';
      return '${_persianDigits(value)} ساعت پیش';
    }
    if (difference.inDays < 7) {
      final value = difference.inDays.toString();
      if (isEnglish) return '$value ${value == '1' ? 'day' : 'days'} ago';
      return '${_persianDigits(value)} روز پیش';
    }

    final date = '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    return isEnglish ? date : _persianDigits(date);
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    if (activities.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(
          child: txt(
            'هنوز فعالیتی برای این سفر ثبت نشده است.',
            size: 12.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Column(
      children: [
        for (var index = 0; index < activities.length; index++) ...[
          HomeActivityTile(
            key: ValueKey(activities[index].id),
            title: _title(activities[index], isEnglish: isEnglish),
            time: _timeAgo(activities[index].createdAt, isEnglish: isEnglish),
            icon: _icon(activities[index].activityType),
            color: _color(activities[index].activityType),
          ),
          if (index != activities.length - 1) SizedBox(height: 10.h),
        ],
      ],
    );
  }
}
