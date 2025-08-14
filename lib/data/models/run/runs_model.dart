import 'package:game_assistant/data/models/run/index.dart';

class RunsModel {
  String? object;
  List<RunModel> data;
  String? firstId;
  String? lastId;
  bool? hasMore;

  RunsModel({
    this.object,
    this.data = const [],
    this.firstId,
    this.lastId,
    this.hasMore,
  });

  factory RunsModel.fromJson(Map<String, dynamic> json) => RunsModel(
        object: json['object'],
        data: json['data'] == null ? [] : List<RunModel>.from(json['data'].map((x) => RunModel.fromJson(x))),
        firstId: json['first_id'],
        lastId: json['last_id'],
        hasMore: json['has_more'],
      );
}
