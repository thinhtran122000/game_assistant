import 'package:game_assistant/data/models/google/index.dart';

class GooglesModel {
  List<GoogleModel> items;

  GooglesModel({
    this.items = const [],
  });

  factory GooglesModel.fromJson(Map<String, dynamic> json) => GooglesModel(
        items: json['items'] == null ? [] : List<GoogleModel>.from(json['items'].map((x) => GoogleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'items': List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
