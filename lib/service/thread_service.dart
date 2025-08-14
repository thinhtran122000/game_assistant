import 'package:dio/dio.dart';
import 'package:game_assistant/data/models/thread/thread_model.dart';
import 'package:retrofit/retrofit.dart';

part 'thread_service.g.dart';

@RestApi(baseUrl: '')
abstract class ThreadService {
  factory ThreadService(Dio dio, {String baseUrl}) = _ThreadService;

  @GET('/threads/{thread_id}')
  Future<ThreadModel> getThreadDetails({@Path('thread_id') required String threadId});

  @POST('/threads')
  Future<ThreadModel> createThread({@Body() required Map<String, dynamic> body});

  @DELETE('/threads/{thread_id}')
  Future<ThreadModel> deleteThread({@Path('thread_id') required String threadId});
}
