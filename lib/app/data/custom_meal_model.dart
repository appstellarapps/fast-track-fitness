// To parse this JSON data, do
//
//     final customMealModel = customMealModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

CustomMealModel customMealModelFromJson(String str) => CustomMealModel.fromJson(json.decode(str));

String customMealModelToJson(CustomMealModel data) => json.encode(data.toJson());

class CustomMealModel {
  int? status;
  String? message;
  Result? result;

  CustomMealModel({
    this.status,
    this.message,
    this.result,
  });

  factory CustomMealModel.fromJson(Map<String, dynamic> json) => CustomMealModel(
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
  List<CustomMeal> data;
  int hasMoreResults;

  Result({
    required this.data,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<CustomMeal>.from(json["data"].map((x) => CustomMeal.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class CustomMeal {
  String? id;
  String? title;
  int? resourceCustomMealsCount;
  List<CustomMeals>? resourceCustomMeals;

  CustomMeal({
    this.id,
    this.title,
    this.resourceCustomMealsCount,
    this.resourceCustomMeals,
  });

  factory CustomMeal.fromJson(Map<String, dynamic> json) => CustomMeal(
        id: json["id"],
        title: json["title"],
    resourceCustomMealsCount: json["resourceCustomMealsCount"],
        resourceCustomMeals:
            List<CustomMeals>.from(json["resourceCustomMeals"].map((x) => CustomMeals.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "resourceCustomMealsCount": resourceCustomMealsCount,
        "resourceCustomMeals": List<dynamic>.from(resourceCustomMeals!.map((x) => x.toJson())),
      };
}

class CustomMeals {
  String? id;
  String? resourceLibraryId;
  String? categoryId;
  String? type;
  String? foodName;
  int? weight;
  int? calories;
  int? protein;
  int? carbs;
  int? fat;
  String? image;
  var isSelected = false.obs;
  var isShow = false.obs;

  CustomMeals({
    this.id,
    this.resourceLibraryId,
    this.categoryId,
    this.type,
    this.foodName,
    this.weight,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.image,
  });

  factory CustomMeals.fromJson(Map<String, dynamic> json) => CustomMeals(
        id: json["id"],
        resourceLibraryId: json["resourceLibraryId"],
        categoryId: json["categoryId"],
        type: json["type"],
        foodName: json["foodName"],
        weight: json["weight"],
        calories: json["calories"],
        protein: json["protein"],
        carbs: json["carbs"],
        fat: json["fat"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resourceLibraryId": resourceLibraryId,
        "categoryId": categoryId,
        "type": type,
        "foodName": foodName,
        "weight": weight,
        "calories": calories,
        "protein": protein,
        "carbs": carbs,
        "fat": fat,
        "image": image,
      };
}
