// To parse this JSON data, do
//
//     final statsDistanceModel = statsDistanceModelFromJson(jsonString);

import 'dart:convert';

StatsDistanceModel statsDistanceModelFromJson(String str) =>
    StatsDistanceModel.fromJson(json.decode(str));

String statsDistanceModelToJson(StatsDistanceModel data) => json.encode(data.toJson());

class StatsDistanceModel {
  int? status;
  String? message;
  List<DistanceResult>? result;

  StatsDistanceModel({
    this.status,
    this.message,
    this.result,
  });

  factory StatsDistanceModel.fromJson(Map<String, dynamic> json) => StatsDistanceModel(
        status: json["status"],
        message: json["message"],
        result: List<DistanceResult>.from(json["result"].map((x) => DistanceResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class DistanceResult {
  String id;
  String name;
  String displayName;
  String image;
  String bodyColour;
  String nameColour;
  int orderBy;
  String imageUrl;
  List<ExcerciseTypeField> excerciseTypeFields;
  String percentage;
  String chartKms;
  String chartHours;

  DistanceResult(
      {required this.id,
      required this.name,
      required this.displayName,
      required this.image,
      required this.bodyColour,
      required this.nameColour,
      required this.orderBy,
      required this.imageUrl,
      required this.excerciseTypeFields,
      required this.percentage,
      required this.chartKms,
      required this.chartHours});

  factory DistanceResult.fromJson(Map<String, dynamic> json) => DistanceResult(
      id: json["id"],
      name: json["name"],
      displayName: json["displayName"],
      image: json["image"],
      bodyColour: json["bodyColour"],
      nameColour: json["nameColour"],
      orderBy: json["orderBy"],
      imageUrl: json["imageUrl"],
      excerciseTypeFields: List<ExcerciseTypeField>.from(
          json["excerciseTypeFields"].map((x) => ExcerciseTypeField.fromJson(x))),
      percentage: json["percentage"],
      chartKms: json["chartKms"] ?? "",
      chartHours: json['chartHours'] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "displayName": displayName,
        "image": image,
        "bodyColour": bodyColour,
        "nameColour": nameColour,
        "orderBy": orderBy,
        "imageUrl": imageUrl,
        "excerciseTypeFields": List<dynamic>.from(excerciseTypeFields.map((x) => x.toJson())),
        "percentage": percentage,
        "chartKms": chartKms,
        "chartHours": chartHours
      };
}

class ExcerciseTypeField {
  String id;
  String exerciseTypeId;
  String type;

  ExcerciseTypeField({
    required this.id,
    required this.exerciseTypeId,
    required this.type,
  });

  factory ExcerciseTypeField.fromJson(Map<String, dynamic> json) => ExcerciseTypeField(
        id: json["id"],
        exerciseTypeId: json["exerciseTypeId"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "exerciseTypeId": exerciseTypeId,
        "type": type,
      };
}
