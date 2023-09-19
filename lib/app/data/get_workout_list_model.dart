// To parse this JSON data, do
//
//     final getWorkoutList = getWorkoutListFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetWorkoutList getWorkoutListFromJson(String str) => GetWorkoutList.fromJson(json.decode(str));

String getWorkoutListToJson(GetWorkoutList data) => json.encode(data.toJson());

class GetWorkoutList {
  int? status;
  String? message;
  Result? result;

  GetWorkoutList({
    this.status,
    this.message,
    this.result,
  });

  factory GetWorkoutList.fromJson(Map<String, dynamic> json) => GetWorkoutList(
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result!.toJson(),
      };
}

class Result {
  List<Workout> workouts;

  Result({
    required this.workouts,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        workouts: List<Workout>.from(json["workouts"].map((x) => Workout.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "workouts": List<dynamic>.from(workouts.map((x) => x.toJson())),
      };
}

class Workout {
  String id;
  String traineeId;
  String trainerId;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  String workoutType;
  String createdBy;
  String type;
  var isSelected = false.obs;

  Workout({
    required this.id,
    required this.traineeId,
    required this.trainerId,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.workoutType,
    required this.createdBy,
    required this.type,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json["id"],
        traineeId: json["traineeId"],
        trainerId: json["trainerId"],
        name: json["name"],
        description: json["description"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        workoutType: json["workoutType"],
        createdBy: json["createdBy"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "traineeId": traineeId,
        "trainerId": trainerId,
        "name": name,
        "description": description,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "workoutType": workoutType,
        "createdBy": createdBy,
        "type": type,
      };
}
