class ToolModel {
  String? type;

  ToolModel({
    this.type,
  });

  factory ToolModel.fromJson(Map<String, dynamic> json) => ToolModel(
        type: json['type'],
      );
      
  Map<String, dynamic> toJson() => {
        'type': type,
      };
}
