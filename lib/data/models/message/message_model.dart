import 'dart:convert';

import 'package:game_assistant/data/models/shared/index.dart';

class MessageModel {
  String? id;
  String? assistantId;
  String? threadId;
  String? runId;
  List<Attachment> attachments;
  String? role;
  String? status;
  List<Content> content;
  String? object;
  int? createdAt;
  int? completedAt;
  int? incompleteAt;
  IncompleteDetailsModel? incompleteDetails;
  Map<String, String>? metadata;
  // Method: DELETE
  bool? deleted;

  MessageModel({
    this.id,
    this.assistantId,
    this.threadId,
    this.runId,
    this.attachments = const [],
    this.role,
    this.status,
    this.content = const [],
    this.object,
    this.createdAt,
    this.completedAt,
    this.incompleteAt,
    this.incompleteDetails,
    this.metadata,
    this.deleted,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        assistantId: json['assistant_id'],
        attachments: json['attachments'] == null
            ? []
            : List<Attachment>.from(json['attachments'].map((x) => Attachment.fromJson(x))),
        completedAt: json['completed_at'],
        content: json['content'] == null ? [] : List<Content>.from(json['content'].map((x) => Content.fromJson(x))),
        createdAt: json['created_at'],
        incompleteAt: json['incomplete_at'],
        incompleteDetails:
            json['incomplete_details'] == null ? null : IncompleteDetailsModel.fromJson(json['incomplete_details']),
        metadata: json['metadata'] == null ? {} : Map<String, String>.from(json['metadata']),
        object: json['object'],
        role: json['role'],
        runId: json['run_id'],
        status: json['status'],
        threadId: json['thread_id'],
        deleted: json['deleted'],
      );
}

class Attachment {
  String? fileId;
  List<ToolModel> tools;

  Attachment({
    this.fileId,
    this.tools = const [],
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        fileId: json['file_id'],
        tools: json['tools'] == null ? [] : List<ToolModel>.from(json['tools'].map((x) => ToolModel.fromJson(x))),
      );
}

class Content {
  ImageFile? imageFile;
  String? type;
  TextModel? text;
  // stream response
  int? index;

  Content({
    this.imageFile,
    this.type,
    this.text,
    this.index,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        imageFile: json['image_file'] == null ? null : ImageFile.fromJson(json['image_file']),
        type: json['type'],
        text: json['text'] == null ? null : TextModel.fromJson(json['text']),
        index: json['index'],
      );
}

class ImageFile {
  String? fileId;
  String? detail;

  ImageFile({
    this.fileId,
    this.detail,
  });

  factory ImageFile.fromJson(Map<String, dynamic> json) => ImageFile(
        fileId: json['file_id'],
        detail: json['detail'],
      );
}

class TextModel {
  List<Annotation> annotations;
  dynamic value;

  TextModel({
    this.annotations = const [],
    this.value,
  });

  factory TextModel.fromJson(Map<String, dynamic> json) {
    if (checkJsonType(json['value'])) {
      return TextModel(
        annotations: json['annotations'] == null
            ? []
            : List<Annotation>.from(json['annotations'].map((x) => Annotation.fromJson(x))),
        value: json['value'] != null ? Value.fromJson(jsonDecode(json['value'])) : null,
      );
    } else {
      return TextModel(
        annotations: json['annotations'] == null
            ? []
            : List<Annotation>.from(json['annotations'].map((x) => Annotation.fromJson(x))),
        value: json['value'] as String?,
      );
    }
  }
}

class Value {
  TextResponse? text;
  ImagesResponse? images;
  VideosResponse? videos;
  ResourcesResponse? resources;

  Value({
    this.text,
    this.images,
    this.videos,
    this.resources,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        text: json['text'] == null ? null : TextResponse.fromJson(json['text']),
        images: json['images'] == null ? null : ImagesResponse.fromJson(json['images']),
        videos: json['videos'] == null ? null : VideosResponse.fromJson(json['videos']),
        resources: json['resources'] == null ? null : ResourcesResponse.fromJson(json['resources']),
      );

  Map<String, dynamic> toJson() => {
        'text': text?.toJson(),
        'images': images?.toJson(),
        'videos': videos?.toJson(),
        'resources': resources?.toJson(),
      };
}

class ImagesResponse {
  String? type;
  List<String> imageUrl;

  ImagesResponse({
    this.type,
    this.imageUrl = const [],
  });

  factory ImagesResponse.fromJson(Map<String, dynamic> json) => ImagesResponse(
        type: json['type'],
        imageUrl: json['image_url'] == null ? [] : List<String>.from(json['image_url'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'image_url': List<dynamic>.from(imageUrl.map((x) => x)),
      };
}

class ResourcesResponse {
  String? type;
  List<Resource> resourceList;

  ResourcesResponse({
    this.type,
    this.resourceList = const [],
  });

  factory ResourcesResponse.fromJson(Map<String, dynamic> json) => ResourcesResponse(
        type: json['type'],
        resourceList: json['resource_list'] == null
            ? []
            : List<Resource>.from(json['resource_list'].map((x) => Resource.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'resource_list': List<dynamic>.from(resourceList.map((x) => x.toJson())),
      };
}

class Resource {
  String? resourceName;
  String? resourceUrl;
  String? siteIconUrl;

  Resource({
    this.resourceName,
    this.resourceUrl,
    this.siteIconUrl,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        resourceName: json['resource_name'],
        resourceUrl: json['resource_url'],
        siteIconUrl: json['site_icon_url'],
      );

  Map<String, dynamic> toJson() => {
        'resource_name': resourceName,
        'resource_url': resourceUrl,
        'site_icon_url': siteIconUrl,
      };
}

class TextResponse {
  String type;
  String value;

  TextResponse({
    required this.type,
    required this.value,
  });

  factory TextResponse.fromJson(Map<String, dynamic> json) => TextResponse(
        type: json['type'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };
}

class VideosResponse {
  String type;
  List<String> videoUrl;

  VideosResponse({
    required this.type,
    required this.videoUrl,
  });

  factory VideosResponse.fromJson(Map<String, dynamic> json) => VideosResponse(
        type: json['type'],
        videoUrl: List<String>.from(json['video_url'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'video_url': List<dynamic>.from(videoUrl.map((x) => x)),
      };
}

class Annotation {
  int? endIndex;
  FilePath? filePath;
  int? startIndex;
  String? text;
  String? type;

  Annotation({
    this.endIndex,
    this.filePath,
    this.startIndex,
    this.text,
    this.type,
  });

  factory Annotation.fromJson(Map<String, dynamic> json) => Annotation(
        endIndex: json['end_index'],
        filePath: json['file_path'] == null ? null : FilePath.fromJson(json['file_path']),
        startIndex: json['start_index'],
        text: json['text'],
        type: json['type'],
      );
}

class FilePath {
  String? fileId;

  FilePath({
    this.fileId,
  });

  factory FilePath.fromJson(Map<String, dynamic> json) => FilePath(
        fileId: json['file_id'],
      );
}

bool checkJsonType(String message) {
  try {
    var decoded = jsonDecode(message);
    return decoded is Map<String, dynamic> || decoded is List<dynamic>;
  } catch (e) {
    return false;
  }
}
