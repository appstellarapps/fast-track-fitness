// To parse this JSON data, do
//
//     final preMadeMealDetails = preMadeMealDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

PreMadeMealDetails preMadeMealDetailsFromJson(String str) =>
    PreMadeMealDetails.fromJson(json.decode(str));

String preMadeMealDetailsToJson(PreMadeMealDetails data) => json.encode(data.toJson());

class PreMadeMealDetails {
  int? status;
  String? message;
  PreMadeResult? result;

  PreMadeMealDetails({
    this.status,
    this.message,
    this.result,
  });

  factory PreMadeMealDetails.fromJson(Map<String, dynamic> json) => PreMadeMealDetails(
        status: json["status"],
        message: json["message"],
        result: PreMadeResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result!.toJson(),
      };
}

class PreMadeResult {
  String id;
  String title;
  String description;
  String imageUrl;
  List<GetResourcesNutrition> getResourcesNutrition;

  PreMadeResult({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.getResourcesNutrition,
  });

  factory PreMadeResult.fromJson(Map<String, dynamic> json) => PreMadeResult(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        getResourcesNutrition: List<GetResourcesNutrition>.from(
            json["getResourcesNutrition"].map((x) => GetResourcesNutrition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "getResourcesNutrition": List<dynamic>.from(getResourcesNutrition.map((x) => x.toJson())),
      };
}

class GetResourcesNutrition {
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
  List<ResourcePreMadeMeal> resourcePreMadeMeals;

  GetResourcesNutrition({
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
    required this.resourcePreMadeMeals,
  });

  factory GetResourcesNutrition.fromJson(Map<String, dynamic> json) => GetResourcesNutrition(
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
        resourcePreMadeMeals: List<ResourcePreMadeMeal>.from(
            json["resourcePreMadeMeals"].map((x) => ResourcePreMadeMeal.fromJson(x))),
      );

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
        "resourcePreMadeMeals": List<dynamic>.from(resourcePreMadeMeals.map((x) => x.toJson())),
      };
}

class ResourcePreMadeMeal {
  String id;
  String resourceLibraryId;
  String categoryId;
  String type;
  String foodName;
  int weight;
  int calories;
  int protein;
  int carbs;
  int fat;
  String image;
  var isShow = false.obs;

  ResourcePreMadeMeal({
    required this.id,
    required this.resourceLibraryId,
    required this.categoryId,
    required this.type,
    required this.foodName,
    required this.weight,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.image,
  });

  factory ResourcePreMadeMeal.fromJson(Map<String, dynamic> json) => ResourcePreMadeMeal(
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
