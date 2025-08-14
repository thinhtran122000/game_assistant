import 'package:dio/dio.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:retrofit/retrofit.dart';

part 'message_service.g.dart';

@RestApi(baseUrl: '')
abstract class MessageService {
  factory MessageService(Dio dio, {String baseUrl}) = _MessageService;

  @GET('/threads/{thread_id}/messages')
  Future<MessagesModel> getMessages({@Path('thread_id') required String threadId, @Query('order') String? order});

  @GET('/threads/{thread_id}/messages/{message_id}')
  Future<MessageModel> getMessageDetails({
    @Path('thread_id') required String threadId,
    @Path('message_id') required String messageId,
  });

  @POST('/threads/{thread_id}/messages')
  Future<MessageModel> createMessage({
    @Path('thread_id') required String threadId,
    @Body() required Map<String, dynamic> body,
  });

  @DELETE('/threads/{thread_id}/messages/{message_id}')
  Future<MessageModel> deleteMessage({
    @Path('thread_id') required String threadId,
    @Path('message_id') required String messageId,
  });
}
