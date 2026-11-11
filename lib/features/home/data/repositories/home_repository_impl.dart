import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/home/data/data_source/remote/supabase_home_datasource.dart';
import 'package:hamsafar/features/home/data/models/home_model.dart';
import 'package:hamsafar/features/home/domain/entities/home_entity.dart';
import 'package:hamsafar/features/home/domain/repositories/home_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepositoryImpl extends HomeRepository {
  final SupabaseHomeDatasource supabaseHomeDatasource;

  HomeRepositoryImpl({required this.supabaseHomeDatasource});

  @override
  Future<DataState<HomeEntity>> getHome(NoParams params) async {
    try {
      final json = await supabaseHomeDatasource.getHomeData();

      return DataSuccess(HomeModel.fromJson(json));
    } on AuthException {
      return const DataFailed(
        'برای دریافت اطلاعات صفحهٔ خانه ابتدا وارد حساب خود شوید.',
      );
    } on PostgrestException {
      return const DataFailed(
        'دریافت اطلاعات صفحهٔ خانه ناموفق بود. لطفاً دوباره تلاش کنید.',
      );
    } catch (_) {
      return const DataFailed(
        'دریافت اطلاعات صفحهٔ خانه ناموفق بود. اتصال اینترنت را بررسی کنید.',
      );
    }
  }
}
