import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

sealed class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object?> get props => [];
}

final class BottomNavIndexChanged extends BottomNavEvent {
  final int index;

  const BottomNavIndexChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class BottomNavBloc extends Bloc<BottomNavEvent, int> {
  BottomNavBloc() : super(0) {
    on<BottomNavIndexChanged>((event, emit) {
      if (event.index >= 0 && event.index < 4 && event.index != state) {
        emit(event.index);
      }
    });
  }
}
