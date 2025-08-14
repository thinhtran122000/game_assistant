import 'package:dio/dio.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:retrofit/retrofit.dart';

part 'google_service.g.dart';

@RestApi(baseUrl: '')
abstract class GoogleService {
  factory GoogleService(Dio dio, {String baseUrl}) = _GoogleService;

  @GET('/customsearch/v1')
  Future<GooglesModel> getSearch({
    @Query('key') required String apiKey,
    @Query('cx') required String engineId,
    @Query('q') required String query,
    @Query('gl') String? region,
    @Query('lr') String? language,
    @Query('sort') String? sort,
    @Query('siteSearch') String? siteSearch,
    @Query('siteSearchFilter') String? siteSearchFilter,
  });
}
