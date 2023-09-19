// To parse this JSON data, do
//
//     final getTrainerProfileDetailModel = getTrainerProfileDetailModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';

GetTrainerProfileDetailModel getTrainerProfileDetailModelFromJson(String str) =>
    GetTrainerProfileDetailModel.fromJson(json.decode(str));

String getTrainerProfileDetailModelToJson(GetTrainerProfileDetailModel data) =>
    json.encode(data.toJson());

class GetTrainerProfileDetailModel {
  dynamic status;
  String? message;
  Result? result;

  GetTrainerProfileDetailModel({
    this.status,
    this.message,
    this.result,
  });

  factory GetTrainerProfileDetailModel.fromJson(Map<String, dynamic> json) =>
      GetTrainerProfileDetailModel(
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
  User user;

  Result({
    required this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  String id;
  String roleId;
  String firstName;
  String lastName;
  String profilePic;
  String email;
  String emailVerifiedAt;
  String countryCode;
  dynamic phoneNumber;
  dynamic isActive;
  dynamic otp;
  DateTime otpCreatedDate;
  dynamic otpVerified;
  String address;
  String latitude;
  String longitude;
  String gender;
  String dateOfBirth;
  int age;
  dynamic isPrivate;
  String specialistId;
  dynamic expInYear;
  dynamic charges;
  dynamic averageRatting;
  String deviceToken;
  String stripeId;
  dynamic isSubscribed;
  String qualificationFileStatus;
  String qualificationFileDescription;
  dynamic isResourceSubscribed;
  dynamic isFreeTrail;
  dynamic isProfileVerified;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  String roleName;
  String profileImageShortName;
  String fullName;
  String cCodePhoneNumber;
  String profileImage;
  String badge;
  int usertrainerMediaCount;
  int userAchievementFilesCount;
  dynamic reviewAverage;
  dynamic reviewsCount;
  int kidFriendly;
  UserSpecialist userSpecialist;
  UserShiftTimming userShiftTimming;
  List<UserBadges> userBadges;
  List<UserTrainingType> userTrainingTypes;
  List<UserTrainingMode> userTrainingModes;
  List<UserQualificationFile> userQualificationFiles;
  List<UserQualificationFile> userInsuranceFiles;

  List<UsertrainerMedia> usertrainerMedia;
  List<UserAchievementFile> userAchievementFiles;
  List<TrainerReview> trainerReview;

  User(
      {required this.id,
      required this.roleId,
      required this.firstName,
      required this.lastName,
      required this.profilePic,
      required this.email,
      required this.emailVerifiedAt,
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
      required this.isPrivate,
      required this.specialistId,
      required this.expInYear,
      required this.dateOfBirth,
      required this.age,
      required this.charges,
      required this.averageRatting,
      required this.deviceToken,
      required this.stripeId,
      required this.isSubscribed,
      required this.qualificationFileStatus,
      required this.qualificationFileDescription,
      required this.isResourceSubscribed,
      required this.isFreeTrail,
      required this.isProfileVerified,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.roleName,
      required this.profileImageShortName,
      required this.fullName,
      required this.cCodePhoneNumber,
      required this.profileImage,
      required this.usertrainerMediaCount,
      required this.userAchievementFilesCount,
      required this.badge,
      required this.reviewAverage,
      required this.reviewsCount,
      required this.userSpecialist,
      required this.userShiftTimming,
      required this.userBadges,
      required this.userTrainingTypes,
      required this.userTrainingModes,
      required this.userQualificationFiles,
      required this.usertrainerMedia,
      required this.userAchievementFiles,
      required this.trainerReview,
      required this.userInsuranceFiles,
      required this.kidFriendly});

  factory User.fromJson(Map<String, dynamic>? json) => User(
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
        dateOfBirth: json["dateOfBirth"],
        age: json["age"],
        isPrivate: json["isPrivate"],
        specialistId: json["specialistId"],
        expInYear: json["expInYear"],
        charges: json["charges"],
        averageRatting: json["averageRatting"],
        deviceToken: json["deviceToken"],
        stripeId: json["stripeId"],
        isSubscribed: json["isSubscribed"],
        qualificationFileStatus: json["qualificationFileStatus"],
        qualificationFileDescription: json["qualificationFileDescription"],
        isResourceSubscribed: json["isResourceSubscribed"],
        isFreeTrail: json["isFreeTrail"],
        isProfileVerified: json["isProfileVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        roleName: json["roleName"],
        profileImageShortName: json["profileImageShortName"],
        fullName: json["fullName"],
        cCodePhoneNumber: json["cCodePhoneNumber"],
        profileImage: json["profileImage"],
        usertrainerMediaCount: json["usertrainerMediaCount"],
        userAchievementFilesCount: json["userAchievementFilesCount"],
        badge: json["badge"] ?? "",
        reviewAverage: json["reviewAverage"],
        reviewsCount: json["reviewsCount"],
        kidFriendly: json['isKidFriendly'] ?? 0,
        userSpecialist: json["userSpecialist"] != ""
            ? UserSpecialist.fromJson(json["userSpecialist"])
            : UserSpecialist(id: "", userId: "", title: "", isActive: 0),
        userShiftTimming: UserShiftTimming.fromJson(json["userShiftTimming"]),
        userBadges: List<UserBadges>.from(
            json["userBadges"].map((x) => UserBadges.fromJson(x))),
        userTrainingTypes: List<UserTrainingType>.from(
            json["userTrainingTypes"].map((x) => UserTrainingType.fromJson(x))),
        userTrainingModes: List<UserTrainingMode>.from(
            json["userTrainingModes"].map((x) => UserTrainingMode.fromJson(x))),
        userQualificationFiles: List<UserQualificationFile>.from(
            json["userQualificationFiles"]
                .map((x) => UserQualificationFile.fromJson(x))),
        userInsuranceFiles: List<UserQualificationFile>.from(
            json["userInsuranceFiles"]
                .map((x) => UserQualificationFile.fromJson(x))),
        usertrainerMedia: List<UsertrainerMedia>.from(
            json["usertrainerMedia"].map((x) => UsertrainerMedia.fromJson(x))),
        userAchievementFiles: List<UserAchievementFile>.from(
            json["userAchievementFiles"]
                .map((x) => UserAchievementFile.fromJson(x))),
        trainerReview: List<TrainerReview>.from(
            json["trainerReview"].map((x) => TrainerReview.fromJson(x))),
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
        "dateOfBirth": dateOfBirth,
        "age": age,
        "isPrivate": isPrivate,
        "specialistId": specialistId,
        "expInYear": expInYear,
        "charges": charges,
        "averageRatting": averageRatting,
        "deviceToken": deviceToken,
        "stripeId": stripeId,
        "isSubscribed": isSubscribed,
        "qualificationFileStatus": qualificationFileStatus,
        "qualificationFileDescription": qualificationFileDescription,
        "isResourceSubscribed": isResourceSubscribed,
        "isFreeTrail": isFreeTrail,
        "isProfileVerified": isProfileVerified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "roleName": roleName,
        "isKidFriendly": kidFriendly,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName,
        "cCodePhoneNumber": cCodePhoneNumber,
        "profileImage": profileImage,
        "usertrainerMediaCount": usertrainerMediaCount,
        "userAchievementFilesCount": userAchievementFilesCount,
        "badge": badge,
        "reviewAverage": reviewAverage,
        "reviewsCount": reviewsCount,
        "userSpecialist": userSpecialist.toJson(),
        "userShiftTimming": userShiftTimming.toJson(),
        "userBadges": List<dynamic>.from(userBadges.map((x) => x.toJson())),
        "userTrainingTypes":
            List<dynamic>.from(userTrainingTypes.map((x) => x.toJson())),
        "userTrainingModes":
            List<dynamic>.from(userTrainingModes.map((x) => x.toJson())),
        "userQualificationFiles":
            List<dynamic>.from(userQualificationFiles.map((x) => x.toJson())),
        "usertrainerMedia":
            List<dynamic>.from(usertrainerMedia.map((x) => x.toJson())),
        "userAchievementFiles":
            List<dynamic>.from(userAchievementFiles.map((x) => x.toJson())),
        "trainerReview":
            List<dynamic>.from(trainerReview.map((x) => x.toJson())),
        'userInsuranceFiles':
            List<dynamic>.from(userQualificationFiles.map((x) => x.toJson())),
      };
}

class TrainerReview {
  String id;
  String traineeId;
  String trainerId;
  String badgeId;
  String badgeUrl;
  dynamic ratting;
  String description;
  DateTime createdAt;
  String published;
  Trainee trainee;

  TrainerReview({
    required this.id,
    required this.traineeId,
    required this.trainerId,
    required this.badgeId,
    required this.badgeUrl,
    required this.ratting,
    required this.description,
    required this.createdAt,
    required this.published,
    required this.trainee,
  });

  factory TrainerReview.fromJson(Map<String, dynamic> json) => TrainerReview(
        id: json["id"],
        traineeId: json["traineeId"],
        trainerId: json["trainerId"],
        badgeId: json["badgeId"],
        badgeUrl: json["badgeUrl"],
        ratting: json["ratting"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        published: json["published"],
        trainee: Trainee.fromJson(json["trainee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "traineeId": traineeId,
        "trainerId": trainerId,
        "badgeId": badgeId,
        "badgeUrl": badgeUrl,
        "ratting": ratting,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "published": published,
        "trainee": trainee.toJson(),
      };
}

class Trainee {
  String id;
  String firstName;
  String lastName;
  String profileImage;

  Trainee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory Trainee.fromJson(Map<String, dynamic> json) => Trainee(
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

class UserAchievementFile {
  String id;
  String userId;
  String title;
  String timming;
  String achievementFile;
  String achievementFileUrl;
  String achievementType;
  String thumbnailFileName;
  String thumbnailFileUrl;
  var isSelected = false.obs;
  String createdDateFormat;

  UserAchievementFile({
    required this.id,
    required this.userId,
    required this.title,
    required this.timming,
    required this.achievementFile,
    required this.achievementFileUrl,
    required this.achievementType,
    required this.thumbnailFileName,
    required this.thumbnailFileUrl,
    required this.createdDateFormat,
  });

  factory UserAchievementFile.fromJson(Map<String, dynamic> json) =>
      UserAchievementFile(
        id: json["id"],
        userId: json["userId"],
        title: json["title"]!,
        timming: json["timming"]!,
        achievementFile: json["achievementFile"],
        achievementFileUrl: json["achievementFileURL"],
        achievementType: json["achievementType"]!,
        thumbnailFileName: json["thumbnailFileName"],
        thumbnailFileUrl: json["thumbnailFileURL"],
        createdDateFormat: json["createdDateFormat"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "timming": timming,
        "achievementFile": achievementFile,
        "achievementFileURL": achievementFileUrl,
        "achievementType": achievementType,
        "thumbnailFileName": thumbnailFileName,
        "thumbnailFileURL": thumbnailFileUrl,
        "createdDateFormat": createdDateFormat,
      };
}

class UserQualificationFile {
  String id;
  String userId;
  String title;
  String qualificationFile;
  String qulificationfileUrl;
  String status;

  UserQualificationFile(
      {required this.id,
      required this.userId,
      required this.title,
      required this.qualificationFile,
      required this.qulificationfileUrl,
      required this.status});

  factory UserQualificationFile.fromJson(Map<String, dynamic> json) =>
      UserQualificationFile(
          id: json["id"],
          userId: json["userId"],
          title: json["title"]!,
          qualificationFile: json["qualificationFile"],
          qulificationfileUrl: json["qulificationfileURL"],
          status: json['status'] ?? "Rejected");

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "qualificationFile": qualificationFile,
        "qulificationfileURL": qulificationfileUrl,
        'status': status
      };
}

class UserShiftTimming {
  String id;
  String userId;
  String morningStartTime;
  String morningEndTime;
  List<dynamic> morningWeek;
  String eveningStartTime;
  String eveningEndTime;
  List<String> eveningWeek;

  UserShiftTimming({
    required this.id,
    required this.userId,
    required this.morningStartTime,
    required this.morningEndTime,
    required this.morningWeek,
    required this.eveningStartTime,
    required this.eveningEndTime,
    required this.eveningWeek,
  });

  factory UserShiftTimming.fromJson(Map<String, dynamic>? json) =>
      UserShiftTimming(
        id: json!["id"] ?? "",
        userId: json["userId"] ?? "",
        morningStartTime: json["morningStartTime"] ?? "",
        morningEndTime: json["morningEndTime"] ?? "",
        morningWeek: json["morningWeek"] != null
            ? List<dynamic>.from(json["morningWeek"].map((x) => x))
            : [],
        eveningStartTime: json["eveningStartTime"] ?? "",
        eveningEndTime: json["eveningEndTime"] ?? "",
        eveningWeek: json["eveningWeek"] != null
            ? List<String>.from(json["eveningWeek"].map((x) => x))
            : [],
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
      };
}

class UserSpecialist {
  String id;
  String userId;
  String title;
  dynamic isActive;

  UserSpecialist({
    required this.id,
    required this.userId,
    required this.title,
    required this.isActive,
  });

  factory UserSpecialist.fromJson(Map<String, dynamic> json) => UserSpecialist(
        id: json["id"] ?? "",
        userId: json["userId"] ?? "",
        title: json["title"] ?? "",
        isActive: json["isActive"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "isActive": isActive,
      };
}

class UserTrainingMode {
  String id;
  String userId;
  String trainingModesId;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  Training trainingMode;

  UserTrainingMode({
    required this.id,
    required this.userId,
    required this.trainingModesId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.trainingMode,
  });

  factory UserTrainingMode.fromJson(Map<String, dynamic> json) =>
      UserTrainingMode(
        id: json["id"],
        userId: json["userId"],
        trainingModesId: json["trainingModesId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        trainingMode: Training.fromJson(json["trainingMode"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trainingModesId": trainingModesId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "trainingMode": trainingMode.toJson(),
      };
}

class Training {
  String id;
  String title;
  dynamic isActive;

  Training({
    required this.id,
    required this.title,
    required this.isActive,
  });

  factory Training.fromJson(Map<String, dynamic> json) => Training(
        id: json["id"],
        title: json["title"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "isActive": isActive,
      };
}

class UserBadges {
  String id;
  String userId;
  String badgeId;
  String type;
  int badgeCount;
  String badgeUrl;

  UserBadges({
    required this.id,
    required this.userId,
    required this.badgeId,
    required this.type,
    required this.badgeCount,
    required this.badgeUrl,
  });

  factory UserBadges.fromJson(Map<String, dynamic>? json) => UserBadges(
        id: json!["id"],
        userId: json["userId"],
        badgeId: json["badgeId"],
        type: json["type"],
        badgeCount: json["badgeCount"],
        badgeUrl: json["badgeUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "badgeId": badgeId,
        "type": type,
        "badgeCount": badgeCount,
        "badgeUrl": badgeUrl,
      };
}

class UserTrainingType {
  String id;
  String userId;
  String trainingTypesId;
  dynamic price;
  String priceOption;
  Training trainingType;

  UserTrainingType({
    required this.id,
    required this.userId,
    required this.trainingTypesId,
    required this.price,
    required this.priceOption,
    required this.trainingType,
  });

  factory UserTrainingType.fromJson(Map<String, dynamic>? json) =>
      UserTrainingType(
        id: json!["id"],
        userId: json["userId"],
        trainingTypesId: json["trainingTypesId"],
        price: json["price"],
        priceOption: json["priceOption"],
        trainingType: Training.fromJson(json["trainingType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trainingTypesId": trainingTypesId,
        "price": price,
        "priceOption": priceOption,
        "trainingType": trainingType.toJson(),
      };
}

class UsertrainerMedia {
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
  var isSelected = false.obs;
  String createdDateFormat;

  UsertrainerMedia({
    required this.id,
    required this.userId,
    required this.title,
    required this.mediaFile,
    required this.mediaFileUrl,
    required this.mediaFileType,
    required this.timming,
    required this.description,
    required this.thumbnailFileName,
    required this.thumbnailFileUrl,
    required this.createdDateFormat,
  });

  factory UsertrainerMedia.fromJson(Map<String, dynamic> json) =>
      UsertrainerMedia(
        id: json["id"],
        userId: json["userId"],
        title: json["title"]!,
        mediaFile: json["mediaFile"],
        mediaFileUrl: json["mediaFileURL"],
        mediaFileType: json["mediaFileType"]!,
        timming: json["timming"]!,
        description: json["description"]!,
        thumbnailFileName: json["thumbnailFileName"],
        thumbnailFileUrl: json["thumbnailFileURL"],
        createdDateFormat: json["createdDateFormat"]!,
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
