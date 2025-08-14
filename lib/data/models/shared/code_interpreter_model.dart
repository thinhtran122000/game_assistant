import 'package:hive_flutter/hive_flutter.dart';
 part 'code_interpreter_model.g.dart';
@HiveType(typeId: 2)
class CodeInterpreter {
  @HiveField(0)
  List<String> fileIds;

  CodeInterpreter({
    this.fileIds = const [],
  });

  factory CodeInterpreter.fromJson(Map<String, dynamic> json) => CodeInterpreter(
        fileIds: json['file_ids'] == null ? [] : List<String>.from(json['file_ids'].map((x) => x)),
      );
}
