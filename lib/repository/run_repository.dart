import 'dart:async';

import 'package:game_assistant/core/di/di.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:game_assistant/dio/dio_config.dart';
import 'package:game_assistant/service/run_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class RunRepository {
  Future<List<RunModel>> getRuns({required String threadId, String? order}) async {
    final response = await RunService(getIt<DioConfig>().dio()).getRuns(threadId: threadId);
    return response.data;
  }

  Future<RunModel> getRunDetails({required String threadId, required String runId}) async =>
      RunService(getIt<DioConfig>().dio()).getRunDetails(threadId: threadId, runId: runId);

  Future<RunModel> createRun({
    required String threadId,
    required String assistantId,
    Map<String, String>? metadata,
  }) async => RunService(
    getIt<DioConfig>().dio(),
  ).createRun(threadId: threadId, body: {'assistant_id': assistantId, 'metadata': metadata});

  Future<RunModel> deleteMessage({required String threadId, required String runId}) async =>
      RunService(getIt<DioConfig>().dio()).cancelRun(threadId: threadId, runId: runId);

  // Stream<Uint8List> createRun({
  //   required String threadId,
  //   required String assistantId,
  //   Map<String, String>? metadata,
  // }) async* {
  //   final streamRun = await RunService(DioConfig().dio()).createRun(
  //     threadId: threadId,
  //     body: {
  //       'assistant_id': assistantId,
  //       'metadata': metadata,
  //       'stream': true,
  //     },
  //   );
  //   yield* (streamRun.data as ResponseBody).stream;
  // }
}
