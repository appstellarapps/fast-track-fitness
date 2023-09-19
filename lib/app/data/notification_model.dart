// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  dynamic status;
  String message;
  Result result;

  NotificationModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
  List<NotificationsData> notification;
  dynamic hasMoreResults;

  Result({
    required this.notification,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        notification: List<NotificationsData>.from(
            json["notification"].map((x) => NotificationsData.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "notification": List<dynamic>.from(notification.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class NotificationsData {
  String? id;
  String? receiverId;
  String? senderId;
  String? bookingId;
  dynamic? notificationType;
  String? title;
  String? body;
  String? staticTitle;
  String? staticMessage;
  RxString? action;
  String? data;
  dynamic? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deletedAt;
  String? notificationTime;
  BookingDetails? bookingDetails;
  SenderUser? senderUser;

  NotificationsData({
    this.id,
    this.receiverId,
    this.senderId,
    this.bookingId,
    this.notificationType,
    this.title,
    this.body,
    this.staticTitle,
    this.staticMessage,
    this.action,
    this.data,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.notificationTime,
    this.bookingDetails,
    this.senderUser,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) => NotificationsData(
        id: json["id"],
        receiverId: json["receiverId"],
        senderId: json["senderId"],
        bookingId: json["bookingId"],
        notificationType: json["notificationType"],
        title: json["title"],
        body: json["body"],
        staticTitle: json["staticTitle"],
        staticMessage: json["staticMessage"],
        action: json["action"].toString().obs,
        data: json["data"],
        isRead: json["isRead"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        notificationTime: json["notificationTime"],
        bookingDetails: BookingDetails.fromJson(json["bookingDetails"]),
        senderUser: SenderUser.fromJson(json["senderUser"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receiverId": receiverId,
        "senderId": senderId,
        "bookingId": bookingId,
        "notificationType": notificationType,
        "title": title,
        "body": body,
        "staticTitle": staticTitle,
        "staticMessage": staticMessage,
        "action": action,
        "data": data,
        "isRead": isRead,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
        "notificationTime": notificationTime,
        "bookingDetails": bookingDetails!.toJson(),
        "senderUser": senderUser!.toJson(),
      };
}

class BookingDetails {
  String id;
  String bookingNumber;
  String appoinmentNumber;
  String traineeId;
  String trainerId;
  String trainingModeId;
  String trainingStartDate;
  String trainingEndDate;
  String morningStartTime;
  String morningEndTime;
  dynamic morningWeek;
  String eveningStartTime;
  String eveningEndTime;
  dynamic eveningWeek;
  String address;
  dynamic finalPrice;
  RxString status;
  String bookBy;
  String cancelReason;
  String cancelBy;
  List<BookingTrainingType> bookingTrainingType;
  dynamic bookingTrainingMode;

  BookingDetails({
    required this.id,
    required this.bookingNumber,
    required this.appoinmentNumber,
    required this.traineeId,
    required this.trainerId,
    required this.trainingModeId,
    required this.trainingStartDate,
    required this.trainingEndDate,
    required this.morningStartTime,
    required this.morningEndTime,
    required this.morningWeek,
    required this.eveningStartTime,
    required this.eveningEndTime,
    required this.eveningWeek,
    required this.address,
    required this.finalPrice,
    required this.status,
    required this.bookBy,
    required this.cancelReason,
    required this.cancelBy,
    required this.bookingTrainingType,
    required this.bookingTrainingMode,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
      id: json["id"] ?? "",
      bookingNumber: json["bookingNumber"] ?? "",
      appoinmentNumber: json["appoinmentNumber"] ?? "",
      traineeId: json["traineeId"] ?? "",
      trainerId: json["trainerId"] ?? "",
      trainingModeId: json["trainingModeId"] ?? "",
      trainingStartDate: json["trainingStartDate"] ?? "",
      trainingEndDate: json["trainingEndDate"] ?? "",
      morningStartTime: json["morningStartTime"] ?? "",
      morningEndTime: json["morningEndTime"] ?? "",
      morningWeek: json["morningWeek"] ?? "",
      eveningStartTime: json["eveningStartTime"] ?? "",
      eveningEndTime: json["eveningEndTime"] ?? "",
      eveningWeek: json["eveningWeek"] ?? "",
      address: json["address"] ?? "",
      finalPrice: json["finalPrice"] ?? "",
      status: json["status"] != null ? json["status"].toString().obs : "".obs,
      bookBy: json["bookBy"] ?? "",
      cancelReason: json["cancelReason"] ?? "",
      cancelBy: json["cancelBy"] ?? "",
      bookingTrainingType: List<BookingTrainingType>.from(json["bookingTrainingType"] != null
          ? json["bookingTrainingType"].map((x) => BookingTrainingType.fromJson(x))
          : []),
      bookingTrainingMode:
          json["bookingTrainingMode"] != "" ? json["bookingTrainingMode"] : BookingTrainingMode());

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingNumber": bookingNumber,
        "appoinmentNumber": appoinmentNumber,
        "traineeId": traineeId,
        "trainerId": trainerId,
        "trainingModeId": trainingModeId,
        "trainingStartDate": trainingStartDate,
        "trainingEndDate": trainingEndDate,
        "morningStartTime": morningStartTime,
        "morningEndTime": morningEndTime,
        "morningWeek": morningWeek,
        "eveningStartTime": eveningStartTime,
        "eveningEndTime": eveningEndTime,
        "eveningWeek": eveningWeek,
        "address": address,
        "finalPrice": finalPrice,
        "status": status,
        "bookBy": bookBy,
        "cancelReason": cancelReason,
        "cancelBy": cancelBy,
        "bookingTrainingType": List<dynamic>.from(bookingTrainingType.map((x) => x.toJson())),
        "bookingTrainingMode": bookingTrainingMode,
      };
}

class BookingTrainingModeClass {
  String id;
  String trainingModesId;
  String title;
  dynamic isActive;

  BookingTrainingModeClass({
    required this.id,
    required this.trainingModesId,
    required this.title,
    required this.isActive,
  });

  factory BookingTrainingModeClass.fromJson(Map<String, dynamic> json) => BookingTrainingModeClass(
        id: json["id"],
        trainingModesId: json["trainingModesId"],
        title: json["title"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trainingModesId": trainingModesId,
        "title": title,
        "isActive": isActive,
      };
}

class BookingTrainingType {
  String id;
  String bookingId;
  String trainertrainingTypeId;
  dynamic price;
  UserTrainingType userTrainingType;

  BookingTrainingType({
    required this.id,
    required this.bookingId,
    required this.trainertrainingTypeId,
    required this.price,
    required this.userTrainingType,
  });

  factory BookingTrainingType.fromJson(Map<String, dynamic> json) => BookingTrainingType(
        id: json["id"],
        bookingId: json["bookingId"],
        trainertrainingTypeId: json["trainertrainingTypeId"],
        price: json["price"],
        userTrainingType: UserTrainingType.fromJson(json["userTrainingType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingId": bookingId,
        "trainertrainingTypeId": trainertrainingTypeId,
        "price": price,
        "userTrainingType": userTrainingType.toJson(),
      };
}

class UserTrainingType {
  String id;
  String trainingTypesId;
  dynamic price;
  String title;
  dynamic isActive;

  UserTrainingType({
    required this.id,
    required this.trainingTypesId,
    required this.price,
    required this.title,
    required this.isActive,
  });

  factory UserTrainingType.fromJson(Map<String, dynamic> json) => UserTrainingType(
        id: json["id"],
        trainingTypesId: json["trainingTypesId"],
        price: json["price"],
        title: json["title"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trainingTypesId": trainingTypesId,
        "price": price,
        "title": title,
        "isActive": isActive,
      };
}

class SenderUser {
  String id;
  String roleName;
  String profileImageShortName;
  String fullName;
  String cCodePhoneNumber;
  String profileImage;
  String address;
  String email;

  SenderUser({
    required this.id,
    required this.roleName,
    required this.profileImageShortName,
    required this.fullName,
    required this.cCodePhoneNumber,
    required this.profileImage,
    required this.address,
    required this.email,
  });

  factory SenderUser.fromJson(Map<String, dynamic> json) => SenderUser(
        id: json["id"],
        roleName: json["roleName"],
        profileImageShortName: json["profileImageShortName"],
        fullName: json["fullName"],
        cCodePhoneNumber: json["cCodePhoneNumber"],
        profileImage: json["profileImage"],
        address: json["address"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName,
        "cCodePhoneNumber": cCodePhoneNumber,
        "profileImage": profileImage,
        "address": address,
        "email": email,
      };
}

class BookingTrainingMode {
  BookingTrainingMode({
    this.id,
    this.trainingModesId,
    this.title,
    this.isActive,
  });

  String? id;
  String? trainingModesId;
  String? title;
  dynamic? isActive;

  factory BookingTrainingMode.fromJson(Map<String, dynamic> json) => BookingTrainingMode(
        id: json["id"] == null ? null : json["id"],
        trainingModesId: json["trainingModesId"] == null ? null : json["trainingModesId"],
        title: json["title"] == null ? null : json["title"],
        isActive: json["isActive"] == null ? null : json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "trainingModesId": trainingModesId == null ? null : trainingModesId,
        "title": title == null ? null : title,
        "isActive": isActive == null ? null : isActive,
      };
}
