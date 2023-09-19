// To parse this JSON data, do
//
//     final getWorkouPreMadeNutritionalDetails = getWorkouPreMadeNutritionalDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetWorkouPreMadeNutritionalDetails getWorkouPreMadeNutritionalDetailsFromJson(String str) =>
    GetWorkouPreMadeNutritionalDetails.fromJson(json.decode(str));

String getWorkouPreMadeNutritionalDetailsToJson(GetWorkouPreMadeNutritionalDetails data) =>
    json.encode(data.toJson());

class GetWorkouPreMadeNutritionalDetails {
  int? status;
  String? message;
  Result? result;

  GetWorkouPreMadeNutritionalDetails({
    this.status,
    this.message,
    this.result,
  });

  factory GetWorkouPreMadeNutritionalDetails.fromJson(Map<String, dynamic> json) =>
      GetWorkouPreMadeNutritionalDetails(
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
  List<PreMadeWorkoutDetails> workoutDetails;
  Workout workout;
  int hasMoreResults;

  Result({
    required this.workoutDetails,
    required this.workout,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        workoutDetails: List<PreMadeWorkoutDetails>.from(
            json["workoutDetails"].map((x) => PreMadeWorkoutDetails.fromJson(x))),
        workout: Workout.fromJson(json["workout"]),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "workoutDetails": List<dynamic>.from(workoutDetails.map((x) => x.toJson())),
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
  String startDate;
  String endDate;

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
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "trainingTypeId": trainingTypeId,
        "trainingTypeTitle": trainingTypeTitle,
        "workoutType": workoutType,
        "createdBy": createdBy,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
      };
}

class PreMadeWorkoutDetails {
  String id;
  DateTime workoutDate;
  String workoutId;
  String categoryId;
  String title;
  String description;
  String imageUrl;
  List<NutritionalResourecLib> nutritionalResourecLib;

  PreMadeWorkoutDetails({
    required this.id,
    required this.workoutDate,
    required this.workoutId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.nutritionalResourecLib,
  });

  factory PreMadeWorkoutDetails.fromJson(Map<String, dynamic> json) => PreMadeWorkoutDetails(
        id: json["id"],
        workoutDate: DateTime.parse(json["workoutDate"]),
        workoutId: json["workoutId"],
        categoryId: json["categoryId"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        nutritionalResourecLib: List<NutritionalResourecLib>.from(
            json["nutritionalResourecLib"].map((x) => NutritionalResourecLib.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutDate":
            "${workoutDate.year.toString().padLeft(4, '0')}-${workoutDate.month.toString().padLeft(2, '0')}-${workoutDate.day.toString().padLeft(2, '0')}",
        "workoutId": workoutId,
        "categoryId": categoryId,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "nutritionalResourecLib": List<dynamic>.from(nutritionalResourecLib.map((x) => x.toJson())),
      };
}

class NutritionalResourecLib {
  String id;
  String categoryId;
  String title;
  List<ResourceMeal> resourceMeal;

  NutritionalResourecLib({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.resourceMeal,
  });

  factory NutritionalResourecLib.fromJson(Map<String, dynamic> json) => NutritionalResourecLib(
        id: json["id"],
        categoryId: json["categoryId"],
        title: json["title"],
        resourceMeal:
            List<ResourceMeal>.from(json["resourceMeal"].map((x) => ResourceMeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "title": title,
        "resourceMeal": List<dynamic>.from(resourceMeal.map((x) => x.toJson())),
      };
}

class ResourceMeal {
  String id;
  String resourceLibraryId;
  String workoutDate;
  String workoutNutritionalsId;
  String resourceMealsId;
  String foodName;
  int weight;
  int calories;
  int protein;
  int carbs;
  int fat;
  String image;
  int defultWeight;
  int defultCalories;
  int defultProtein;
  int defultCarbs;
  int defultFat;
  var isShow = false.obs;

  ResourceMeal({
    required this.id,
    required this.resourceLibraryId,
    required this.workoutDate,
    required this.workoutNutritionalsId,
    required this.resourceMealsId,
    required this.foodName,
    required this.weight,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.image,
    required this.defultWeight,
    required this.defultCalories,
    required this.defultProtein,
    required this.defultCarbs,
    required this.defultFat,
  });

  factory ResourceMeal.fromJson(Map<String, dynamic> json) => ResourceMeal(
        id: json["id"],
        resourceLibraryId: json["resourceLibraryId"],
        workoutDate: json["workoutDate"],
        workoutNutritionalsId: json["workoutNutritionalsId"],
        resourceMealsId: json["resourceMealsId"],
        foodName: json["foodName"],
        weight: json["weight"],
        calories: json["calories"],
        protein: json["protein"],
        carbs: json["carbs"],
        fat: json["fat"],
        image: json["image"],
        defultWeight: json["defultWeight"],
        defultCalories: json["defultCalories"],
        defultProtein: json["defultProtein"],
        defultCarbs: json["defultCarbs"],
        defultFat: json["defultFat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resourceLibraryId": resourceLibraryId,
        "workoutDate": workoutDate,
        "workoutNutritionalsId": workoutNutritionalsId,
        "resourceMealsId": resourceMealsId,
        "foodName": foodName,
        "weight": weight,
        "calories": calories,
        "protein": protein,
        "carbs": carbs,
        "fat": fat,
        "image": image,
        "defultWeight": defultWeight,
        "defultCalories": defultCalories,
        "defultProtein": defultProtein,
        "defultCarbs": defultCarbs,
        "defultFat": defultFat,
      };
}
