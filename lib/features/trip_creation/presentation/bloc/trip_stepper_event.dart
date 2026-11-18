import 'package:equatable/equatable.dart';

sealed class TripStepperEvent extends Equatable {
  const TripStepperEvent();

  @override
  List<Object?> get props => [];
}

final class TripStepperNextRequested extends TripStepperEvent {
  const TripStepperNextRequested();
}

final class TripStepperPreviousRequested extends TripStepperEvent {
  const TripStepperPreviousRequested();
}

final class TripStepperResetRequested extends TripStepperEvent {
  const TripStepperResetRequested();
}
