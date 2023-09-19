// To parse this JSON data, do
//
//     final allExerciseModel = allExerciseModelFromJson(jsonString);

import 'dart:convert';

AllExerciseModel allExerciseModelFromJson(String str) =>
    AllExerciseModel.fromJson(json.decode(str));

String allExerciseModelToJson(AllExerciseModel data) => json.encode(data.toJson());

class AllExerciseModel {
  int? status;
  String? message;
  Result? result;

  AllExerciseModel({
    this.status,
    this.message,
    this.result,
  });

  factory AllExerciseModel.fromJson(Map<String, dynamic> json) => AllExerciseModel(
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
  List<AllExercise> data;
  int hasMoreResults;
  String mainCategoryTitle;

  Result({
    required this.data,
    required this.hasMoreResults,
    required this.mainCategoryTitle,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<AllExercise>.from(json["data"].map((x) => AllExercise.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
    mainCategoryTitle: json["mainCategoryTitle"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
        "mainCategoryTitle": mainCategoryTitle,
      };
}

class AllExercise {
  String id;
  String title;
  String image;
  String imageUrl;
  int exerciseCount;
  String totalResourcesDuration;

  AllExercise({
    required this.id,
    required this.title,
    required this.image,
    required this.imageUrl,
    required this.exerciseCount,
    required this.totalResourcesDuration,
  });

  factory AllExercise.fromJson(Map<String, dynamic> json) => AllExercise(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imageUrl: json["imageUrl"],
        exerciseCount: json["exerciseCount"],
        totalResourcesDuration: json["totalResourcesDuration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imageUrl": imageUrl,
        "exerciseCount": exerciseCount,
        "totalResourcesDuration": totalResourcesDuration,
      };
}
