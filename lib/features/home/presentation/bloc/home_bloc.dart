import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/features/home/domain/entities/home_entity.dart';
import 'package:hamsafar/features/home/domain/usecases/get_home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeUsecase getHomeUsecase;

  HomeBloc({required this.getHomeUsecase}) : super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHome);
  }

  Future<void> _onLoadHome(HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final result = await getHomeUsecase(NoParams());

    if (result.data != null) {
      emit(HomeSuccess(result.data!));
    } else {
      emit(HomeFailed(result.message ?? "Error on getting home data"));
    }
  }
}
