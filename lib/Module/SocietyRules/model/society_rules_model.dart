// To parse this JSON data, do
//
//     final societyRuleModel = societyRuleModelFromJson(jsonString);

import 'dart:convert';

SocietyRuleModel societyRuleModelFromJson(String str) =>
    SocietyRuleModel.fromJson(json.decode(str));

String societyRuleModelToJson(SocietyRuleModel data) =>
    json.encode(data.toJson());

class SocietyRuleModel {
  String? message;
  bool? success;
  List<Datum>? data;

  SocietyRuleModel({
    this.message,
    this.success,
    this.data,
  });

  factory SocietyRuleModel.fromJson(Map<String, dynamic> json) =>
      SocietyRuleModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? societyId;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.societyId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        societyId: json["society_id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "society_id": societyId,
        "title": title,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
