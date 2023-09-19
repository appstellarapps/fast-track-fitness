// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  CardResult? result;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        status: json["status"],
        message: json["message"],
        result: CardResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result!.toJson(),
      };
}

class CardResult {
  CardResult({
    this.userCards,
  });

  List<UserCard>? userCards;

  factory CardResult.fromJson(Map<String, dynamic> json) => CardResult(
        userCards: List<UserCard>.from(json["userCards"].map((x) => UserCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userCards": List<dynamic>.from(userCards!.map((x) => x.toJson())),
      };
}

class UserCard {
  UserCard({
    this.id,
    this.userId,
    this.cardHolderName,
    this.cvv,
    this.last4,
    this.expiryDate,
    this.cardType,
    this.cardImage,
    this.maskedNumber,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.cardImageUrl,
    required this.isSelected,
  });

  String? id;
  String? userId;
  String? cardHolderName;
  dynamic? cvv;
  dynamic? last4;
  String? expiryDate;
  String? cardType;
  String? cardImage;
  String? maskedNumber;
  dynamic? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deletedAt;
  String? cardImageUrl;
  RxBool isSelected;

  factory UserCard.fromJson(Map<String, dynamic> json) => UserCard(
        id: json["id"],
        userId: json["userId"],
        cardHolderName: json["cardHolderName"],
        cvv: json["cvv"],
        last4: json["last4"],
        expiryDate: json["expiryDate"],
        cardType: json["cardType"],
        cardImage: json["cardImage"],
        maskedNumber: json["maskedNumber"],
        isDefault: json["isDefault"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        cardImageUrl: json["cardImageUrl"],
        isSelected: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "cardHolderName": cardHolderName,
        "cvv": cvv,
        "last4": last4,
        "expiryDate": expiryDate,
        "cardType": cardType,
        "cardImage": cardImage,
        "maskedNumber": maskedNumber,
        "isDefault": isDefault,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
        "cardImageUrl": cardImageUrl,
      };
}
