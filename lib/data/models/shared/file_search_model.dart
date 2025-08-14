import 'package:game_assistant/data/models/index.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'file_search_model.g.dart';

@HiveType(typeId: 3)
class FileSearch {
  @HiveField(0)
  List<String> fileIds;
  @HiveField(1)
  List<VectorStores> vectorStores;

  FileSearch({
    this.fileIds = const [],
    this.vectorStores = const [],
  });

  factory FileSearch.fromJson(Map<String, dynamic> json) => FileSearch(
        fileIds: json['vector_store_ids'] == null ? [] : List<String>.from(json['vector_store_ids'].map((x) => x)),
        vectorStores: json['vector_stores'] == null
            ? []
            : List<VectorStores>.from(json['vector_stores'].map((x) => VectorStores.fromJson(x))),
      );
}
