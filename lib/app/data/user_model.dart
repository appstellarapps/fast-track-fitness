// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:get/get.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  dynamic status;
  String? message;
  Result? result;

  UserModel({
    this.status,
    this.message,
    this.result,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
        status: json!["status"],
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
  User user;
  String accessToken;

  Result({
    required this.user,
    required this.accessToken,
  });

  factory Result.fromJson(Map<String, dynamic>? json) => Result(
        user: User.fromJson(json!["user"]),
        accessToken: json["accessToken"] ?? AppStorage.userData.result!.accessToken,
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "accessToken": accessToken,
      };
}

class User {
  String id;
  String roleId;
  RxString? firstName = ''.obs;
  RxString? lastName = ''.obs;
  RxString? profilePic = ''.obs;
  RxString? email = ''.obs;
  String emailVerifiedAt;
  String countryCode;
  RxString? phoneNumber = ''.obs;
  dynamic isActive;
  dynamic otp;
  DateTime otpCreatedDate;
  dynamic otpVerified;
  String address;
  String latitude;
  String longitude;
  String gender;
  dynamic age;
  dynamic isPrivate;
  String specialistId;
  dynamic expInYear;
  dynamic charges;
  dynamic averageRatting;
  String deviceToken;
  String stripeId;
  dynamic isSubscribed;
  String qualificationFileStatus;
  String qualificationFileDescription;
  dynamic isResourceSubscribed;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  String roleName;
  String profileImageShortName;
  RxString? fullName = ''.obs;
  String cCodePhoneNumber;
  String profileImage;
  int isFreeTrail = 0;
  int isProfileVerified = 0;

  User(
      {required this.id,
      required this.roleId,
      required this.firstName,
      required this.lastName,
      required this.profilePic,
      required this.email,
      required this.emailVerifiedAt,
      required this.countryCode,
      required this.phoneNumber,
      required this.isActive,
      required this.otp,
      required this.otpCreatedDate,
      required this.otpVerified,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.gender,
      required this.age,
      required this.isPrivate,
      required this.specialistId,
      required this.expInYear,
      required this.charges,
      required this.averageRatting,
      required this.deviceToken,
      required this.stripeId,
      required this.isSubscribed,
      required this.qualificationFileStatus,
      required this.qualificationFileDescription,
      required this.isResourceSubscribed,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.roleName,
      required this.profileImageShortName,
      required this.fullName,
      required this.cCodePhoneNumber,
      required this.profileImage,
      required this.isFreeTrail,
      required this.isProfileVerified});

  factory User.fromJson(Map<String, dynamic>? json) => User(
      id: json!["id"],
      roleId: json["roleId"],
      firstName: (json["firstName"].toString()).obs,
      lastName: (json["lastName"].toString()).obs,
      profilePic: (json["profilePic"].toString()).obs,
      email: (json["email"].toString()).obs,
      emailVerifiedAt: json["emailVerifiedAt"],
      countryCode: json["countryCode"],
      phoneNumber: (json["phoneNumber"].toString()).obs,
      isActive: json["isActive"],
      otp: json["otp"],
      otpCreatedDate: DateTime.parse(json["otpCreatedDate"]),
      otpVerified: json["otpVerified"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      gender: json["gender"],
      age: json["age"],
      isPrivate: json["isPrivate"],
      specialistId: json["specialistId"],
      expInYear: json["expInYear"],
      charges: json["charges"],
      averageRatting: json["averageRatting"],
      deviceToken: json["deviceToken"],
      stripeId: json["stripeId"],
      isSubscribed: json["isSubscribed"],
      qualificationFileStatus: json["qualificationFileStatus"],
      qualificationFileDescription: json["qualificationFileDescription"],
      isResourceSubscribed: json["isResourceSubscribed"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      deletedAt: json["deletedAt"],
      roleName: json["roleName"],
      profileImageShortName: json["profileImageShortName"],
      fullName: (json["fullName"].toString()).obs,
      cCodePhoneNumber: json["cCodePhoneNumber"],
      profileImage: json["profileImage"],
      isFreeTrail: json['isFreeTrail'] ?? 0,
      isProfileVerified: json['isProfileVerified'] ?? 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleId": roleId,
        "firstName": firstName!.value,
        "lastName": lastName!.value,
        "profilePic": profilePic!.value,
        "email": email!.value,
        "emailVerifiedAt": emailVerifiedAt,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber!.value,
        "isActive": isActive,
        "otp": otp,
        "otpCreatedDate": otpCreatedDate.toIso8601String(),
        "otpVerified": otpVerified,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "gender": gender,
        "age": age,
        "isPrivate": isPrivate,
        "specialistId": specialistId,
        "expInYear": expInYear,
        "charges": charges,
        "averageRatting": averageRatting,
        "deviceToken": deviceToken,
        "stripeId": stripeId,
        "isSubscribed": isSubscribed,
        "qualificationFileStatus": qualificationFileStatus,
        "qualificationFileDescription": qualificationFileDescription,
        "isResourceSubscribed": isResourceSubscribed,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "roleName": roleName,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName!.value,
        "cCodePhoneNumber": cCodePhoneNumber,
        "profileImage": profileImage,
        'isProfileVerified': isProfileVerified,
        'isFreeTrail': isFreeTrail
      };
}
