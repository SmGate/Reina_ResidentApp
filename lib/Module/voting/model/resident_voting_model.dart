// To parse this JSON data, do
//
//     final residentVotingModel = residentVotingModelFromJson(jsonString);

import 'dart:convert';

ResidentVotingModel residentVotingModelFromJson(String str) =>
    ResidentVotingModel.fromJson(json.decode(str));

String residentVotingModelToJson(ResidentVotingModel data) =>
    json.encode(data.toJson());

class ResidentVotingModel {
  String? message;
  bool? success;
  Data? data;

  ResidentVotingModel({
    this.message,
    this.success,
    this.data,
  });

  factory ResidentVotingModel.fromJson(Map<String, dynamic> json) =>
      ResidentVotingModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? pollId;
  String? pollOptionId;
  String? residentId;
  dynamic reason;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.pollId,
    this.pollOptionId,
    this.residentId,
    this.reason,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pollId: json["poll_id"],
        pollOptionId: json["poll_option_id"],
        residentId: json["resident_id"],
        reason: json["reason"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "poll_id": pollId,
        "poll_option_id": pollOptionId,
        "resident_id": residentId,
        "reason": reason,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
