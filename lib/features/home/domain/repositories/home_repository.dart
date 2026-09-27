import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
  Future<DataState<HomeEntity>> getHome(NoParams params);
}
