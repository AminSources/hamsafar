import 'package:equatable/equatable.dart';

class SaveAvailabilityParams extends Equatable {
  final List<String> days;
  final String timeFrom;
  final String timeTo;

  const SaveAvailabilityParams({
    required this.days,
    required this.timeFrom,
    required this.timeTo,
  });

  @override
  List<Object?> get props => [days, timeFrom, timeTo];
}
