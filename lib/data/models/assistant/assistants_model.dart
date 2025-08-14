import 'package:game_assistant/data/models/assistant/assistant_model.dart';

class AssistantsModel {
  List<AssistantModel> data;
  String? object;
  String? firstId;
  String? lastId;
  bool? hasMore;
  AssistantsModel({
    this.data = const [],
    this.object,
    this.firstId,
    this.lastId,
    this.hasMore,
  });
  factory AssistantsModel.fromJson(Map<String, dynamic> json) => AssistantsModel(
        data:
            json['data'] == null ? [] : List<AssistantModel>.from(json['data'].map((x) => AssistantModel.fromJson(x))),
        object: json['object'],
        firstId: json['first_id'],
        lastId: json['last_id'],
        hasMore: json['has_more'],
      );
}
