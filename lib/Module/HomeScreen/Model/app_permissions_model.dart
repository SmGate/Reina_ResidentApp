// To parse this JSON data, do
//
//     final appPermissionsModel = appPermissionsModelFromJson(jsonString);

import 'dart:convert';

AppPermissionsModel appPermissionsModelFromJson(String str) =>
    AppPermissionsModel.fromJson(json.decode(str));

String appPermissionsModelToJson(AppPermissionsModel data) =>
    json.encode(data.toJson());

class AppPermissionsModel {
  String? message;
  bool? success;
  Map<String, bool>? data;

  AppPermissionsModel({
    this.message,
    this.success,
    this.data,
  });

  factory AppPermissionsModel.fromJson(Map<String, dynamic> json) =>
      AppPermissionsModel(
        message: json["message"],
        success: json["success"],
        data:
            Map.from(json["data"]!).map((k, v) => MapEntry<String, bool>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
