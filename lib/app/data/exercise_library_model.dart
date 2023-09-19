// To parse this JSON data, do
//
//     final exerciseLibraryModel = exerciseLibraryModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ExerciseLibraryModel exerciseLibraryModelFromJson(String str) =>
    ExerciseLibraryModel.fromJson(json.decode(str));

String exerciseLibraryModelToJson(ExerciseLibraryModel data) => json.encode(data.toJson());

class ExerciseLibraryModel {
  int? status;
  String? message;
  Result? result;

  ExerciseLibraryModel({
    this.status,
    this.message,
    this.result,
  });

  factory ExerciseLibraryModel.fromJson(Map<String, dynamic> json) => ExerciseLibraryModel(
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
  List<Exercise> data;
  int hasMoreResults;

  Result({
    required this.data,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<Exercise>.from(json["data"].map((x) => Exercise.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class Exercise {
  String id;
  String title;
  int descendantsCount;
  List<SubExercise> descendants;

  Exercise({
    required this.id,
    required this.title,
    required this.descendantsCount,
    required this.descendants,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        title: json["title"],
    descendantsCount: json["descendantsCount"],
        descendants:
            List<SubExercise>.from(json["descendants"].map((x) => SubExercise.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "descendantsCount": descendantsCount,
        "descendants": List<dynamic>.from(descendants.map((x) => x.toJson())),
      };
}

class SubExercise {
  String id;
  String parentCategoryId;
  String type;
  String title;
  String image;
  String imageUrl;
  int exerciseCount;
  String totalResourcesDuration;
  var isSelected = false.obs;

  SubExercise({
    required this.id,
    required this.parentCategoryId,
    required this.type,
    required this.title,
    required this.image,
    required this.imageUrl,
    required this.exerciseCount,
    required this.totalResourcesDuration,
  });

  factory SubExercise.fromJson(Map<String, dynamic> json) => SubExercise(
        id: json["id"],
        parentCategoryId: json["parentCategoryId"],
        type: json["type"],
        title: json["title"],
        image: json["image"],
        imageUrl: json["imageUrl"],
        exerciseCount: json["exerciseCount"],
        totalResourcesDuration: json["totalResourcesDuration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentCategoryId": parentCategoryId,
        "type": type,
        "title": title,
        "image": image,
        "imageUrl": imageUrl,
        "exerciseCount": exerciseCount,
        "totalResourcesDuration": totalResourcesDuration,
      };
}
