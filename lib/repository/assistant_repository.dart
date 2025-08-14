import 'package:game_assistant/core/di/di.dart';
import 'package:game_assistant/data/models/assistant/assistant_model.dart';
import 'package:game_assistant/dio/dio_config.dart';
import 'package:game_assistant/service/assistant_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssistantRepository {
  Future<List<AssistantModel>> getAssistants() async {
    final response = await AssistantService(getIt<DioConfig>().dio()).getAssistants();
    return response.data;
  }

  Future<AssistantModel> createAssistant({
    required String name,
    required String instructions,
    required String model,
    Map<String, String>? metadata,
    List<Map<String, dynamic>>? tools,
    Map<String, dynamic>? responseFormat,
  }) async => AssistantService(getIt<DioConfig>().dio()).createAssistant(
    body: {
      'name': name,
      'instructions': instructions,
      'tools': tools,
      'model': model,
      'metadata': metadata,
      'response_format': responseFormat,
    },
  );

  Future<AssistantModel> deleteAssistant({required String assistantId}) async =>
      AssistantService(getIt<DioConfig>().dio()).deleteAssistant(assistantId: assistantId);
}
