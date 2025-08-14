import 'package:dio/dio.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:retrofit/retrofit.dart';

part 'submit_tool_service.g.dart';

@RestApi(baseUrl: '')
abstract class SubmitToolService {
  factory SubmitToolService(Dio dio, {String baseUrl}) = _SubmitToolService;

  @POST('/threads/{thread_id}/runs/{run_id}/submit_tool_outputs')
  Future<RunModel> submitTool({
    @Path('thread_id') required String threadId,
    @Path('run_id') required String runId,
    @Body() required Map<String, dynamic> body,
  });
}
