import 'package:bloc/bloc.dart';

class TripDateCoordinationCubit extends Cubit<bool> {
  TripDateCoordinationCubit() : super(true);

  //? on change value ( is fixed or voting)
  void onChangeValue(bool value) => value != state ? emit(value) : null;
}
