import 'package:dio/dio.dart';
import 'package:game_assistant/constants/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@injectable
class DioConfig {
  Dio dio({DioType dioType = DioType.openAI}) {
    final dio = Dio(
        BaseOptions(
          baseUrl: dioType == DioType.openAI ? Constants.openAIHost : Constants.googleHost,
          headers:
              dioType == DioType.openAI
                  ? {'Authorization': 'Bearer ${Constants.openAiApiKey}', 'OpenAI-Beta': 'assistants=v2'}
                  : {},
          contentType: Headers.jsonContentType,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      )
      ..interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
        ),
      );
    return dio;
  }
}

enum DioType { openAI, google }
