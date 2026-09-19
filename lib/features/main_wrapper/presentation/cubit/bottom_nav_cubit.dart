import 'package:bloc/bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  //? change page index
  void onChangePage(int index) {
    if (index != state) {
      emit(index);
    }
  }
}
