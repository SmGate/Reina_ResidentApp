// To parse this JSON data, do
//
//     final getAllPollModel = getAllPollModelFromJson(jsonString);

import 'dart:convert';

GetAllPollModel getAllPollModelFromJson(String str) =>
    GetAllPollModel.fromJson(json.decode(str));

String getAllPollModelToJson(GetAllPollModel data) =>
    json.encode(data.toJson());

class GetAllPollModel {
  String? message;
  bool? success;
  List<Datum>? data;

  GetAllPollModel({
    this.message,
    this.success,
    this.data,
  });

  factory GetAllPollModel.fromJson(Map<String, dynamic> json) =>
      GetAllPollModel(
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
  DateTime? endDate;
  String? endTime;
  int? isResonable;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  int? isMarked;
  List<Result>? results;
  List<Option>? options;

  Datum({
    this.id,
    this.societyId,
    this.title,
    this.endDate,
    this.endTime,
    this.isResonable,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.isMarked,
    this.results,
    this.options,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        societyId: json["society_id"],
        title: json["title"],
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        endTime: json["end_time"],
        isResonable: json["is_resonable"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
        isMarked: json["is_marked"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "society_id": societyId,
        "title": title,
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "end_time": endTime,
        "is_resonable": isResonable,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "is_marked": isMarked,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  int? id;
  int? pollId;
  String? option;
  int? votes;
  int? percentage;
  int? isSelected;

  Option({
    this.id,
    this.pollId,
    this.option,
    this.votes,
    this.percentage,
    this.isSelected,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        pollId: json["poll_id"],
        option: json["option"],
        votes: json["votes"],
        percentage: json["percentage"],
        isSelected: json["is_selected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poll_id": pollId,
        "option": option,
        "votes": votes,
        "percentage": percentage,
        "is_selected": isSelected,
      };
}

class Result {
  String? option;
  int? votes;
  int? percentage;

  Result({
    this.option,
    this.votes,
    this.percentage,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        option: json["option"],
        votes: json["votes"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "option": option,
        "votes": votes,
        "percentage": percentage,
      };
}
