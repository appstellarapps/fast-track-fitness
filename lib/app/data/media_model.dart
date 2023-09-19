// To parse this JSON data, do
//
//     final mediaModel = mediaModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

MediaModel mediaModelFromJson(String str) => MediaModel.fromJson(json.decode(str));

String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel {
  int status;
  String message;
  Result result;

  MediaModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
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
  List<Media> data;
  int hasMoreResults;

  Result({
    required this.data,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<Media>.from(json["data"].map((x) => Media.fromJson(x))),
        hasMoreResults: json["hasMoreResults"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class Media {
  String id;
  String userId;
  String title;
  String mediaFile;
  String mediaFileUrl;
  String mediaFileType;
  String timming;
  String description;
  String thumbnailFileName;
  String thumbnailFileUrl;
  String createdDateFormat;
  var isSelected = false.obs;

  Media({required this.id, required this.userId, required this.title, required this.mediaFile, required this.mediaFileUrl, required this.mediaFileType, required this.timming, required this.description, required this.thumbnailFileName, required this.thumbnailFileUrl, required this.createdDateFormat});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        mediaFile: json["mediaFile"],
        mediaFileUrl: json["mediaFileURL"],
        mediaFileType: json["mediaFileType"]!,
        timming: json["timming"]!,
        description: json["description"] ?? "",
        thumbnailFileName: json["thumbnailFileName"],
        thumbnailFileUrl: json["thumbnailFileURL"],
        createdDateFormat: json["createdDateFormat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "mediaFile": mediaFile,
        "mediaFileURL": mediaFileUrl,
        "mediaFileType": mediaFileType,
        "timming": timming,
        "description": description,
        "thumbnailFileName": thumbnailFileName,
        "thumbnailFileURL": thumbnailFileUrl,
        "createdDateFormat": createdDateFormat,
      };
}
