class IncompleteDetailsModel {
  String? reason;
  IncompleteDetailsModel({
    this.reason,
  });

  factory IncompleteDetailsModel.fromJson(Map<String, dynamic> json) => IncompleteDetailsModel(
        reason: json['reason'],
      );
}
