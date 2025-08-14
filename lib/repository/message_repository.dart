import 'package:game_assistant/core/di/di.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:game_assistant/dio/dio_config.dart';
import 'package:game_assistant/service/message_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class MessageRepository {
  Future<List<MessageModel>> getMessages({required String threadId, String? order}) async {
    final response = await MessageService(getIt<DioConfig>().dio()).getMessages(threadId: threadId, order: order);
    return response.data;
  }

  Future<MessageModel> createMessage({
    required String threadId,
    required String role,
    required String text,
    required String type,
    List<Map<String, dynamic>>? attachments,
    Map<String, String>? metadata,
  }) async => MessageService(getIt<DioConfig>().dio()).createMessage(
    threadId: threadId,
    body: {
      'metadata': metadata,
      'attachments': attachments,
      'role': role,
      'content': [
        {'type': type, 'text': text},
      ],
    },
  );

  Future<MessageModel> deleteMessage({required String threadId, required String messageId}) async =>
      MessageService(getIt<DioConfig>().dio()).deleteMessage(threadId: threadId, messageId: messageId);
}
