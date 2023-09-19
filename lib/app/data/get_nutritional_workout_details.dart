// To parse this JSON data, do
//
//     final getWorkouCustomtNutritionalDetails = getWorkouCustomtNutritionalDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetWorkouCustomtNutritionalDetails getWorkouCustomtNutritionalDetailsFromJson(String str) =>
    GetWorkouCustomtNutritionalDetails.fromJson(json.decode(str));

String getWorkouCustomtNutritionalDetailsToJson(GetWorkouCustomtNutritionalDetails data) =>
    json.encode(data.toJson());

class GetWorkouCustomtNutritionalDetails {
  int status;
  String message;
  Result result;

  GetWorkouCustomtNutritionalDetails({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetWorkouCustomtNutritionalDetails.fromJson(Map<String, dynamic> json) =>
      GetWorkouCustomtNutritionalDetails(
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
  List<WorkoutDetail> workoutDetails;
  Workout workout;
  int hasMoreResults;

  Result({
    required this.workoutDetails,
    required this.workout,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        workoutDetails:
            List<WorkoutDetail>.from(json["workoutDetails"].map((x) => WorkoutDetail.fromJson(x))),
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

class WorkoutDetail {
  String id;
  String workoutDate;
  String workoutId;
  String name;
  List<WorkoutNutritionalMealDaily> workoutNutritionalMealDaily;
  var categoryId;

  WorkoutDetail(
      {required this.id,
      required this.workoutDate,
      required this.workoutId,
      required this.name,
      required this.workoutNutritionalMealDaily,
      required this.categoryId});

  factory WorkoutDetail.fromJson(Map<String, dynamic> json) => WorkoutDetail(
      id: json["id"],
      workoutDate: json["workoutDate"],
      workoutId: json["workoutId"],
      name: json["name"],
      workoutNutritionalMealDaily: List<WorkoutNutritionalMealDaily>.from(
          json["workoutNutritionalMealDaily"].map((x) => WorkoutNutritionalMealDaily.fromJson(x))),
      categoryId: json['categoryId'] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutDate": workoutDate,
        "workoutId": workoutId,
        "name": name,
        "workoutNutritionalMealDaily":
            List<dynamic>.from(workoutNutritionalMealDaily.map((x) => x.toJson())),
        "categoryId": categoryId
      };
}

class WorkoutNutritionalMealDaily {
  String id;
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

  WorkoutNutritionalMealDaily({
    required this.id,
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

  factory WorkoutNutritionalMealDaily.fromJson(Map<String, dynamic> json) =>
      WorkoutNutritionalMealDaily(
        id: json["id"],
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
