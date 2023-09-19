// To parse this JSON data, do
//
//     final nutritionalStatsModel = nutritionalStatsModelFromJson(jsonString);

import 'dart:convert';

NutritionalStatsModel nutritionalStatsModelFromJson(String str) =>
    NutritionalStatsModel.fromJson(json.decode(str));

String nutritionalStatsModelToJson(NutritionalStatsModel data) => json.encode(data.toJson());

class NutritionalStatsModel {
  int? status;
  String? message;
  Result? result;

  NutritionalStatsModel({
    this.status,
    this.message,
    this.result,
  });

  factory NutritionalStatsModel.fromJson(Map<String, dynamic> json) => NutritionalStatsModel(
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
  int consumedCalories;
  int totalCalories;
  int caloriesRemaining;
  int isUserTdee;
  List<ChartDetail> chartDetails;

  Result({
    required this.consumedCalories,
    required this.totalCalories,
    required this.caloriesRemaining,
    required this.isUserTdee,
    required this.chartDetails,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        consumedCalories: json["consumedCalories"],
        totalCalories: json["totalCalories"],
        caloriesRemaining: json["caloriesRemaining"],
        isUserTdee: json["isUserTdee"],
        chartDetails:
            List<ChartDetail>.from(json["chartDetails"].map((x) => ChartDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "consumedCalories": consumedCalories,
        "totalCalories": totalCalories,
        "caloriesRemaining": caloriesRemaining,
        "isUserTdee": isUserTdee,
        "chartDetails": List<dynamic>.from(chartDetails.map((x) => x.toJson())),
      };
}

class ChartDetail {
  String category;
  int consumed;
  int total;
  String consumedColour;
  String totalColour;

  ChartDetail({
    required this.category,
    required this.consumed,
    required this.total,
    required this.consumedColour,
    required this.totalColour,
  });

  factory ChartDetail.fromJson(Map<String, dynamic> json) => ChartDetail(
        category: json["category"],
        consumed: json["consumed"],
        total: json["total"],
        consumedColour: json["consumedColour"],
        totalColour: json["totalColour"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "consumed": consumed,
        "total": total,
        "consumedColour": consumedColour,
        "totalColour": totalColour,
      };
}
