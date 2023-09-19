// To parse this JSON data, do
//
//     final trainingTypeModel = trainingTypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

TrainingTypeModel trainingTypeModelFromJson(String str) => TrainingTypeModel.fromJson(json.decode(str));

String trainingTypeModelToJson(TrainingTypeModel data) => json.encode(data.toJson());

class TrainingTypeModel {
  int status;
  String message;
  List<TrainingTypes> result;

  TrainingTypeModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory TrainingTypeModel.fromJson(Map<String, dynamic> json) => TrainingTypeModel(
    status: json["status"],
    message: json["message"],
    result: List<TrainingTypes>.from(json["result"].map((x) => TrainingTypes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class TrainingTypes {
  String id;
  String userId;
  String title;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  var isSelected = false.obs;

  TrainingTypes({
    required this.id,
    required this.userId,
    required this.title,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TrainingTypes.fromJson(Map<String, dynamic> json) => TrainingTypes(
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
