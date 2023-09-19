// To parse this JSON data, do
//
//     final exerciseDetailsModel = exerciseDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

ExerciseDetailsModel exerciseDetailsModelFromJson(String str) =>
    ExerciseDetailsModel.fromJson(json.decode(str));

String exerciseDetailsModelToJson(ExerciseDetailsModel data) => json.encode(data.toJson());

class ExerciseDetailsModel {
  int? status;
  String? message;
  Result? result;

  ExerciseDetailsModel({
    this.status,
    this.message,
    this.result,
  });

  factory ExerciseDetailsModel.fromJson(Map<String, dynamic> json) => ExerciseDetailsModel(
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
  List<Excercise> excercises;
  Category category;
  int hasMoreResults;

  Result({
    required this.excercises,
    required this.category,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        excercises: List<Excercise>.from(json["excercises"].map((x) => Excercise.fromJson(x))),
        category: json["category"] != ""
            ? Category.fromJson(json["category"])
            : Category(
                id: '',
                title: '',
                description: '',
                imageUrl: '',
              ),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "excercises": List<dynamic>.from(excercises.map((x) => x.toJson())),
        "category": category.toJson(),
        "hasMoreResults": hasMoreResults,
      };
}

class Category {
  String id;
  String title;
  String description;
  String imageUrl;

  Category({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
      };
}

class Excercise {
  String id;
  String categoryId;
  String title;
  String image;
  String video;
  String videoUrl;
  String imageUrl;
  String description;
  String duration;
  String restTimeMinutes;
  List<ResourceExerciseSet> resourceExerciseSets;
  var isSelected = false.obs;

  Excercise({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.image,
    required this.video,
    required this.videoUrl,
    required this.imageUrl,
    required this.description,
    required this.duration,
    required this.restTimeMinutes,
    required this.resourceExerciseSets,
    required this.isSelected,
  });

  factory Excercise.fromJson(Map<String, dynamic> json) => Excercise(
      id: json["id"],
      categoryId: json["categoryId"],
      title: json["title"],
      image: json["image"],
      video: json["video"],
      videoUrl: json["videoUrl"],
      imageUrl: json["imageUrl"],
      description: json["description"],
      duration: json["duration"],
      restTimeMinutes: json["restTimeMinutes"],
      resourceExerciseSets: List<ResourceExerciseSet>.from(
          json["resourceExerciseSets"].map((x) => ResourceExerciseSet.fromJson(x))),
      isSelected: false.obs);

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "title": title,
        "image": image,
        "video": video,
        "videoUrl": videoUrl,
        "imageUrl": imageUrl,
        "description": description,
        "duration": duration,
        "restTimeMinutes": restTimeMinutes,
        "resourceExerciseSets": List<dynamic>.from(resourceExerciseSets.map((x) => x.toJson())),
      };
}

class ResourceExerciseSet {
  String id;
  String resourceLibraryId;
  int sets;
  int reps;
  int weight;
  TextEditingController repsControllers = TextEditingController();
  TextEditingController weightControllers = TextEditingController();

  ResourceExerciseSet({
    required this.id,
    required this.resourceLibraryId,
    required this.sets,
    required this.reps,
    required this.weight,
  });

  factory ResourceExerciseSet.fromJson(Map<String, dynamic> json) => ResourceExerciseSet(
        id: json["id"],
        resourceLibraryId: json["resourceLibraryId"],
        sets: json["sets"],
        reps: json["reps"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resourceLibraryId": resourceLibraryId,
        "sets": sets,
        "reps": reps,
        "weight": weight,
      };
}
