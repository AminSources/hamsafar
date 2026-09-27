part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final HomeEntity homeEntity;

  const HomeSuccess(this.homeEntity);

  @override
  List<Object> get props => [homeEntity];
}

final class HomeFailed extends HomeState {
  final String message;

  const HomeFailed(this.message);

  @override
  List<Object> get props => [message];
}
