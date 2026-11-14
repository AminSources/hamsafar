import 'package:shamsi_date/shamsi_date.dart';

extension DateExtension on DateTime {
  String toJalaliString() {
    final jalaliDate = Jalali.fromDateTime(this);

    final day = jalaliDate.day.toString().padLeft(2, '0');
    final month = jalaliDate.month.toString().padLeft(2, '0');
    final year = jalaliDate.year.toString();

    return '$year/$month/$day';
  }
}
