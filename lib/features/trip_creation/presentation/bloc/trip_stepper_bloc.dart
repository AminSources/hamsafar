import 'package:bloc/bloc.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_stepper_event.dart';

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
