// To parse this JSON data, do
//
//     final myBookingModel = myBookingModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

MyBookingModel myBookingModelFromJson(String str) => MyBookingModel.fromJson(json.decode(str));

String myBookingModelToJson(MyBookingModel data) => json.encode(data.toJson());

class MyBookingModel {
  int? status;
  String? message;
  Result? result;

  MyBookingModel({
    this.status,
    this.message,
    this.result,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) => MyBookingModel(
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
  List<MyBooking> booking;
  int hasMoreResults;
  var completedCount = 0.obs;
  var rejectedCount = 0.obs;
  var cancelledCount = 0.obs;

  Result({
    required this.booking,
    required this.hasMoreResults,
    required this.completedCount,
    required this.rejectedCount,
    required this.cancelledCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        booking: List<MyBooking>.from(json["booking"].map((x) => MyBooking.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
        completedCount: int.parse(json["completedCount"].toString()).obs,
        rejectedCount: int.parse(json["rejectedCount"].toString()).obs,
        cancelledCount: int.parse(json["cancelledCount"].toString()).obs,
      );

  Map<String, dynamic> toJson() => {
        "booking": List<dynamic>.from(booking.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
        "completedCount": completedCount,
        "rejectedCount": rejectedCount,
        "cancelledCount": cancelledCount,
      };
}

class MyBooking {
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
  List<String> morningWeek;
  String eveningStartTime;
  String eveningEndTime;
  List<String> eveningWeek;
  String address;
  dynamic finalPrice;
  String status;
  String bookBy;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String deletedAt;
  String trainingStartDateFormat;
  String trainingEndDateFormat;
  dynamic remainigDays;
  List<BookingTrainingType> bookingTrainingType;
  BookingTrainingMode bookingTrainingMode;
  Trainee trainee;

  MyBooking({
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
    //required this.createdAt,
    // required this.updatedAt,
    // required this.deletedAt,
    required this.trainingStartDateFormat,
    required this.trainingEndDateFormat,
    required this.remainigDays,
    required this.bookingTrainingType,
    required this.bookingTrainingMode,
    required this.trainee,
  });

  factory MyBooking.fromJson(Map<String, dynamic> json) => MyBooking(
        id: json["id"],
        bookingNumber: json["bookingNumber"],
        appoinmentNumber: json["appoinmentNumber"],
        traineeId: json["traineeId"],
        trainerId: json["trainerId"],
        trainingModeId: json["trainingModeId"],
        trainingStartDate: json["trainingStartDate"],
        trainingEndDate: json["trainingEndDate"],
        morningStartTime: json["morningStartTime"],
        morningEndTime: json["morningEndTime"],
        morningWeek: List<String>.from(json["morningWeek"].map((x) => x)),
        eveningStartTime: json["eveningStartTime"],
        eveningEndTime: json["eveningEndTime"],
        eveningWeek: List<String>.from(json["eveningWeek"].map((x) => x)),
        address: json["address"],
        finalPrice: json["finalPrice"],
        status: json["status"],
        bookBy: json["bookBy"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // deletedAt: json["deletedAt"],
        trainingStartDateFormat: json["trainingStartDateFormat"],
        trainingEndDateFormat: json["trainingEndDateFormat"],
        remainigDays: json["remainigDays"],
        bookingTrainingType: List<BookingTrainingType>.from(
            json["bookingTrainingType"].map((x) => BookingTrainingType.fromJson(x))),
        bookingTrainingMode: json["bookingTrainingMode"] != ""
            ? BookingTrainingMode.fromJson(json["bookingTrainingMode"])
            : BookingTrainingMode(id: "", isActive: 0, title: "", trainingModesId: ""),
        trainee: Trainee.fromJson(json["trainee"]),
      );

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
        "morningWeek": List<dynamic>.from(morningWeek.map((x) => x)),
        "eveningStartTime": eveningStartTime,
        "eveningEndTime": eveningEndTime,
        "eveningWeek": List<dynamic>.from(eveningWeek.map((x) => x)),
        "address": address,
        "finalPrice": finalPrice,
        "status": status,
        "bookBy": bookBy,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "deletedAt": deletedAt,
        "trainingStartDateFormat": trainingStartDateFormat,
        "trainingEndDateFormat": trainingEndDateFormat,
        "remainigDays": remainigDays,
        "bookingTrainingType": List<dynamic>.from(bookingTrainingType.map((x) => x.toJson())),
        "bookingTrainingMode": bookingTrainingMode.toJson(),
        "trainee": trainee.toJson(),
      };
}

class BookingTrainingMode {
  String id;
  String trainingModesId;
  String title;
  int isActive;

  BookingTrainingMode({
    required this.id,
    required this.trainingModesId,
    required this.title,
    required this.isActive,
  });

  factory BookingTrainingMode.fromJson(Map<String, dynamic> json) => BookingTrainingMode(
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
  dynamic bookingId;
  String trainertrainingTypeId;
  dynamic price;
  String title;

  BookingTrainingType({
    required this.id,
    required this.bookingId,
    required this.trainertrainingTypeId,
    required this.price,
    required this.title,
  });

  factory BookingTrainingType.fromJson(Map<String, dynamic> json) => BookingTrainingType(
        id: json["id"],
        bookingId: json["bookingId"],
        trainertrainingTypeId: json["trainertrainingTypeId"],
        price: json["price"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingId": bookingId,
        "trainertrainingTypeId": trainertrainingTypeId,
        "price": price,
        "title": title,
      };
}

class Trainee {
  String id;
  String roleName;
  String profileImageShortName;
  String fullName;
  String cCodePhoneNumber;
  String profileImage;
  String email;

  Trainee(
      {required this.id,
      required this.roleName,
      required this.profileImageShortName,
      required this.fullName,
      required this.cCodePhoneNumber,
      required this.profileImage,
      required this.email});

  factory Trainee.fromJson(Map<String, dynamic> json) => Trainee(
      id: json["id"],
      roleName: json["roleName"],
      profileImageShortName: json["profileImageShortName"],
      fullName: json["fullName"],
      cCodePhoneNumber: json["cCodePhoneNumber"],
      profileImage: json["profileImage"],
      email: json['email'] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName,
        "cCodePhoneNumber": cCodePhoneNumber,
        "profileImage": profileImage,
        'email': email
      };
}
