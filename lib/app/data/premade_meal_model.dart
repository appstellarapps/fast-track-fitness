// To parse this JSON data, do
//
//     final preMadeMealModel = preMadeMealModelFromJson(jsonString);

import 'dart:convert';

PreMadeMealModel preMadeMealModelFromJson(String str) =>
    PreMadeMealModel.fromJson(json.decode(str));

String preMadeMealModelToJson(PreMadeMealModel data) => json.encode(data.toJson());

class PreMadeMealModel {
  int? status;
  String? message;
  Result? result;

  PreMadeMealModel({
    this.status,
    this.message,
    this.result,
  });

  factory PreMadeMealModel.fromJson(Map<String, dynamic> json) => PreMadeMealModel(
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
  List<PreMadeMeal> data;
  int hasMoreResults;

  Result({
    required this.data,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<PreMadeMeal>.from(json["data"].map((x) => PreMadeMeal.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class PreMadeMeal {
  String id;
  String title;
  int descendantsCount;
  List<Descendant> descendants;

  PreMadeMeal({
    required this.id,
    required this.title,
    required this.descendantsCount,
    required this.descendants,
  });

  factory PreMadeMeal.fromJson(Map<String, dynamic> json) => PreMadeMeal(
        id: json["id"],
        title: json["title"],
    descendantsCount: json["descendantsCount"],
        descendants: List<Descendant>.from(json["descendants"].map((x) => Descendant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "descendantsCount": descendantsCount,
        "descendants": List<dynamic>.from(descendants.map((x) => x.toJson())),
      };
}

class Descendant {
  String id;
  String parentCategoryId;
  String type;
  String title;
  String image;
  String imageUrl;
  int exerciseCount;
  String totalResourcesDuration;

  Descendant({
    required this.id,
    required this.parentCategoryId,
    required this.type,
    required this.title,
    required this.image,
    required this.imageUrl,
    required this.exerciseCount,
    required this.totalResourcesDuration,
  });

  factory Descendant.fromJson(Map<String, dynamic> json) => Descendant(
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
