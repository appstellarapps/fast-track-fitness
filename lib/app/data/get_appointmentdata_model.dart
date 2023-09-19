// To parse this JSON data, do
//
//     final getAppointmentDetailsModel = getAppointmentDetailsModelFromJson(jsonString);

import 'dart:convert';

GetAppointmentDetailsModel getAppointmentDetailsModelFromJson(String str) =>
    GetAppointmentDetailsModel.fromJson(json.decode(str));

String getAppointmentDetailsModelToJson(GetAppointmentDetailsModel data) =>
    json.encode(data.toJson());

class GetAppointmentDetailsModel {
  dynamic? status;
  String? message;
  Result? result;

  GetAppointmentDetailsModel({
    this.status,
    this.message,
    this.result,
  });

  factory GetAppointmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetAppointmentDetailsModel(
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
  Booking booking;

  Result({
    required this.booking,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        booking: Booking.fromJson(json["booking"]),
      );

  Map<String, dynamic> toJson() => {
        "booking": booking.toJson(),
      };
}

class Booking {
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
  List<dynamic> morningWeek;
  String eveningStartTime;
  String eveningEndTime;
  List<dynamic> eveningWeek;
  String address;
  dynamic finalPrice;
  String status;
  String bookBy;
  String cancelReason;
  String cancelBy;
  String trainingStartDateFormat;
  String trainingEndDateFormat;
  dynamic remainigDays;
  List<dynamic> bookingTrainingType;
  dynamic bookingTrainingMode;
  Trainer trainer;
  Traine trainee;

  Booking({
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
    required this.trainingStartDateFormat,
    required this.trainingEndDateFormat,
    required this.remainigDays,
    required this.bookingTrainingType,
    required this.bookingTrainingMode,
    required this.trainer,
    required this.trainee,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
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
        morningWeek:
            json["morningWeek"] != [] ? List<dynamic>.from(json["morningWeek"].map((x) => x)) : [],
        eveningStartTime: json["eveningStartTime"],
        eveningEndTime: json["eveningEndTime"],
        eveningWeek:
            json["eveningWeek"] != [] ? List<dynamic>.from(json["eveningWeek"].map((x) => x)) : [],
        address: json["address"],
        finalPrice: json["finalPrice"],
        status: json["status"],
        bookBy: json["bookBy"],
        cancelReason: json["cancelReason"],
        cancelBy: json["cancelBy"],
        trainingStartDateFormat: json["trainingStartDateFormat"],
        trainingEndDateFormat: json["trainingEndDateFormat"],
        remainigDays: json["remainigDays"],
        bookingTrainingType: List<dynamic>.from(json["bookingTrainingType"].map((x) => x)),
        bookingTrainingMode: json["bookingTrainingMode"],
        trainer: Trainer.fromJson(json["trainer"]),
        trainee: Traine.fromJson(json["trainee"]),
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
        "trainingStartDateFormat": trainingStartDateFormat,
        "trainingEndDateFormat": trainingEndDateFormat,
        "remainigDays": remainigDays,
        "bookingTrainingType": List<dynamic>.from(bookingTrainingType.map((x) => x)),
        "bookingTrainingMode": bookingTrainingMode,
        "trainer": trainer.toJson(),
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
  String bookingId;
  String trainertrainingTypeId;
  int price;
  String title;
  UserTrainingType userTrainingType;

  BookingTrainingType({
    required this.id,
    required this.bookingId,
    required this.trainertrainingTypeId,
    required this.price,
    required this.title,
    required this.userTrainingType,
  });

  factory BookingTrainingType.fromJson(Map<String, dynamic> json) => BookingTrainingType(
        id: json["id"],
        bookingId: json["bookingId"],
        trainertrainingTypeId: json["trainertrainingTypeId"],
        price: json["price"],
        title: json["title"],
        userTrainingType: UserTrainingType.fromJson(json["userTrainingType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingId": bookingId,
        "trainertrainingTypeId": trainertrainingTypeId,
        "price": price,
        "title": title,
        "userTrainingType": userTrainingType.toJson(),
      };
}

class UserTrainingType {
  String id;
  String trainingTypesId;
  int price;
  String title;
  int isActive;

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

class Traine {
  String id;
  String roleName;
  String profileImageShortName;
  String fullName;
  String cCodePhoneNumber;
  String profileImage;
  String email;
  String? specialistName;
  String? address;

  Traine(
      {required this.id,
      required this.roleName,
      required this.profileImageShortName,
      required this.fullName,
      required this.cCodePhoneNumber,
      required this.profileImage,
      required this.email,
      required this.specialistName,
      required this.address});

  factory Traine.fromJson(Map<String, dynamic> json) => Traine(
      id: json["id"],
      roleName: json["roleName"],
      profileImageShortName: json["profileImageShortName"],
      fullName: json["fullName"],
      cCodePhoneNumber: json["cCodePhoneNumber"],
      profileImage: json["profileImage"],
      email: json["email"],
      specialistName: json["specialistName"],
      address: json['address']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName,
        "cCodePhoneNumber": cCodePhoneNumber,
        "profileImage": profileImage,
        "email": email,
        "specialistName": specialistName,
        'address': address
      };
}

class Trainer {
  String id;
  String roleName;
  String profileImageShortName;
  String fullName;
  String cCodePhoneNumber;
  String profileImage;
  String email;
  String? specialistName;
  String? address;

  Trainer(
      {required this.id,
      required this.roleName,
      required this.profileImageShortName,
      required this.fullName,
      required this.cCodePhoneNumber,
      required this.profileImage,
      required this.email,
      required this.specialistName,
      required this.address});

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
      id: json["id"],
      roleName: json["roleName"],
      profileImageShortName: json["profileImageShortName"],
      fullName: json["fullName"],
      cCodePhoneNumber: json["cCodePhoneNumber"],
      profileImage: json["profileImage"],
      email: json["email"],
      specialistName: json["specialistName"],
      address: json['address']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName,
        "cCodePhoneNumber": cCodePhoneNumber,
        "profileImage": profileImage,
        "email": email,
        "specialistName": specialistName,
        'address': address
      };
}
