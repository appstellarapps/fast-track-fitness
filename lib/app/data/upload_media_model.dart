// To parse this JSON data, do
//
//     final mediaModel = mediaModelFromJson(jsonString);

import 'dart:convert';

UploadMediaModel uploadMediaModelFromJson(String str) => UploadMediaModel.fromJson(json.decode(str));

String mediaModelToJson(UploadMediaModel data) => json.encode(data.toJson());

class UploadMediaModel {
  int status;
  String message;
  UploadMedia result;

  UploadMediaModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UploadMediaModel.fromJson(Map<String, dynamic> json) => UploadMediaModel(
    status: json["status"],
    message: json["message"],
    result: UploadMedia.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class UploadMedia {
  String id;
  String fileUrl;
  String fileName;
  String thumbnailFileUrl;
  String thumbnailFileName;
  String title;

  UploadMedia({
    required this.id,
    required this.fileUrl,
    required this.fileName,
    required this.thumbnailFileUrl,
    required this.thumbnailFileName,
    required this.title,
  });

  factory UploadMedia.fromJson(Map<String, dynamic> json) => UploadMedia(
    id: json["id"],
    fileUrl: json["fileUrl"],
    fileName: json["fileName"],
    thumbnailFileUrl: json["thumbnailFileUrl"],
    thumbnailFileName: json["thumbnailFileName"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fileUrl": fileUrl,
    "fileName": fileName,
    "thumbnailFileUrl": thumbnailFileUrl,
    "thumbnailFileName": thumbnailFileName,
    "title": title,
  };
}
