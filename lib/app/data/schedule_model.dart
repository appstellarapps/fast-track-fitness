// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  int status;
  String message;
  Result result;

  ScheduleModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
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
  DateTime trainingStartDate;
  DateTime trainingEndDate;
  String morningStartTime;
  String morningEndTime;
  List<String> morningWeek;
  String eveningStartTime;
  String eveningEndTime;
  List<dynamic> eveningWeek;
  String address;
  String finalPrice;
  String status;
  String bookBy;
  String cancelReason;
  String cancelBy;
  String trainingStartDateFormat;
  String trainingEndDateFormat;
  dynamic remainigDays;
  List<BookingTrainingType> bookingTrainingType;
  BookingTrainingMode bookingTrainingMode;
  Traine trainer;
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
        trainingStartDate: DateTime.parse(json["trainingStartDate"]),
        trainingEndDate: DateTime.parse(json["trainingEndDate"]),
        morningStartTime: json["morningStartTime"],
        morningEndTime: json["morningEndTime"],
        morningWeek: List<String>.from(json["morningWeek"].map((x) => x)),
        eveningStartTime: json["eveningStartTime"],
        eveningEndTime: json["eveningEndTime"],
        eveningWeek: List<dynamic>.from(json["eveningWeek"].map((x) => x)),
        address: json["address"],
        finalPrice: json["finalPrice"],
        status: json["status"],
        bookBy: json["bookBy"],
        cancelReason: json["cancelReason"],
        cancelBy: json["cancelBy"],
        trainingStartDateFormat: json["trainingStartDateFormat"],
        trainingEndDateFormat: json["trainingEndDateFormat"],
        remainigDays: json["remainigDays"],
        bookingTrainingType: List<BookingTrainingType>.from(
            json["bookingTrainingType"].map((x) => BookingTrainingType.fromJson(x))),
        bookingTrainingMode: BookingTrainingMode.fromJson(json["bookingTrainingMode"]),
        trainer: Traine.fromJson(json["trainer"]),
        trainee: Traine.fromJson(json["trainee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingNumber": bookingNumber,
        "appoinmentNumber": appoinmentNumber,
        "traineeId": traineeId,
        "trainerId": trainerId,
        "trainingModeId": trainingModeId,
        "trainingStartDate":
            "${trainingStartDate.year.toString().padLeft(4, '0')}-${trainingStartDate.month.toString().padLeft(2, '0')}-${trainingStartDate.day.toString().padLeft(2, '0')}",
        "trainingEndDate":
            "${trainingEndDate.year.toString().padLeft(4, '0')}-${trainingEndDate.month.toString().padLeft(2, '0')}-${trainingEndDate.day.toString().padLeft(2, '0')}",
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
        "cancelReason": cancelReason,
        "cancelBy": cancelBy,
        "trainingStartDateFormat": trainingStartDateFormat,
        "trainingEndDateFormat": trainingEndDateFormat,
        "remainigDays": remainigDays,
        "bookingTrainingType": List<dynamic>.from(bookingTrainingType.map((x) => x.toJson())),
        "bookingTrainingMode": bookingTrainingMode.toJson(),
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
  double price;
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
  double price;
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

  Traine({
    required this.id,
    required this.roleName,
    required this.profileImageShortName,
    required this.fullName,
    required this.cCodePhoneNumber,
    required this.profileImage,
    required this.email,
    this.specialistName,
  });

  factory Traine.fromJson(Map<String, dynamic> json) => Traine(
        id: json["id"],
        roleName: json["roleName"],
        profileImageShortName: json["profileImageShortName"],
        fullName: json["fullName"],
        cCodePhoneNumber: json["cCodePhoneNumber"],
        profileImage: json["profileImage"],
        email: json["email"],
        specialistName: json["specialistName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName,
        "cCodePhoneNumber": cCodePhoneNumber,
        "profileImage": profileImage,
        "email": email,
        "specialistName": specialistName,
      };
}
