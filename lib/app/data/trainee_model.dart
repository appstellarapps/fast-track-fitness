// To parse this JSON data, do
//
//     final traineeModel = traineeModelFromJson(jsonString);

import 'dart:convert';

TraineeModel traineeModelFromJson(String str) => TraineeModel.fromJson(json.decode(str));

String traineeModelToJson(TraineeModel data) => json.encode(data.toJson());

class TraineeModel {
  int status;
  String message;
  Result result;

  TraineeModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory TraineeModel.fromJson(Map<String, dynamic> json) => TraineeModel(
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
  List<TraineeUser> traineeUser;
  int hasMoreResults;

  Result({
    required this.traineeUser,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    traineeUser: List<TraineeUser>.from(json["traineeUser"].map((x) => TraineeUser.fromJson(x))),
    hasMoreResults: json["hasMoreResults"],
  );

  Map<String, dynamic> toJson() => {
    "traineeUser": List<dynamic>.from(traineeUser.map((x) => x.toJson())),
    "hasMoreResults": hasMoreResults,
  };
}

class TraineeUser {
  String id;
  String firstName;
  String lastName;
  String fullName;
  String countryCode;
  int phoneNumber;
  String fullNumber;
  String email;
  String address;
  String profileImage;

  TraineeUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.countryCode,
    required this.phoneNumber,
    required this.fullNumber,
    required this.email,
    required this.address,
    required this.profileImage,
  });

  factory TraineeUser.fromJson(Map<String, dynamic> json) => TraineeUser(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
    fullNumber: json["fullNumber"],
    email: json["email"],
    address: json["address"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "fullName": fullName,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
    "fullNumber": fullNumber,
    "email": email,
    "address": address,
    "profileImage": profileImage,
  };
}
