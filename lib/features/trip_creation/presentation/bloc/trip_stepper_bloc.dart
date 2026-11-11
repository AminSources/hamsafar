import 'package:bloc/bloc.dart';
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

class TripStepperBloc extends Bloc<TripStepperEvent, int> {
  TripStepperBloc() : super(0) {
    on<TripStepperNextRequested>((event, emit) {
      if (state < 4) emit(state + 1);
    });
    on<TripStepperPreviousRequested>((event, emit) {
      if (state > 0) emit(state - 1);
    });
    on<TripStepperResetRequested>((event, emit) {
      if (state != 0) emit(0);
    });
  }
}
