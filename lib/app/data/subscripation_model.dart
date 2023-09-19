// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

SubscriptionModel subscriptionModelFromJson(String str) =>
    SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) => json.encode(data.toJson());

class SubscriptionModel {
  int? status;
  String? message;
  Result? result;

  SubscriptionModel({
    this.status,
    this.message,
    this.result,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
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
  List<Subscription> subscription;

  Result({
    required this.subscription,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        subscription:
            List<Subscription>.from(json["subscription"].map((x) => Subscription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subscription": List<dynamic>.from(subscription.map((x) => x.toJson())),
      };
}

class Subscription {
  String? id;
  String? name;
  String? validity;
  int? validateDays;
  double? amount;
  String? iosKey;
  String? androidKey;
  String? type;

  var isSelected = false.obs;

  Subscription(
      {this.id,
      this.name,
      this.validity,
      this.validateDays,
      this.amount,
      this.iosKey,
      this.androidKey,
      this.type});

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
      id: json["id"],
      name: json["name"],
      validity: json["validity"],
      validateDays: json["validateDays"],
      amount: json["amount"]?.toDouble(),
      iosKey: json["iosKey"],
      androidKey: json["androidKey"],
      type: json['type']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "validity": validity,
        "validateDays": validateDays,
        "amount": amount,
        "iosKey": iosKey,
        "androidKey": androidKey,
        "type": type
      };
}
