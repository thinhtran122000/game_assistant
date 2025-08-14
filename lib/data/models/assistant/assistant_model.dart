import 'package:game_assistant/data/models/shared/index.dart';

class AssistantModel {
  String? id;
  String? object;
  int? createdAt;
  String? name;
  String? description;
  String? model;
  String? instructions;
  List<ToolModel> tools;
  Map<String, String>? metadata;
  double? topP;
  double? temperature;
  Map<String, dynamic>? responseFormat;
  // Method: DELETE
  bool? deleted;
  AssistantModel({
    this.id,
    this.object,
    this.createdAt,
    this.name,
    this.description,
    this.model,
    this.instructions,
    this.tools = const [],
    this.metadata,
    this.topP,
    this.temperature,
    this.responseFormat,
    this.deleted,
  });

  factory AssistantModel.fromJson(Map<String, dynamic> json) => AssistantModel(
        id: json['id'],
        object: json['object'],
        createdAt: json['created_at'],
        name: json['name'],
        description: json['description'],
        model: json['model'],
        instructions: json['instructions'],
        tools: json['tools'] == null ? [] : List<ToolModel>.from(json['tools'].map((x) => ToolModel.fromJson(x))),
        metadata: json['metadata'] == null ? {} : Map<String, String>.from(json['metadata']),
        topP: json['top_p'],
        temperature: json['temperature'],
        responseFormat: json['response_format'] == null ? {} : Map<String, dynamic>.from(json['response_format']),
        deleted: json['deleted'],
      );
}
