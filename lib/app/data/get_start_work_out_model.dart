// To parse this JSON data, do
//
//     final getStartWorkOutModel = getStartWorkOutModelFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

GetStartWorkOutModel getStartWorkOutModelFromJson(String str) =>
    GetStartWorkOutModel.fromJson(json.decode(str));

String getStartWorkOutModelToJson(GetStartWorkOutModel data) => json.encode(data.toJson());

class GetStartWorkOutModel {
  int? status;
  String? message;
  Result? result;

  GetStartWorkOutModel({
    this.status,
    this.message,
    this.result,
  });

  factory GetStartWorkOutModel.fromJson(Map<String, dynamic> json) => GetStartWorkOutModel(
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
  int hasMoreResults;

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
  String name;
  String type;
  List<WorkoutExcerciseDaily> workoutExcerciseDaily;

  Workout({
    required this.id,
    required this.name,
    required this.type,
    required this.workoutExcerciseDaily,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        workoutExcerciseDaily: List<WorkoutExcerciseDaily>.from(
            json["workoutExcerciseDaily"].map((x) => WorkoutExcerciseDaily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "workoutExcerciseDaily": List<dynamic>.from(workoutExcerciseDaily.map((x) => x.toJson())),
      };
}

class WorkoutExcerciseDaily {
  String id;
  String resourceLibraryId;
  String workoutId;
  String title;
  String description;
  String videoUrl;
  String imageUrl;
  String restTimeMinutes;
  List<WorkoutExcerciseSetsDaily> workoutExcerciseSetsDaily;

  WorkoutExcerciseDaily({
    required this.id,
    required this.resourceLibraryId,
    required this.workoutId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.imageUrl,
    required this.restTimeMinutes,
    required this.workoutExcerciseSetsDaily,
  });

  factory WorkoutExcerciseDaily.fromJson(Map<String, dynamic> json) => WorkoutExcerciseDaily(
        id: json["id"],
        resourceLibraryId: json["resourceLibraryId"],
        workoutId: json["workoutId"],
        title: json["title"],
        description: json["description"],
        videoUrl: json["videoUrl"],
        imageUrl: json["imageUrl"],
        restTimeMinutes: json["restTimeMinutes"],
        workoutExcerciseSetsDaily: List<WorkoutExcerciseSetsDaily>.from(
            json["workoutExcerciseSetsDaily"].map((x) => WorkoutExcerciseSetsDaily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resourceLibraryId": resourceLibraryId,
        "workoutId": workoutId,
        "title": title,
        "description": description,
        "videoUrl": videoUrl,
        "imageUrl": imageUrl,
        "restTimeMinutes": restTimeMinutes,
        "workoutExcerciseSetsDaily":
            List<dynamic>.from(workoutExcerciseSetsDaily.map((x) => x.toJson())),
      };
}

class WorkoutExcerciseSetsDaily {
  String id;
  String workoutExcerciseId;
  int reps;
  int weight;
  RxInt isCompleted;
  RxString workingFlag;
  RxString workoutTimeFormat;
  Timer? timer;
  RxInt localSecond = 0.obs;
  var startTime;
  var isStarted = false.obs;

  WorkoutExcerciseSetsDaily(
      {required this.id,
      required this.workoutExcerciseId,
      required this.reps,
      required this.weight,
      required this.isCompleted,
      required this.workingFlag,
      required this.workoutTimeFormat,
      required this.startTime});

  factory WorkoutExcerciseSetsDaily.fromJson(Map<String, dynamic> json) =>
      WorkoutExcerciseSetsDaily(
          id: json["id"],
          workoutExcerciseId: json["workoutExcerciseId"],
          reps: json["reps"],
          weight: json["weight"],
          isCompleted: int.parse(json["isCompleted"].toString()).obs,
          workingFlag: json["workingFlag"].toString().obs!,
          workoutTimeFormat: json["workoutTimeFormat"].toString().obs!,
          startTime: json['startTime']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutExcerciseId": workoutExcerciseId,
        "reps": reps,
        "weight": weight,
        "isCompleted": isCompleted,
        "workingFlag": workingFlag,
        "workoutTimeFormat": workoutTimeFormat,
        "startTime": startTime
      };

  int get totalSeconds {
    List<String> timeParts = workoutTimeFormat.split(':');
    int minutes = int.parse(timeParts[0]);
    int seconds = int.parse(timeParts[1]);
    return minutes * 60 + seconds;
  }
}
