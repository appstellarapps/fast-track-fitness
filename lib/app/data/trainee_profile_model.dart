// To parse this JSON data, do
//
//     final getTraineeProfileDetailModel = getTraineeProfileDetailModelFromJson(jsonString);

import 'dart:convert';

GetTraineeProfileDetailModel getTraineeProfileDetailModelFromJson(String str) => GetTraineeProfileDetailModel.fromJson(json.decode(str));

String getTraineeProfileDetailModelToJson(GetTraineeProfileDetailModel data) => json.encode(data.toJson());

class GetTraineeProfileDetailModel {
  int? status;
  String? message;
  Result? result;

  GetTraineeProfileDetailModel({
    this.status,
    this.message,
    this.result,
  });

  factory GetTraineeProfileDetailModel.fromJson(Map<String, dynamic> json) => GetTraineeProfileDetailModel(
    status: json["status"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  User user;

  Result({
    required this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  String id;
  String roleId;
  String firstName;
  String lastName;
  String dateOfBirth;
  String profilePic;
  String email;
  String emailVerifiedAt;
  String countryCode;
  int phoneNumber;
  int isActive;
  int otp;
  DateTime otpCreatedDate;
  int otpVerified;
  String address;
  String latitude;
  String longitude;
  String gender;
  int age;
  int isPrivate;
  String specialistId;
  int expInYear;
  double charges;
  double averageRatting;
  String deviceToken;
  String stripeId;
  int isSubscribed;
  String qualificationFileStatus;
  String insuranceFileStatus;
  String qualificationFileDescription;
  int isResourceSubscribed;
  int isFreeTrail;
  int isProfileVerified;
  int isActivatedAccount;
  int isKidFriendly;
  int engagementScore;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  String roleName;
  String profileImageShortName;
  String fullName;
  String cCodePhoneNumber;
  String profileImage;
  String createdAtFormat;
  String userProfile;
  List<UserBadge> userBadges;

  User({
    required this.id,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
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
    required this.insuranceFileStatus,
    required this.qualificationFileDescription,
    required this.isResourceSubscribed,
    required this.isFreeTrail,
    required this.isProfileVerified,
    required this.isActivatedAccount,
    required this.isKidFriendly,
    required this.engagementScore,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.roleName,
    required this.profileImageShortName,
    required this.fullName,
    required this.cCodePhoneNumber,
    required this.profileImage,
    required this.createdAtFormat,
    required this.userProfile,
    required this.userBadges,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    roleId: json["roleId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    dateOfBirth: json["dateOfBirth"],
    profilePic: json["profilePic"],
    email: json["email"],
    emailVerifiedAt: json["emailVerifiedAt"],
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
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
    insuranceFileStatus: json["insuranceFileStatus"],
    qualificationFileDescription: json["qualificationFileDescription"],
    isResourceSubscribed: json["isResourceSubscribed"],
    isFreeTrail: json["isFreeTrail"],
    isProfileVerified: json["isProfileVerified"],
    isActivatedAccount: json["isActivatedAccount"],
    isKidFriendly: json["isKidFriendly"],
    engagementScore: json["engagementScore"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    roleName: json["roleName"],
    profileImageShortName: json["profileImageShortName"],
    fullName: json["fullName"],
    cCodePhoneNumber: json["cCodePhoneNumber"],
    profileImage: json["profileImage"],
    createdAtFormat: json["createdAtFormat"],
    userProfile: json["userProfile"],
    userBadges: List<UserBadge>.from(json["userBadges"].map((x) => UserBadge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roleId": roleId,
    "firstName": firstName,
    "lastName": lastName,
    "dateOfBirth": dateOfBirth,
    "profilePic": profilePic,
    "email": email,
    "emailVerifiedAt": emailVerifiedAt,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
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
    "insuranceFileStatus": insuranceFileStatus,
    "qualificationFileDescription": qualificationFileDescription,
    "isResourceSubscribed": isResourceSubscribed,
    "isFreeTrail": isFreeTrail,
    "isProfileVerified": isProfileVerified,
    "isActivatedAccount": isActivatedAccount,
    "isKidFriendly": isKidFriendly,
    "engagementScore": engagementScore,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
    "roleName": roleName,
    "profileImageShortName": profileImageShortName,
    "fullName": fullName,
    "cCodePhoneNumber": cCodePhoneNumber,
    "profileImage": profileImage,
    "createdAtFormat": createdAtFormat,
    "userProfile": userProfile,
    "userBadges": List<dynamic>.from(userBadges.map((x) => x.toJson())),
  };
}

class UserBadge {
  String id;
  String userId;
  String badgeId;
  String type;
  int badgeCount;
  String badgeUrl;

  UserBadge({
    required this.id,
    required this.userId,
    required this.badgeId,
    required this.type,
    required this.badgeCount,
    required this.badgeUrl,
  });

  factory UserBadge.fromJson(Map<String, dynamic> json) => UserBadge(
    id: json["id"],
    userId: json["userId"],
    badgeId: json["badgeId"],
    type: json["type"],
    badgeCount: json["badgeCount"],
    badgeUrl: json["badgeUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "badgeId": badgeId,
    "type": type,
    "badgeCount": badgeCount,
    "badgeUrl": badgeUrl,
  };
}
