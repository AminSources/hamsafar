import 'package:bloc/bloc.dart';

class TripStepperCubit extends Cubit<int> {
  TripStepperCubit() : super(0);

  //? on next step
  void nextStep() {
    emit(state + 1);
  }

  //? on previous step
  void previousStep() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  //? reset stepper
  void reset() {
    emit(0);
  }
}
