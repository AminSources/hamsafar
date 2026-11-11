import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

sealed class FriendsTabBarEvent extends Equatable {
  const FriendsTabBarEvent();

  @override
  List<Object?> get props => [];
}

final class FriendsTabChanged extends FriendsTabBarEvent {
  final int index;

  const FriendsTabChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class FriendsTabBarBloc extends Bloc<FriendsTabBarEvent, int> {
  FriendsTabBarBloc() : super(0) {
    on<FriendsTabChanged>((event, emit) {
      if (event.index >= 0 && event.index < 3 && event.index != state) {
        emit(event.index);
      }
    });
  }
}
