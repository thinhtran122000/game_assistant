import 'package:game_assistant/data/models/shared/code_interpreter_model.dart';
import 'package:game_assistant/data/models/shared/file_search_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'tool_resource_model.g.dart';

@HiveType(typeId: 1)
class ToolResources {
  @HiveField(0)
  CodeInterpreter? codeInterpreter;
  @HiveField(1)
  FileSearch? fileSearch;

  ToolResources({
    this.codeInterpreter,
    this.fileSearch,
  });

  factory ToolResources.fromJson(Map<String, dynamic> json) => ToolResources(
        codeInterpreter: json['code_interpreter'],
        fileSearch: json['file_search'],
      );
}
