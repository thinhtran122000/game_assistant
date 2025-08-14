import 'package:hive_flutter/hive_flutter.dart';
 part 'vector_stores_model.g.dart';
@HiveType(typeId: 4)
class VectorStores {
  @HiveField(0)
  List<String> fileIds;
  @HiveField(1)
  Map<String, String>? metadata;
  @HiveField(2)
  ChunkingStrategy? chunkingStrategy;
  VectorStores({
    this.fileIds = const [],
    this.metadata,
    this.chunkingStrategy,
  });
  factory VectorStores.fromJson(Map<String, dynamic> json) => VectorStores(
        fileIds: json['vector_store_ids'] == null ? [] : List<String>.from(json['vector_store_ids'].map((x) => x)),
        metadata: json['metadata'] == null ? {} : Map<String, String>.from(json['metadata']),
        chunkingStrategy: json['chunking_strategy'] == null ? null : ChunkingStrategy.fromJson(json['chunking_strategy']),
      );
}

@HiveType(typeId: 5)
class ChunkingStrategy {
  @HiveField(0)
  String? type;
  @HiveField(1)
  Static? static;
  ChunkingStrategy({
    this.type,
    this.static,
  });

  factory ChunkingStrategy.fromJson(Map<String, dynamic> json) => ChunkingStrategy(
        type: json['type'],
        static: json['static'] == null ? null : Static.fromJson(json['static']),
      );
}

@HiveType(typeId: 6)
class Static {
  @HiveField(0)
  int? maxChunkSizeTokens;
  @HiveField(1)
  int? chunkOverlapTokens;
  Static({
    this.maxChunkSizeTokens,
    this.chunkOverlapTokens,
  });
  factory Static.fromJson(Map<String, dynamic> json) => Static(
        maxChunkSizeTokens: json['max_chunk_size_tokens'],
        chunkOverlapTokens: json['chunk_overlap_tokens'],
      );
}
