// To parse this JSON data, do
//
//     final badgesModel = badgesModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

BadgesModel badgesModelFromJson(String str) => BadgesModel.fromJson(json.decode(str));

String badgesModelToJson(BadgesModel data) => json.encode(data.toJson());

class BadgesModel {
  int? status;
  String? message;
  List<Result>? result;

  BadgesModel({
    this.status,
    this.message,
    this.result,
  });

  factory BadgesModel.fromJson(Map<String, dynamic> json) => BadgesModel(
        status: json["status"],
        message: json["message"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  String? id;
  String? title;
  String? badge;
  int? isActive;
  String? type;
  String? badgeUrl;
  var isSelected = false.obs;

  Result({
    this.id,
    this.title,
    this.badge,
    this.isActive,
    this.type,
    this.badgeUrl,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        badge: json["badge"],
        isActive: json["isActive"],
        type: json["type"],
        badgeUrl: json["badgeUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "badge": badge,
        "isActive": isActive,
        "type": type,
        "badgeUrl": badgeUrl,
      };
}
