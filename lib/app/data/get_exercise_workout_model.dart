// To parse this JSON data, do
//
//     final getExerciseModel = getExerciseModelFromJson(jsonString);

import 'dart:convert';

GetExerciseModel getExerciseModelFromJson(String str) =>
    GetExerciseModel.fromJson(json.decode(str));

String getExerciseModelToJson(GetExerciseModel data) => json.encode(data.toJson());

class GetExerciseModel {
  dynamic? status;
  String? message;
  Result? result;

  GetExerciseModel({
    this.status,
    this.message,
    this.result,
  });

  factory GetExerciseModel.fromJson(Map<String, dynamic> json) => GetExerciseModel(
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
  dynamic hasMoreResults;

  Result({
    required this.workouts,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        workouts: List<Workout>.from(json["workouts"].map((x) => Workout.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "workouts": List<dynamic>.from(workouts.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class Workout {
  String id;
  DateTime workoutDate;
  String mainWorkoutId;
  String traineeId;
  String trainerId;
  String name;
  String description;
  String trainingTypeId;
  DateTime startDate;
  DateTime endDate;
  String workoutType;
  dynamic price;
  String validity;
  dynamic validateDays;
  String createdBy;
  dynamic isActive;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  dynamic workoutExcerciseDailyCount;
  dynamic isExcerWorkoutStart;
  dynamic isNutriWorkoutStart;
  dynamic workoutNutritionalDailyCount;

  Workout({
    required this.id,
    required this.workoutDate,
    required this.mainWorkoutId,
    required this.traineeId,
    required this.trainerId,
    required this.name,
    required this.description,
    required this.trainingTypeId,
    required this.startDate,
    required this.endDate,
    required this.workoutType,
    required this.price,
    required this.validity,
    required this.validateDays,
    required this.createdBy,
    required this.isActive,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.workoutExcerciseDailyCount,
    required this.isExcerWorkoutStart,
    required this.isNutriWorkoutStart,
    required this.workoutNutritionalDailyCount,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json["id"],
        workoutDate: DateTime.parse(json["workoutDate"]),
        mainWorkoutId: json["mainWorkoutId"],
        traineeId: json["traineeId"],
        trainerId: json["trainerId"],
        name: json["name"],
        description: json["description"],
        trainingTypeId: json["trainingTypeId"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        workoutType: json["workoutType"],
        price: json["price"],
        validity: json["validity"],
        validateDays: json["validateDays"],
        createdBy: json["createdBy"],
        isActive: json["isActive"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        workoutExcerciseDailyCount: json["workoutExcerciseDailyCount"] ?? 0,
        isExcerWorkoutStart: json["isExcerWorkoutStart"] ?? 0,
        isNutriWorkoutStart: json["isNutriWorkoutStart"] ?? 0,
        workoutNutritionalDailyCount: json["workoutNutritionalDailyCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutDate":
            "${workoutDate.year.toString().padLeft(4, '0')}-${workoutDate.month.toString().padLeft(2, '0')}-${workoutDate.day.toString().padLeft(2, '0')}",
        "mainWorkoutId": mainWorkoutId,
        "traineeId": traineeId,
        "trainerId": trainerId,
        "name": name,
        "description": description,
        "trainingTypeId": trainingTypeId,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "workoutType": workoutType,
        "price": price,
        "validity": validity,
        "validateDays": validateDays,
        "createdBy": createdBy,
        "isActive": isActive,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "workoutExcerciseDailyCount": workoutExcerciseDailyCount,
        "isExcerWorkoutStart": isExcerWorkoutStart,
        "isNutriWorkoutStart": isNutriWorkoutStart,
        "workoutNutritionalDailyCount": workoutNutritionalDailyCount
      };
}
