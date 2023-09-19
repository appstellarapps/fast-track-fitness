// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  int status;
  String message;
  Result result;

  HistoryModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
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
  List<History> histories;
  int hasMoreResults;

  Result({
    required this.histories,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        histories: List<History>.from(json["histories"].map((x) => History.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "histories": List<dynamic>.from(histories.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class History {
  String id;
  String userId;
  String userCardId;
  String chargeId;
  String subscriptionsId;
  double amount;
  String description;
  String chargeType;
  String chargeStatus;
  int isActive;
  String type;
  String createdTimeFormat;
  Subscriptions subscriptions;
  UserCard usercard;
  UserData userData;

  History({
    required this.id,
    required this.userId,
    required this.userCardId,
    required this.chargeId,
    required this.subscriptionsId,
    required this.amount,
    required this.description,
    required this.chargeType,
    required this.chargeStatus,
    required this.isActive,
    required this.type,
    required this.createdTimeFormat,
    required this.subscriptions,
    required this.usercard,
    required this.userData,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["userId"],
        userCardId: json["userCardId"],
        chargeId: json["chargeId"],
        subscriptionsId: json["subscriptionsId"],
        amount: json["amount"]?.toDouble(),
        description: json["description"],
        chargeType: json["chargeType"],
        chargeStatus: json["chargeStatus"],
        isActive: json["isActive"],
        type: json["type"],
        createdTimeFormat: json["createdTimeFormat"],
        subscriptions: Subscriptions.fromJson(json["subscriptions"]),
        usercard: json["usercard"] != ''
            ? UserCard.fromJson(json["usercard"])
            : UserCard(
                id: "",
                cardHolderName: "",
                expiryDate: "",
                cardType: "",
                last4: 0,
                maskedNumber: "",
                cardImageUrl: ""),
        userData: UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userCardId": userCardId,
        "chargeId": chargeId,
        "subscriptionsId": subscriptionsId,
        "amount": amount,
        "description": description,
        "chargeType": chargeType,
        "chargeStatus": chargeStatus,
        "isActive": isActive,
        "type": type,
        "createdTimeFormat": createdTimeFormat,
        "subscriptions": subscriptions.toJson(),
        "usercard": usercard,
        "userData": userData.toJson(),
      };
}

class Subscriptions {
  String id;
  String name;
  String validity;

  Subscriptions({
    required this.id,
    required this.name,
    required this.validity,
  });

  factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        id: json["id"],
        name: json["name"],
        validity: json["validity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "validity": validity,
      };
}

class UserData {
  String id;
  String fullName;
  String profileImage;

  UserData({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        fullName: json["fullName"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "profileImage": profileImage,
      };
}

class UserCard {
  String id;
  String cardHolderName;
  String expiryDate;
  String cardType;
  int last4;
  String maskedNumber;
  String cardImageUrl;

  UserCard({
    required this.id,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
    required this.last4,
    required this.maskedNumber,
    required this.cardImageUrl,
  });

  factory UserCard.fromJson(Map<String, dynamic> json) => UserCard(
        id: json["id"],
        cardHolderName: json["cardHolderName"],
        expiryDate: json["expiryDate"],
        cardType: json["cardType"],
        last4: json["last4"],
        maskedNumber: json["maskedNumber"],
        cardImageUrl: json["cardImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cardHolderName": cardHolderName,
        "expiryDate": expiryDate,
        "cardType": cardType,
        "last4": last4,
        "maskedNumber": maskedNumber,
        "cardImageUrl": cardImageUrl,
      };
}
