import 'package:dio/dio.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:retrofit/retrofit.dart';

part 'assistant_service.g.dart';

@RestApi(baseUrl: '')
abstract class AssistantService {
  factory AssistantService(Dio dio, {String baseUrl}) = _AssistantService;

  @GET('/assistants')
  Future<AssistantsModel> getAssistants();

  @GET('/assistants/{assistant_id}')
  Future<AssistantModel> getAssistantDetails({@Path('assistant_id') required String assistantId});

  @POST('/assistants')
  Future<AssistantModel> createAssistant({@Body() required Map<String, dynamic> body});

  @DELETE('/assistants/{assistant_id}')
  Future<AssistantModel> deleteAssistant({@Path('assistant_id') required String assistantId});
}
