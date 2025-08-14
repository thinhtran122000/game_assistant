import 'package:game_assistant/data/models/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'thread_model.g.dart';

@HiveType(typeId: 0)
class ThreadModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? object;

  @HiveField(2)
  int? createdAt;

  @HiveField(3)
  ToolResources? toolResources;

  @HiveField(4)
  Map<String, String>? metadata;

  @HiveField(5)
  // Method: DELETE
  bool? deleted;

  ThreadModel({
    this.id,
    this.createdAt,
    this.toolResources,
    this.metadata,
    this.object,
    this.deleted,
  });

  factory ThreadModel.fromJson(Map<String, dynamic> json) => ThreadModel(
        id: json['id'],
        object: json['object'],
        createdAt: json['created_at'],
        toolResources: json['tool_resources'] == null ? null : ToolResources.fromJson(json['tool_resources']),
        metadata: json['metadata'] == null ? {} : Map<String, String>.from(json['metadata']),
        deleted: json['deleted'],
      );
}
