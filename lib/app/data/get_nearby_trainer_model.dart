// To parse this JSON data, do
//
//     final getNearByTrainerModel = getNearByTrainerModelFromJson(jsonString);

import 'dart:convert';

GetNearByTrainerModel getNearByTrainerModelFromJson(String str) => GetNearByTrainerModel.fromJson(json.decode(str));

String getNearByTrainerModelToJson(GetNearByTrainerModel data) => json.encode(data.toJson());

class GetNearByTrainerModel {
  int status;
  String message;
  Result result;

  GetNearByTrainerModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetNearByTrainerModel.fromJson(Map<String, dynamic>? json) => GetNearByTrainerModel(
    status: json!["status"],
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
  List<NearTrainer> user;

  Result({
    required this.user,
  });

  factory Result.fromJson(Map<String, dynamic>? json) => Result(
    user: List<NearTrainer>.from(json!["user"].map((x) => NearTrainer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class NearTrainer {
  String id;
  String roleId;
  String firstName;
  String lastName;
  String profilePic;
  String email;
  dynamic emailVerifiedAt;
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
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  double distance;
  String onlineStatus;
  String profileImage;
  double reviewAverage;
  String userMarkerImage;
  UserSpecialist userSpecialist;
  UserShiftTimming userShiftTimming;
  List<TrainerReview> trainerReview;
  var qualificationFileStatus;

  NearTrainer({
    required this.id,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.email,
    this.emailVerifiedAt,
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
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.distance,
    required this.onlineStatus,
    required this.profileImage,
    required this.reviewAverage,
    required this.userMarkerImage,
    required this.userSpecialist,
    required this.userShiftTimming,
    required this.trainerReview,
    this.qualificationFileStatus,
  });

  factory NearTrainer.fromJson(Map<String, dynamic>? json) => NearTrainer(
    id: json!["id"],
    roleId: json["roleId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
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
    averageRatting: json["averageRatting"]?.toDouble(),
    deviceToken: json["deviceToken"],
    stripeId: json["stripeId"],
    isSubscribed: json["isSubscribed"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    distance: json["distance"],
    onlineStatus: json["onlineStatus"],
    profileImage: json["profileImage"],
    reviewAverage: json["reviewAverage"]?.toDouble(),
    userMarkerImage: json["userMarkerImage"],
    userSpecialist: UserSpecialist.fromJson(json["userSpecialist"]),
    userShiftTimming: UserShiftTimming.fromJson(json["userShiftTimming"]),
    trainerReview: json["trainerReview"] != null ? List<TrainerReview>.from(json["trainerReview"].map((x) => TrainerReview.fromJson(x))) : [],
    qualificationFileStatus: json['qualificationFileStatus'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roleId": roleId,
    "firstName": firstName,
    "lastName": lastName,
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
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
    "distance": distance,
    "onlineStatus": onlineStatus,
    "profileImage": profileImage,
    "reviewAverage": reviewAverage,
    "userMarkerImage": userMarkerImage,
    "userSpecialist": userSpecialist.toJson(),
    "userShiftTimming": userShiftTimming.toJson(),
    "trainerReview": List<dynamic>.from(trainerReview.map((x) => x.toJson())),
    "qualificationFileStatus": qualificationFileStatus,
  };
}

class TrainerReview {
  String id;
  String traineeId;
  String trainerId;
  double ratting;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String published;

  TrainerReview({
    required this.id,
    required this.traineeId,
    required this.trainerId,
    required this.ratting,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.published,
  });

  factory TrainerReview.fromJson(Map<String, dynamic>? json) => TrainerReview(
    id: json!["id"],
    traineeId: json["traineeId"],
    trainerId: json["trainerId"],
    ratting: json["ratting"]?.toDouble(),
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"]!="" ?json["deletedAt"] :DateTime.now(),
    published: json["published"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "traineeId": traineeId,
    "trainerId": trainerId,
    "ratting": ratting,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
    "published": published,
  };
}




class UserShiftTimming {
  String id;
  String userId;
  String morningStartTime;
  String morningEndTime;
  List<String> morningWeek;
  String eveningStartTime;
  String eveningEndTime;
  List<String> eveningWeek;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  UserShiftTimming({
    required this.id,
    required this.userId,
    required this.morningStartTime,
    required this.morningEndTime,
    required this.morningWeek,
    required this.eveningStartTime,
    required this.eveningEndTime,
    required this.eveningWeek,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory UserShiftTimming.fromJson(Map<String, dynamic>? json) => UserShiftTimming(
    id: json!["id"],
    userId: json["userId"],
    morningStartTime: json["morningStartTime"],
    morningEndTime: json["morningEndTime"],
    morningWeek: List<String>.from(json["morningWeek"].map((x) => x)),
    eveningStartTime: json["eveningStartTime"],
    eveningEndTime: json["eveningEndTime"],
    eveningWeek: List<String>.from(json["eveningWeek"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "morningStartTime": morningStartTime,
    "morningEndTime": morningEndTime,
    "morningWeek": List<dynamic>.from(morningWeek.map((x) => x)),
    "eveningStartTime": eveningStartTime,
    "eveningEndTime": eveningEndTime,
    "eveningWeek": List<dynamic>.from(eveningWeek.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
  };
}

class UserSpecialist {
  String id;
  String userId;
  String title;
  int isActive;

  UserSpecialist({
    required this.id,
    required this.userId,
    required this.title,
    required this.isActive,
  });

  factory UserSpecialist.fromJson(Map<String, dynamic>? json) => UserSpecialist(
    id: json!["id"] ?? "",
    userId: json["userId"] ?? "",
    title: json["title"] ?? "",
    isActive: json["isActive"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "title": title,
    "isActive": isActive,
  };
}

