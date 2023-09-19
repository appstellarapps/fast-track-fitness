// // To parse this JSON data, do
// //
// //     final traineeSubscripationsModel = traineeSubscripationsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// TraineeSubscripationsModel traineeSubscripationsModelFromJson(String str) =>
//     TraineeSubscripationsModel.fromJson(json.decode(str));
//
// String traineeSubscripationsModelToJson(TraineeSubscripationsModel data) =>
//     json.encode(data.toJson());
//
// class TraineeSubscripationsModel {
//   dynamic? status;
//   String? message;
//   Result? result;
//
//   TraineeSubscripationsModel({
//     this.status,
//     this.message,
//     this.result,
//   });
//
//   factory TraineeSubscripationsModel.fromJson(Map<String, dynamic> json) =>
//       TraineeSubscripationsModel(
//         status: json["status"],
//         message: json["message"],
//         result: Result.fromJson(json["result"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "result": result!.toJson(),
//       };
// }
//
// class Result {
//   List<Subscription> subscription;
//
//   Result({
//     required this.subscription,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         subscription:
//             List<Subscription>.from(json["subscription"].map((x) => Subscription.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "subscription": List<dynamic>.from(subscription.map((x) => x.toJson())),
//       };
// }
//
// class Subscription {
//   String? id;
//   String? name;
//   String? validity;
//   dynamic? validateDays;
//   dynamic? amount;
//   String? iosKey;
//   String? androidKey;
//   String? type;
//
//   Subscription({
//     this.id,
//     this.name,
//     this.validity,
//     this.validateDays,
//     this.amount,
//     this.iosKey,
//     this.androidKey,
//     this.type,
//   });
//
//   factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
//         id: json["id"],
//         name: json["name"],
//         validity: json["validity"],
//         validateDays: json["validateDays"],
//         amount: json["amount"],
//         iosKey: json["iosKey"],
//         androidKey: json["androidKey"],
//         type: json["type"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "validity": validity,
//         "validateDays": validateDays,
//         "amount": amount,
//         "iosKey": iosKey,
//         "androidKey": androidKey,
//         "type": type,
//       };
// }
