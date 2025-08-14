import 'package:game_assistant/core/di/di.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:game_assistant/dio/dio_config.dart';
import 'package:game_assistant/service/google_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleRepository {
  Future<List<GoogleModel>> getSearch({
    required String apiKey,
    required String engineId,
    required String query,
    String? region,
    String? language,
    String? sort,
    String? siteSearch,
    String? siteSearchFilter,
  }) async {
    final listSearch = await GoogleService(getIt<DioConfig>().dio(dioType: DioType.google)).getSearch(
      apiKey: apiKey,
      engineId: engineId,
      query: query,
      region: region,
      language: language,
      sort: sort,
      siteSearch: siteSearch,
      siteSearchFilter: siteSearchFilter,
    );
    return listSearch.items;
  }
}
