// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  int status;
  String message;
  Result result;

  ReviewModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
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
  String reviewsAvg;
  int reviewsCount;
  List<ReviewList> data;
  int hasMoreResults;
  int isReview;
  int isWritable;

  Result({
    required this.reviewsAvg,
    required this.reviewsCount,
    required this.data,
    required this.hasMoreResults,
    required this.isReview,
    required this.isWritable,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    reviewsAvg: json["reviewsAvg"],
    reviewsCount: json["reviewsCount"],
    data: List<ReviewList>.from(json["data"].map((x) => ReviewList.fromJson(x))),
    hasMoreResults: json["hasMoreResults"],
    isReview: json["isReview"],
    isWritable: json["isWritable"],
  );

  Map<String, dynamic> toJson() => {
    "reviewsAvg": reviewsAvg,
    "reviewsCount": reviewsCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "hasMoreResults": hasMoreResults,
    "isReview": isReview,
    "isWritable": isWritable,
  };
}

class ReviewList {
  String id;
  String traineeId;
  String trainerId;
  String badgeId;
  double ratting;
  String description;
  DateTime createdAt;
  String published;
  TrainerReview trainee;
  TrainerReview trainer;

  ReviewList({
    required this.id,
    required this.traineeId,
    required this.trainerId,
    required this.badgeId,
    required this.ratting,
    required this.description,
    required this.createdAt,
    required this.published,
    required this.trainee,
    required this.trainer,
  });

  factory ReviewList.fromJson(Map<String, dynamic> json) => ReviewList(
    id: json["id"],
    traineeId: json["traineeId"],
    trainerId: json["trainerId"],
    badgeId: json["badgeId"],
    ratting: json["ratting"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    published: json["published"],
    trainee: TrainerReview.fromJson(json["trainee"]),
    trainer: TrainerReview.fromJson(json["trainer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "traineeId": traineeId,
    "trainerId": trainerId,
    "badgeId": badgeId,
    "ratting": ratting,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "published": published,
    "trainee": trainee.toJson(),
    "trainer": trainer.toJson(),
  };
}

class TrainerReview {
  String id;
  String firstName;
  String lastName;
  String profileImage;

  TrainerReview({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory TrainerReview.fromJson(Map<String, dynamic> json) => TrainerReview(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "profileImage": profileImage,
  };
}
