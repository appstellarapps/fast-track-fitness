// To parse this JSON data, do
//
//     final searchUserModel = searchUserModelFromJson(jsonString);

import 'dart:convert';

SearchUserModel searchUserModelFromJson(String str) => SearchUserModel.fromJson(json.decode(str));

String searchUserModelToJson(SearchUserModel data) => json.encode(data.toJson());

class SearchUserModel {
  int status;
  String message;
  Result result;

  SearchUserModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory SearchUserModel.fromJson(Map<String, dynamic> json) => SearchUserModel(
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
  List<SearchUser> data;
  int hasMoreResults;

  Result({
    required this.data,
    required this.hasMoreResults,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<SearchUser>.from(json["data"].map((x) => SearchUser.fromJson(x))),
        hasMoreResults: json["hasMoreResults"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "hasMoreResults": hasMoreResults,
      };
}

class SearchUser {
  String id;
  int isActive;
  String roleName;
  String profileImageShortName;
  String fullName;
  String title;
  String profileImage;
  String address;

  SearchUser({
    required this.id,
    required this.isActive,
    required this.roleName,
    required this.profileImageShortName,
    required this.fullName,
    required this.title,
    required this.profileImage,
    required this.address,
  });

  factory SearchUser.fromJson(Map<String, dynamic> json) => SearchUser(
        id: json["id"],
        isActive: json["isActive"],
        roleName: json["roleName"],
        profileImageShortName: json["profileImageShortName"],
        fullName: json["fullName"],
        title: json["title"],
        profileImage: json["profileImage"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isActive": isActive,
        "roleName": roleName,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName,
        "title": title,
        "profileImage": profileImage,
        "address": address,
      };
}
