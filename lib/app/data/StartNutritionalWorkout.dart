// To parse this JSON data, do
//
//     final startNutritionalWorkout = startNutritionalWorkoutFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/helper/common_widget/custom_textformfield.dart';

StartNutritionalWorkout startNutritionalWorkoutFromJson(String str) =>
    StartNutritionalWorkout.fromJson(json.decode(str));

String startNutritionalWorkoutToJson(StartNutritionalWorkout data) => json.encode(data.toJson());

class StartNutritionalWorkout {
  int? status;
  String? message;
  Result? result;

  StartNutritionalWorkout({
    this.status,
    this.message,
    this.result,
  });

  factory StartNutritionalWorkout.fromJson(Map<String, dynamic> json) => StartNutritionalWorkout(
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
  List<Workout> workouts;
  int hasMoreResults;

  Result({
    required this.workouts,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        workouts: List<Workout>.from(json["workouts"].map((x) => Workout.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "workouts": List<dynamic>.from(workouts.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class Workout {
  String id;
  String name;
  String type;
  List<WorkoutNutritionalDaily> workoutNutritionalDaily;

  Workout({
    required this.id,
    required this.name,
    required this.type,
    required this.workoutNutritionalDaily,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        workoutNutritionalDaily: List<WorkoutNutritionalDaily>.from(
            json["workoutNutritionalDaily"].map((x) => WorkoutNutritionalDaily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "workoutNutritionalDaily":
            List<dynamic>.from(workoutNutritionalDaily.map((x) => x.toJson())),
      };
}

class WorkoutNutritionalDaily {
  String id;
  String workoutId;
  String name;
  List<WorkoutNutritionalMealDaily> workoutNutritionalMealDaily;

  WorkoutNutritionalDaily({
    required this.id,
    required this.workoutId,
    required this.name,
    required this.workoutNutritionalMealDaily,
  });

  factory WorkoutNutritionalDaily.fromJson(Map<String, dynamic> json) => WorkoutNutritionalDaily(
        id: json["id"],
        workoutId: json["workoutId"],
        name: json["name"],
        workoutNutritionalMealDaily: List<WorkoutNutritionalMealDaily>.from(
            json["workoutNutritionalMealDaily"]
                .map((x) => WorkoutNutritionalMealDaily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutId": workoutId,
        "name": name,
        "workoutNutritionalMealDaily":
            List<dynamic>.from(workoutNutritionalMealDaily.map((x) => x.toJson())),
      };
}

class WorkoutNutritionalMealDaily {
  String id;
  DateTime workoutDate;
  String workoutNutritionalsId;
  String resourceMealsId;
  String foodName;
  RxInt weight;
  RxInt calories;
  RxInt protein;
  RxInt carbs;
  RxInt fat;
  String image;
  var isShow = false.obs;
  TextEditingController controller = TextEditingController();
  GlobalKey<CustomTextFormFieldState> key = GlobalKey<CustomTextFormFieldState>();
  Rx<FocusNode> focusNode = FocusNode().obs;
  var isSelected = false.obs;

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
  });

  factory WorkoutNutritionalMealDaily.fromJson(Map<String, dynamic> json) =>
      WorkoutNutritionalMealDaily(
        id: json["id"],
        workoutDate: DateTime.parse(json["workoutDate"]),
        workoutNutritionalsId: json["workoutNutritionalsId"],
        resourceMealsId: json["resourceMealsId"],
        foodName: json["foodName"],
        weight: int.parse(json["weight"].toString()).obs,
        calories: int.parse(json["calories"].toString()).obs,
        protein: int.parse(json["protein"].toString()).obs,
        carbs: int.parse(json["carbs"].toString()).obs,
        fat: int.parse(json["fat"].toString()).obs,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutDate":
            "${workoutDate.year.toString().padLeft(4, '0')}-${workoutDate.month.toString().padLeft(2, '0')}-${workoutDate.day.toString().padLeft(2, '0')}",
        "workoutNutritionalsId": workoutNutritionalsId,
        "resourceMealsId": resourceMealsId,
        "foodName": foodName,
        "weight": weight,
        "calories": calories,
        "protein": protein,
        "carbs": carbs,
        "fat": fat,
        "image": image,
      };
}
