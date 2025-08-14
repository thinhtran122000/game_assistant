import 'package:dio/dio.dart';
import 'package:game_assistant/data/models/run/index.dart';
import 'package:retrofit/retrofit.dart';

part 'run_service.g.dart';

@RestApi(baseUrl: '')
abstract class RunService {
  factory RunService(Dio dio, {String baseUrl}) = _RunService;

  @GET('/threads/{thread_id}/runs')
  Future<RunsModel> getRuns({@Path('thread_id') required String threadId});

  @GET('/threads/{thread_id}/runs/{run_id}')
  Future<RunModel> getRunDetails({@Path('thread_id') required String threadId, @Path('run_id') required String runId});

  @POST('/threads/{thread_id}/runs')
  Future<RunModel> createRun({@Path('thread_id') required String threadId, @Body() required Map<String, dynamic> body});

  @POST('/threads/{thread_id}/runs/{run_id}/cancel')
  Future<RunModel> cancelRun({@Path('thread_id') required String threadId, @Path('run_id') required String runId});

  // @POST('/threads/{thread_id}/runs')
  // @DioResponseType(ResponseType.stream)
  // Future<HttpResponse> createRun({
  //   @Path('thread_id') required String threadId,
  //   @Body() required Map<String, dynamic> body,
  // });
}
