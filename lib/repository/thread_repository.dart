import 'package:game_assistant/core/di/di.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:game_assistant/data/models/thread/thread_model.dart';
import 'package:game_assistant/dio/dio_config.dart';
import 'package:game_assistant/service/thread_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class ThreadRepository {
  Future<ThreadModel> getThreadDetails({required String threadId}) async =>
      ThreadService(getIt<DioConfig>().dio()).getThreadDetails(threadId: threadId);

  Future<ThreadModel> createThread({
    String? role,
    List<Map<String, dynamic>>? content,
    Map<String, String>? metadata,
  }) async => ThreadService(getIt<DioConfig>().dio()).createThread(
    body: {
      'metadata': metadata,
      'messages': [
        {'role': role, 'content': content},
      ],
    },
  );

  Future<ThreadModel> deleteThread({required String threadId}) async =>
      ThreadService(getIt<DioConfig>().dio()).deleteThread(threadId: threadId);
}
