// To parse this JSON data, do
//
//     final preMadeViewAll = preMadeViewAllFromJson(jsonString);

import 'dart:convert';

PreMadeViewAll preMadeViewAllFromJson(String str) => PreMadeViewAll.fromJson(json.decode(str));

String preMadeViewAllToJson(PreMadeViewAll data) => json.encode(data.toJson());

class PreMadeViewAll {
  int status;
  String message;
  Result result;

  PreMadeViewAll({
    required this.status,
    required this.message,
    required this.result,
  });

  factory PreMadeViewAll.fromJson(Map<String, dynamic> json) => PreMadeViewAll(
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
  List<PreMadeMeals> data;
  int hasMoreResults;
  String mainCategoryTitle;

  Result({
    required this.data,
    required this.hasMoreResults,
    required this.mainCategoryTitle,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    data: List<PreMadeMeals>.from(json["data"].map((x) => PreMadeMeals.fromJson(x))),
    hasMoreResults: json["hasMoreResults"],
    mainCategoryTitle: json["mainCategoryTitle"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "hasMoreResults": hasMoreResults,
    "mainCategoryTitle": mainCategoryTitle,
  };
}

class PreMadeMeals {
  String id;
  String parentCategoryId;
  String type;
  String title;
  String image;
  String video;
  String videoUrl;
  String imageUrl;
  String totalLibraryDuration;

  PreMadeMeals({
    required this.id,
    required this.parentCategoryId,
    required this.type,
    required this.title,
    required this.image,
    required this.video,
    required this.videoUrl,
    required this.imageUrl,
    required this.totalLibraryDuration,
  });

  factory PreMadeMeals.fromJson(Map<String, dynamic> json) => PreMadeMeals(
    id: json["id"],
    parentCategoryId: json["parentCategoryId"],
    type: json["type"],
    title: json["title"],
    image: json["image"],
    video: json["video"],
    videoUrl: json["videoUrl"],
    imageUrl: json["imageUrl"],
    totalLibraryDuration: json["totalLibraryDuration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parentCategoryId": parentCategoryId,
    "type": type,
    "title": title,
    "image": image,
    "video": video,
    "videoUrl": videoUrl,
    "imageUrl": imageUrl,
    "totalLibraryDuration": totalLibraryDuration,
  };
}
