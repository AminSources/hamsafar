import 'package:bloc/bloc.dart';

class FriendsTabBarCubit extends Cubit<int> {
  FriendsTabBarCubit() : super(0);

  //? on change tab bar
  void onChangeTabbar(int index) => index != state ? emit(index) : null;
}
