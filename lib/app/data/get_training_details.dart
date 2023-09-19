// To parse this JSON data, do
//
//     final getTraningDetailsModel = getTraningDetailsModelFromJson(jsonString);

import 'dart:convert';

GetTraningDetailsModel getTraningDetailsModelFromJson(String str) =>
    GetTraningDetailsModel.fromJson(json.decode(str));

String getTraningDetailsModelToJson(GetTraningDetailsModel data) => json.encode(data.toJson());

class GetTraningDetailsModel {
  dynamic? status;
  String? message;
  Result? result;

  GetTraningDetailsModel({
    this.status,
    this.message,
    this.result,
  });

  factory GetTraningDetailsModel.fromJson(Map<String, dynamic> json) => GetTraningDetailsModel(
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
  List<TrainingType> trainingTypes;
  List<TrainingMode> trainingModes;

  Result({
    required this.trainingTypes,
    required this.trainingModes,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        trainingTypes:
            List<TrainingType>.from(json["trainingTypes"].map((x) => TrainingType.fromJson(x))),
        trainingModes:
            List<TrainingMode>.from(json["trainingModes"].map((x) => TrainingMode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trainingTypes": List<dynamic>.from(trainingTypes.map((x) => x.toJson())),
        "trainingModes": List<dynamic>.from(trainingModes.map((x) => x.toJson())),
      };
}

class TrainingMode {
  String id;
  String userId;
  String trainingModesId;
  String title;

  TrainingMode({
    required this.id,
    required this.userId,
    required this.trainingModesId,
    required this.title,
  });

  factory TrainingMode.fromJson(Map<String, dynamic> json) => TrainingMode(
        id: json["id"],
        userId: json["userId"],
        trainingModesId: json["trainingModesId"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trainingModesId": trainingModesId,
        "title": title,
      };
}

class TrainingType {
  String id;
  String userId;
  String trainingTypesId;
  dynamic price;
  String priceOption;
  String title;

  TrainingType({
    required this.id,
    required this.userId,
    required this.trainingTypesId,
    required this.price,
    required this.priceOption,
    required this.title,
  });

  factory TrainingType.fromJson(Map<String, dynamic> json) => TrainingType(
        id: json["id"],
        userId: json["userId"],
        trainingTypesId: json["trainingTypesId"],
        price: json["price"],
        priceOption: json["priceOption"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trainingTypesId": trainingTypesId,
        "price": price,
        "priceOption": priceOption,
        "title": title,
      };
}
