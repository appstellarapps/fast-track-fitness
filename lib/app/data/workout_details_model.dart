// To parse this JSON data, do
//
//     final workoutDetailsModel = workoutDetailsModelFromJson(jsonString);

import 'dart:convert';

WorkoutDetailsModel workoutDetailsModelFromJson(String str) =>
    WorkoutDetailsModel.fromJson(json.decode(str));

String workoutDetailsModelToJson(WorkoutDetailsModel data) => json.encode(data.toJson());

class WorkoutDetailsModel {
  int? status;
  String? message;
  Result? result;

  WorkoutDetailsModel({
    this.status,
    this.message,
    this.result,
  });

  factory WorkoutDetailsModel.fromJson(Map<String, dynamic> json) => WorkoutDetailsModel(
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
  List<WorkoutExerciseDetail> workoutExerciseDetails;
  Workout workout;
  int hasMoreResults;

  Result({
    required this.workoutExerciseDetails,
    required this.workout,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        workoutExerciseDetails: List<WorkoutExerciseDetail>.from(
            json["workoutExerciseDetails"].map((x) => WorkoutExerciseDetail.fromJson(x))),
        workout: Workout.fromJson(json["workout"]),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "workoutExerciseDetails": List<dynamic>.from(workoutExerciseDetails.map((x) => x.toJson())),
        "workout": workout.toJson(),
        "hasMoreResults": hasMoreResults,
      };
}

class Workout {
  String id;
  String name;
  String trainingTypeId;
  String trainingTypeTitle;
  String workoutType;
  String createdBy;
  String description;
  DateTime startDate;
  DateTime endDate;

  Workout({
    required this.id,
    required this.name,
    required this.trainingTypeId,
    required this.trainingTypeTitle,
    required this.workoutType,
    required this.createdBy,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json["id"],
        name: json["name"],
        trainingTypeId: json["trainingTypeId"],
        trainingTypeTitle: json["trainingTypeTitle"],
        workoutType: json["workoutType"],
        createdBy: json["createdBy"],
        description: json["description"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "trainingTypeId": trainingTypeId,
        "trainingTypeTitle": trainingTypeTitle,
        "workoutType": workoutType,
        "createdBy": createdBy,
        "description": description,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}

class WorkoutExerciseDetail {
  String id;
  DateTime workoutDate;
  String workoutId;
  String resourceLibraryId;
  String title;
  String description;
  String restTimeMinutes;
  String videoUrl;
  String imageUrl;
  String categoryId;
  List<WorkoutExcerciseSetsDaily> workoutExcerciseSetsDaily;

  WorkoutExerciseDetail(
      {required this.id,
      required this.workoutDate,
      required this.workoutId,
      required this.resourceLibraryId,
      required this.title,
      required this.description,
      required this.restTimeMinutes,
      required this.videoUrl,
      required this.imageUrl,
      required this.workoutExcerciseSetsDaily,
      required this.categoryId});

  factory WorkoutExerciseDetail.fromJson(Map<String, dynamic> json) => WorkoutExerciseDetail(
        id: json["id"],
        workoutDate: DateTime.parse(json["workoutDate"]),
        workoutId: json["workoutId"],
        resourceLibraryId: json["resourceLibraryId"],
        title: json["title"],
        description: json["description"],
        restTimeMinutes: json["restTimeMinutes"],
        videoUrl: json["videoUrl"],
        imageUrl: json["imageUrl"],
        categoryId: json['categoryId'] ?? '',
        workoutExcerciseSetsDaily: List<WorkoutExcerciseSetsDaily>.from(
            json["workoutExcerciseSetsDaily"].map((x) => WorkoutExcerciseSetsDaily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutDate":
            "${workoutDate.year.toString().padLeft(4, '0')}-${workoutDate.month.toString().padLeft(2, '0')}-${workoutDate.day.toString().padLeft(2, '0')}",
        "workoutId": workoutId,
        "resourceLibraryId": resourceLibraryId,
        "title": title,
        "description": description,
        "restTimeMinutes": restTimeMinutes,
        "videoUrl": videoUrl,
        "imageUrl": imageUrl,
        "workoutExcerciseSetsDaily":
            List<dynamic>.from(workoutExcerciseSetsDaily.map((x) => x.toJson())),
        "categoryId": categoryId
      };
}

class WorkoutExcerciseSetsDaily {
  String id;
  String workoutExcerciseId;
  int reps;
  int weight;
  int workoutSeconds;
  int restSeconds;
  int isCompleted;
  int workoutMinutes;
  String workoutFormat;

  WorkoutExcerciseSetsDaily({
    required this.id,
    required this.workoutExcerciseId,
    required this.reps,
    required this.weight,
    required this.workoutSeconds,
    required this.restSeconds,
    required this.isCompleted,
    required this.workoutMinutes,
    required this.workoutFormat,
  });

  factory WorkoutExcerciseSetsDaily.fromJson(Map<String, dynamic> json) =>
      WorkoutExcerciseSetsDaily(
        id: json["id"],
        workoutExcerciseId: json["workoutExcerciseId"],
        reps: json["reps"],
        weight: json["weight"],
        workoutSeconds: json["workoutSeconds"],
        restSeconds: json["restSeconds"],
        isCompleted: json["isCompleted"],
        workoutMinutes: json["workoutMinutes"],
        workoutFormat: json["workoutFormat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutExcerciseId": workoutExcerciseId,
        "reps": reps,
        "weight": weight,
        "workoutSeconds": workoutSeconds,
        "restSeconds": restSeconds,
        "isCompleted": isCompleted,
        "workoutMinutes": workoutMinutes,
        "workoutFormat": workoutFormat,
      };
}
