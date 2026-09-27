import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/core/usecase/usecase.dart';
import 'package:hamsafar/features/home/domain/entities/home_entity.dart';
import 'package:hamsafar/features/home/domain/repositories/home_repository.dart';

class GetHomeUsecase implements Usecase<DataState<HomeEntity>, NoParams> {
  final HomeRepository homeRepository;

  GetHomeUsecase({required this.homeRepository});

  @override
  Future<DataState<HomeEntity>> call(NoParams params) {
    return homeRepository.getHome(params);
  }
}
