// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
  int? status;
  String? message;
  Result? result;

  RoleModel({
    this.status,
    this.message,
    this.result,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        status: json["status"],
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
  List<Role> roles;

  Result({
    required this.roles,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}

class Role {
  String id;
  String roleName;
  DateTime createdAt;
  DateTime updatedAt;
  var isSelected = false.obs;

  Role({
    required this.id,
    required this.roleName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        roleName: json["roleName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
