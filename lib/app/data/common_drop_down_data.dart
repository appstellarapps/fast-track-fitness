// To parse this JSON data, do
//
//     final getStaticDdData = getStaticDdDataFromJson(jsonString);

import 'dart:convert';

GetStaticDdData getStaticDdDataFromJson(String str) => GetStaticDdData.fromJson(json.decode(str));

String getStaticDdDataToJson(GetStaticDdData data) => json.encode(data.toJson());

class GetStaticDdData {
  int status;
  String message;
  Result result;

  GetStaticDdData({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetStaticDdData.fromJson(Map<String, dynamic> json) => GetStaticDdData(
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
  Data data;

  Result({
    required this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  List<int> rattingDropdown;
  List<String> trainingPaymentDropdown;

  Data({
    required this.rattingDropdown,
    required this.trainingPaymentDropdown,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    rattingDropdown: List<int>.from(json["rattingDropdown"].map((x) => x)),
    trainingPaymentDropdown: List<String>.from(json["trainingPaymentDropdown"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "rattingDropdown": List<dynamic>.from(rattingDropdown.map((x) => x)),
    "trainingPaymentDropdown": List<dynamic>.from(trainingPaymentDropdown.map((x) => x)),
  };
}
