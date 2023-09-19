// To parse this JSON data, do
//
//     final myStatsModel = myStatsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../core/helper/common_widget/custom_textformfield.dart';

MyStatsModel myStatsModelFromJson(String str) => MyStatsModel.fromJson(json.decode(str));

String myStatsModelToJson(MyStatsModel data) => json.encode(data.toJson());

class MyStatsModel {
  int? status;
  String? message;
  List<MyStatsResult>? result;

  MyStatsModel({
    this.status,
    this.message,
    this.result,
  });

  factory MyStatsModel.fromJson(Map<String, dynamic> json) => MyStatsModel(
        status: json["status"],
        message: json["message"],
        result: List<MyStatsResult>.from(json["result"].map((x) => MyStatsResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class MyStatsResult {
  String id;
  String name;
  String displayName;
  String image;
  String imageUrl;
  String bodyColour;
  String nameColour;
  int orderBy;
  List<ExcerciseTypeField> excerciseTypeFields;

  MyStatsResult({
    required this.id,
    required this.name,
    required this.displayName,
    required this.image,
    required this.bodyColour,
    required this.nameColour,
    required this.orderBy,
    required this.excerciseTypeFields,
    required this.imageUrl,
  });

  factory MyStatsResult.fromJson(Map<String, dynamic> json) => MyStatsResult(
        id: json["id"],
        name: json["name"],
        displayName: json["displayName"],
        image: json["image"],
        imageUrl: json['imageUrl'],
        bodyColour: json["bodyColour"],
        nameColour: json["nameColour"],
        orderBy: json["orderBy"],
        excerciseTypeFields: List<ExcerciseTypeField>.from(
            json["excerciseTypeFields"].map((x) => ExcerciseTypeField.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "displayName": displayName,
        "image": image,
        "imageUrl": imageUrl,
        "bodyColour": bodyColour,
        "nameColour": nameColour,
        "orderBy": orderBy,
        "excerciseTypeFields": List<dynamic>.from(excerciseTypeFields.map((x) => x.toJson())),
      };
}

class ExcerciseTypeField {
  String id;
  String exerciseTypeId;
  String type;
  dynamic value;
  var stateController = TextEditingController();
  var stateKey = GlobalKey<CustomTextFormFieldState>();

  ExcerciseTypeField({
    required this.id,
    required this.exerciseTypeId,
    required this.type,
    required this.value,
  });

  factory ExcerciseTypeField.fromJson(Map<String, dynamic> json) => ExcerciseTypeField(
        id: json["id"],
        exerciseTypeId: json["exerciseTypeId"],
        type: json["type"]!,
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "exerciseTypeId": exerciseTypeId,
        "type": type,
        "value": value,
      };
}
