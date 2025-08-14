import 'package:game_assistant/data/models/message/index.dart';

class MessagesModel {
  List<MessageModel> data;
  String? object;
  String? firstId;
  String? lastId;
  bool? hasMore;

  MessagesModel({
    this.data = const [],
    this.object,
    this.firstId,
    this.lastId,
    this.hasMore,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
        data: json['data'] == null ? [] : List<MessageModel>.from(json['data'].map((x) => MessageModel.fromJson(x))),
        object: json['object'],
        firstId: json['first_id'],
        lastId: json['last_id'],
        hasMore: json['has_more'],
      );
}
