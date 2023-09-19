import 'dart:convert';

import 'package:get/get.dart';

class TdeeModel {
  String? title;
  String? subTitle;
  double? value;
  var isSelected = false.obs;

  TdeeModel(this.title, this.subTitle, this.value);
}

// To parse this JSON data, do
//
//     final tdeeDataModel = tdeeDataModelFromJson(jsonString);

TdeeDataModel tdeeDataModelFromJson(String str) => TdeeDataModel.fromJson(json.decode(str));

String tdeeDataModelToJson(TdeeDataModel data) => json.encode(data.toJson());

class TdeeDataModel {
  int status;
  String message;
  Result? result;

  TdeeDataModel({
    required this.status,
    required this.message,
    this.result,
  });

  factory TdeeDataModel.fromJson(Map<String, dynamic> json) => TdeeDataModel(
      status: json["status"],
      message: json["message"],
      result: (json['result'] as Map).isNotEmpty ? Result.fromJson(json["result"]) : null);

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result!.toJson(),
      };
}

class Result {
  String id;
  String traineeId;
  String gender;
  dynamic height;
  String heightType;
  dynamic weight;
  String weightType;
  String activityLevel;
  String goalName;
  int calories;
  int protein;
  int age;
  String proteinPercentage;
  int carbs;
  String carbsPercentage;
  int fat;
  String fatPercentage;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;

  Result({
    required this.id,
    required this.traineeId,
    required this.gender,
    required this.height,
    required this.heightType,
    required this.weight,
    required this.weightType,
    required this.activityLevel,
    required this.goalName,
    required this.calories,
    required this.protein,
    required this.proteinPercentage,
    required this.carbs,
    required this.carbsPercentage,
    required this.fat,
    required this.age,
    required this.fatPercentage,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        traineeId: json["traineeId"],
        gender: json["gender"],
        height: json["height"],
        heightType: json["heightType"],
        weight: json["weight"],
        weightType: json["weightType"],
        activityLevel: json["activityLevel"],
        goalName: json["goalName"],
        age: json["age"],
        calories: json["calories"],
        protein: json["protein"],
        proteinPercentage: json["proteinPercentage"],
        carbs: json["carbs"],
        carbsPercentage: json["carbsPercentage"],
        fat: json["fat"],
        fatPercentage: json["fatPercentage"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "traineeId": traineeId,
        "gender": gender,
        "height": height,
        "heightType": heightType,
        "weight": weight,
        "weightType": weightType,
        "activityLevel": activityLevel,
        "goalName": goalName,
        "calories": calories,
        "age": age,
        "protein": protein,
        "proteinPercentage": proteinPercentage,
        "carbs": carbs,
        "carbsPercentage": carbsPercentage,
        "fat": fat,
        "fatPercentage": fatPercentage,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
