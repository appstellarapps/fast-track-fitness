// To parse this JSON data, do
//
//     final trainingModeModel = trainingModeModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

TrainingModeModel trainingModeModelFromJson(String str) => TrainingModeModel.fromJson(json.decode(str));

String trainingModeModelToJson(TrainingModeModel data) => json.encode(data.toJson());

class TrainingModeModel {
  int status;
  String message;
  List<TrainingMode> result;

  TrainingModeModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory TrainingModeModel.fromJson(Map<String, dynamic> json) => TrainingModeModel(
    status: json["status"],
    message: json["message"],
    result: List<TrainingMode>.from(json["result"].map((x) => TrainingMode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class TrainingMode {
  String id;
  String userId;
  String title;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  var isSelected = false.obs;

  TrainingMode({
    required this.id,
    required this.userId,
    required this.title,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TrainingMode.fromJson(Map<String, dynamic> json) => TrainingMode(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "title": title,
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
  };
}
