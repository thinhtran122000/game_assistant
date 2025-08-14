import 'dart:async';

import 'package:game_assistant/core/di/di.dart';
import 'package:game_assistant/data/models/run/index.dart';
import 'package:game_assistant/dio/dio_config.dart';
import 'package:game_assistant/service/submit_tool_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubmitToolRepository {
  Future<RunModel> submitTool({
    required String threadId,
    required String runId,
    required List<Map<String, dynamic>> toolOutputs,
  }) async => SubmitToolService(
    getIt<DioConfig>().dio(),
  ).submitTool(runId: runId, threadId: threadId, body: {'tool_outputs': toolOutputs});
}
