import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/home/data/data_source/remote/supabase_home_datasource.dart';
import 'package:hamsafar/features/home/data/models/home_model.dart';
import 'package:hamsafar/features/home/domain/entities/home_entity.dart';
import 'package:hamsafar/features/home/domain/repositories/home_repository.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepositoryImpl extends HomeRepository {
  final SupabaseHomeDatasource supabaseHomeDatasource;

  HomeRepositoryImpl({required this.supabaseHomeDatasource});
  final Logger log = Logger();

  @override
  Future<DataState<HomeEntity>> getHome(NoParams params) async {
    try {
      final json = await supabaseHomeDatasource.getHomeData();

      return DataSuccess(HomeModel.fromJson(json));
    } on AuthException catch (e) {
      log.e(e.message);
      return DataFailed(e.message);
    } on PostgrestException catch (e) {
      log.e(e.message);
      return DataFailed(e.message);
    } catch (e) {
      return DataFailed("Error on getting home data: ${e.toString()}");
    }
  }
}
