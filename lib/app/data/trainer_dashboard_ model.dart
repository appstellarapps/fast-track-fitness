// To parse this JSON data, do
//
//     final trainerDashboardModel = trainerDashboardModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

TrainerDashboardModel trainerDashboardModelFromJson(String str) =>
    TrainerDashboardModel.fromJson(json.decode(str));

String trainerDashboardModelToJson(TrainerDashboardModel data) => json.encode(data.toJson());

class TrainerDashboardModel {
  int? status;
  String? message;
  Result? result;

  TrainerDashboardModel({
    this.status,
    this.message,
    this.result,
  });

  factory TrainerDashboardModel.fromJson(Map<String, dynamic> json) => TrainerDashboardModel(
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
  Booking booking;
  Booking exercise;
  Booking nutrition;

  Result({
    required this.booking,
    required this.exercise,
    required this.nutrition,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        booking: Booking.fromJson(json["booking"]),
        exercise: Booking.fromJson(json["exercise"]),
        nutrition: Booking.fromJson(json["nutrition"]),
      );

  Map<String, dynamic> toJson() => {
        "booking": booking.toJson(),
        "exercise": exercise.toJson(),
        "nutrition": nutrition.toJson(),
      };
}

class Booking {
  int traineeCount;
  RxInt todayScheduledCount = 0.obs;

  Booking({
    required this.traineeCount,
    required this.todayScheduledCount,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        traineeCount: json["traineeCount"],
        todayScheduledCount: int.parse(json["todayScheduledCount"].toString()).obs,
      );

  Map<String, dynamic> toJson() => {
        "traineeCount": traineeCount,
        "todayScheduledCount": todayScheduledCount,
      };
}
