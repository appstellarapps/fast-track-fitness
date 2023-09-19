// To parse this JSON data, do
//
//     final updateTrainerProfileModel = updateTrainerProfileModelFromJson(jsonString);
import 'dart:convert';

UpdateTrainerProfileModel updateTrainerProfileModelFromJson(String str) =>
    UpdateTrainerProfileModel.fromJson(json.decode(str));

String updateTrainerProfileModelToJson(UpdateTrainerProfileModel data) =>
    json.encode(data.toJson());

class UpdateTrainerProfileModel {
  UpdateTrainerProfileModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  Result? result;

  factory UpdateTrainerProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateTrainerProfileModel(
        status: json["status"],
        message: json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result == null ? null : result!.toJson(),
      };
}

class Result {
  Result({
    this.user,
  });

  User? user;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.profilePic,
    this.email,
    this.emailVerifiedAt,
    this.countryCode,
    this.phoneNumber,
    this.isActive,
    this.otp,
    this.otpCreatedDate,
    this.otpVerified,
    this.address,
    this.latitude,
    this.longitude,
    this.gender,
    this.age,
    this.isPrivate,
    this.punchLine,
    this.expInYear,
    this.charges,
    this.averageRatting,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.roleName,
    this.profileImageShortName,
    this.fullName,
    this.cCodePhoneNumber,
    this.profileImage,
    this.userShiftTimming,
    this.userTrainingTypes,
    this.userTrainingModes,
    this.userQualificationFiles,
    this.usertrainerMedia,
    this.userAchievementFiles,
    this.trainerReview,
  });

  var id;
  var roleId;
  var firstName;
  var lastName;
  var profilePic;
  var email;
  var emailVerifiedAt;
  var countryCode;
  var phoneNumber;
  var isActive;
  var otp;
  var otpCreatedDate;
  var otpVerified;
  var address;
  var latitude;
  var longitude;
  var gender;
  var age;
  var isPrivate;
  var punchLine;
  var expInYear;
  var charges;
  var averageRatting;
  var createdAt;
  var updatedAt;
  var deletedAt;
  var roleName;
  var profileImageShortName;
  var fullName;
  var cCodePhoneNumber;
  var profileImage;
  UserEditedShiftTimming? userShiftTimming;
  List<UserEditedTrainingType>? userTrainingTypes;
  List<UserEditedTrainingMode>? userTrainingModes;
  List<UserEditedQualificationFile>? userQualificationFiles;
  List<Map<String, String>>? usertrainerMedia;
  List<UserEditedAchievementFile>? userAchievementFiles;
  List<TrainerEditedReview>? trainerReview;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
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
        otpCreatedDate:
            json["otpCreatedDate"] == null ? null : DateTime.parse(json["otpCreatedDate"]),
        otpVerified: json["otpVerified"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        gender: json["gender"],
        age: json["age"],
        isPrivate: json["isPrivate"],
        punchLine: json["punchLine"],
        expInYear: json["expInYear"],
        charges: json["charges"],
        averageRatting: json["averageRatting"] == null ? null : json["averageRatting"].toDouble(),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        roleName: json["roleName"],
        profileImageShortName: json["profileImageShortName"],
        fullName: json["fullName"],
        cCodePhoneNumber: json["cCodePhoneNumber"],
        profileImage: json["profileImage"],
        userShiftTimming: json["userShiftTimming"] == null
            ? null
            : UserEditedShiftTimming.fromJson(json["userShiftTimming"]),
        userTrainingTypes: json["userTrainingTypes"] == null
            ? null
            : List<UserEditedTrainingType>.from(
                json["userTrainingTypes"].map((x) => UserEditedTrainingType.fromJson(x))),
        userTrainingModes: json["userTrainingModes"] == null
            ? null
            : List<UserEditedTrainingMode>.from(
                json["userTrainingModes"].map((x) => UserEditedTrainingMode.fromJson(x))),
        userQualificationFiles: json["userQualificationFiles"] == null
            ? null
            : List<UserEditedQualificationFile>.from(
                json["userQualificationFiles"].map((x) => UserEditedQualificationFile.fromJson(x))),
        usertrainerMedia: json["usertrainerMedia"] == null
            ? null
            : List<Map<String, String>>.from(json["usertrainerMedia"]
                .map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
        userAchievementFiles: json["userAchievementFiles"] == null
            ? null
            : List<UserEditedAchievementFile>.from(
                json["userAchievementFiles"].map((x) => UserEditedAchievementFile.fromJson(x))),
        trainerReview: json["trainerReview"] == null
            ? null
            : List<TrainerEditedReview>.from(
                json["trainerReview"].map((x) => TrainerEditedReview.fromJson(x))),
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
        "otpCreatedDate": otpCreatedDate,
        "otpVerified": otpVerified,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "gender": gender,
        "age": age,
        "isPrivate": isPrivate,
        "punchLine": punchLine,
        "expInYear": expInYear,
        "charges": charges,
        "averageRatting": averageRatting,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
        "roleName": roleName,
        "profileImageShortName": profileImageShortName,
        "fullName": fullName,
        "cCodePhoneNumber": cCodePhoneNumber,
        "profileImage": profileImage,
        "userShiftTimming": userShiftTimming == null ? null : userShiftTimming!.toJson(),
        "userTrainingTypes": userTrainingTypes == null
            ? null
            : List<dynamic>.from(userTrainingTypes!.map((x) => x.toJson())),
        "userTrainingModes": userTrainingModes == null
            ? null
            : List<dynamic>.from(userTrainingModes!.map((x) => x.toJson())),
        "userQualificationFiles": userQualificationFiles == null
            ? null
            : List<dynamic>.from(userQualificationFiles!.map((x) => x.toJson())),
        "usertrainerMedia": usertrainerMedia == null
            ? null
            : List<dynamic>.from(usertrainerMedia!
                .map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "userAchievementFiles": userAchievementFiles == null
            ? null
            : List<dynamic>.from(userAchievementFiles!.map((x) => x.toJson())),
        "trainerReview": trainerReview == null
            ? null
            : List<dynamic>.from(trainerReview!.map((x) => x.toJson())),
      };
}

class TrainerEditedReview {
  TrainerEditedReview({
    this.id,
    this.traineeId,
    this.trainerId,
    this.ratting,
    this.description,
    this.createdAt,
    this.published,
    this.trainee,
  });

  var id;
  var traineeId;
  var trainerId;
  var ratting;
  var description;
  var createdAt;
  var published;
  Trainee? trainee;

  factory TrainerEditedReview.fromJson(Map<String, dynamic> json) => TrainerEditedReview(
        id: json["id"],
        traineeId: json["traineeId"],
        trainerId: json["trainerId"],
        ratting: json["ratting"] == null ? null : json["ratting"].toDouble(),
        description: json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        published: json["published"],
        trainee: json["trainee"] == null ? null : Trainee.fromJson(json["trainee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "traineeId": traineeId,
        "trainerId": trainerId,
        "ratting": ratting,
        "description": description,
        "createdAt": createdAt,
        "published": published,
        "trainee": trainee == null ? null : trainee!.toJson(),
      };
}

class Trainee {
  Trainee({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  var id;
  var firstName;
  var lastName;
  var profileImage;

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

class UserEditedAchievementFile {
  UserEditedAchievementFile({
    this.id,
    this.userId,
    this.title,
    this.achievementFile,
    this.achievementFileUrl,
    this.achievementType,
    this.thumbnailFileName,
    this.thumbnailFileUrl,
  });

  var id;
  var userId;
  var title;
  var achievementFile;
  var achievementFileUrl;
  var achievementType;
  var thumbnailFileName;
  var thumbnailFileUrl;

  factory UserEditedAchievementFile.fromJson(Map<String, dynamic> json) =>
      UserEditedAchievementFile(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        achievementFile: json["achievementFile"],
        achievementFileUrl: json["achievementFileURL"],
        achievementType: json["achievementType"],
        thumbnailFileName: json["thumbnailFileName"],
        thumbnailFileUrl: json["thumbnailFileURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "achievementFile": achievementFile,
        "achievementFileURL": achievementFileUrl,
        "achievementType": achievementType,
        "thumbnailFileName": thumbnailFileName,
        "thumbnailFileURL": thumbnailFileUrl,
      };
}

class UserEditedQualificationFile {
  UserEditedQualificationFile({
    this.id,
    this.userId,
    this.title,
    this.qualificationFile,
    this.qulificationfileUrl,
  });

  var id;
  var userId;
  var title;
  var qualificationFile;
  var qulificationfileUrl;

  factory UserEditedQualificationFile.fromJson(Map<String, dynamic> json) =>
      UserEditedQualificationFile(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        qualificationFile: json["qualificationFile"],
        qulificationfileUrl: json["qulificationfileURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "qualificationFile": qualificationFile,
        "qulificationfileURL": qulificationfileUrl,
      };
}

class UserEditedShiftTimming {
  UserEditedShiftTimming({
    this.id,
    this.userId,
    this.morningStartTime,
    this.morningEndTime,
    this.morningWeek,
    this.eveningStartTime,
    this.eveningEndTime,
    this.eveningWeek,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  var id;
  var userId;
  var morningStartTime;
  var morningEndTime;
  List<String>? morningWeek;
  var eveningStartTime;
  var eveningEndTime;
  List<String>? eveningWeek;
  var createdAt;
  var updatedAt;
  var deletedAt;

  factory UserEditedShiftTimming.fromJson(Map<String, dynamic> json) => UserEditedShiftTimming(
        id: json["id"],
        userId: json["userId"],
        morningStartTime: json["morningStartTime"],
        morningEndTime: json["morningEndTime"],
        morningWeek: json["morningWeek"] == null
            ? null
            : List<String>.from(json["morningWeek"].map((x) => x)),
        eveningStartTime: json["eveningStartTime"],
        eveningEndTime: json["eveningEndTime"],
        eveningWeek: json["eveningWeek"] == null
            ? null
            : List<String>.from(json["eveningWeek"].map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "morningStartTime": morningStartTime,
        "morningEndTime": morningEndTime,
        "morningWeek": morningWeek == null ? null : List<dynamic>.from(morningWeek!.map((x) => x)),
        "eveningStartTime": eveningStartTime,
        "eveningEndTime": eveningEndTime,
        "eveningWeek": eveningWeek == null ? null : List<dynamic>.from(eveningWeek!.map((x) => x)),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
      };
}

class UserEditedTrainingMode {
  UserEditedTrainingMode({
    this.id,
    this.userId,
    this.trainingModesId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.trainingMode,
  });

  var id;
  var userId;
  var trainingModesId;
  var createdAt;
  var updatedAt;
  var deletedAt;
  Training? trainingMode;

  factory UserEditedTrainingMode.fromJson(Map<String, dynamic> json) => UserEditedTrainingMode(
        id: json["id"],
        userId: json["userId"],
        trainingModesId: json["trainingModesId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        trainingMode: json["trainingMode"] == null ? null : Training.fromJson(json["trainingMode"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trainingModesId": trainingModesId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
        "trainingMode": trainingMode == null ? null : trainingMode!.toJson(),
      };
}

class Training {
  Training({
    this.id,
    this.title,
    this.isActive,
  });

  var id;
  var title;
  int? isActive;

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

class UserEditedTrainingType {
  UserEditedTrainingType({
    this.id,
    this.userId,
    this.trainingTypesId,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.trainingType,
  });

  var id;
  var userId;
  var trainingTypesId;
  var price;
  var createdAt;
  var updatedAt;
  var deletedAt;
  Training? trainingType;

  factory UserEditedTrainingType.fromJson(Map<String, dynamic> json) => UserEditedTrainingType(
        id: json["id"],
        userId: json["userId"],
        trainingTypesId: json["trainingTypesId"],
        price: json["price"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        trainingType: json["trainingType"] == null ? null : Training.fromJson(json["trainingType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trainingTypesId": trainingTypesId,
        "price": price,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
        "trainingType": trainingType == null ? null : trainingType!.toJson(),
      };
}
