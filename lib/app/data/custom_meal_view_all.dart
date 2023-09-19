// To parse this JSON data, do
//
//     final customMealViewAll = customMealViewAllFromJson(jsonString);

import 'dart:convert';

import 'package:fasttrackfitness/app/data/custom_meal_model.dart';

CustomMealViewAll customMealViewAllFromJson(String str) => CustomMealViewAll.fromJson(json.decode(str));

String customMealViewAllToJson(CustomMealViewAll data) => json.encode(data.toJson());

class CustomMealViewAll {
  int status;
  String message;
  Result result;

  CustomMealViewAll({
    required this.status,
    required this.message,
    required this.result,
  });

  factory CustomMealViewAll.fromJson(Map<String, dynamic> json) => CustomMealViewAll(
    status: json["status"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  List<CustomMeals> data;
  int hasMoreResults;
  String mainCategoryTitle;

  Result({
    required this.data,
    required this.hasMoreResults,
    required this.mainCategoryTitle,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    data: List<CustomMeals>.from(json["data"].map((x) => CustomMeals.fromJson(x))),
    hasMoreResults: json["hasMoreResults"],
    mainCategoryTitle: json["mainCategoryTitle"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "hasMoreResults": hasMoreResults,
    "mainCategoryTitle": mainCategoryTitle,
  };
}

