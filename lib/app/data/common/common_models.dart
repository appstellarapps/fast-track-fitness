import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/*class TrainingModeModel {
  TrainingModeModel({this.title});
  String? title;
  var isSelected = false.obs;
}*/

class FiltersModel {
  FiltersModel({this.title});
  String? title;
  var isExpand = false.obs;
}

class RatingFilterModel {
  RatingFilterModel({this.title});
  String? title;
  var isSelected = false.obs;
}

class ShiftingFilter {
  ShiftingFilter({this.id, this.title});
  String? id;
  String? title;
  // String? timing;
  var isSelected = false.obs;
}

class KidFriendlyFilterModel {
  KidFriendlyFilterModel({this.title});
  String? title;
  var isSelected = false.obs;
}

class AchievementsModel {
  AchievementsModel({this.title, this.mediaUrl});
  String? title;
  String? mediaUrl;
  var isSelected = false.obs;
}

class UploadNewMedia {
  UploadNewMedia(
      {this.title,
      this.mediaFile,
      this.mediaType,
      this.thumbnail,
      this.inputController,
      this.inputKey});
  String? title;
  String? mediaFile;
  String? mediaType;
  String? thumbnail;
  TextEditingController? inputController;
  GlobalKey? inputKey;
  var hasUploading = false.obs;
  var haseUploaded = false.obs;
}

class EditTrainingTypeListModel {
  EditTrainingTypeListModel({
    this.title,
    this.id,
    this.inputController,
    this.price,
    this.priceOption,
  });
  String? title;
  String? id;
  String? price;
  var priceOption;
  TextEditingController? inputController;
}

class TrainerMediaModel {
  TrainerMediaModel({
    this.id,
    this.userId,
    this.title,
    this.mediaFile,
    this.mediaFileURL,
    this.mediaFileType,
    this.timing,
    this.description,
    this.thumbnailFileName,
    this.thumbnailFileURL,
    this.createdAt,
    this.createdDateFormat,
  });
  var id;
  var userId;
  var title;
  var mediaFile;
  var mediaFileURL;
  var mediaFileType;
  var timing;
  var description;
  var thumbnailFileName;
  var thumbnailFileURL;
  var createdAt;
  var createdDateFormat;
  var isSelected = false.obs;
}

class ResourceExercise {
  ResourceExercise({required this.resourceExerciseId, required this.setList});

  String? resourceExerciseId;
  List<Sets>? setList;

  // Convert ResourceExercise object to JSON
  Map<String, dynamic> toJson() {
    return {
      'resourceExerciseId': resourceExerciseId,
      'sets': setList?.map((set) => set.toJson()).toList(),
    };
  }

  ResourceExercise.fromJson(Map<String, dynamic> json)
      : resourceExerciseId = json['resourceExerciseId'],
        setList = List<Sets>.from(json["sets"].map((x) => Sets.fromJson(x)));
}

class Sets {
  Sets({required this.reps, required this.weight});

  int? reps;
  int? weight;

  // Convert Sets object to JSON
  Map<String, dynamic> toJson() {
    return {
      'reps': reps,
      'weight': weight,
    };
  }

  Sets.fromJson(Map<String, dynamic> json)
      : reps = json['reps'],
        weight = json['weight'];
}

class NutritionalWorkout {
  NutritionalWorkout({required this.name, required this.meals});
  String name;
  List<String> meals;

  // Method to convert NutritionalWorkout object to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'meals': meals,
    };
  }

  // Factory method to create a NutritionalWorkout object from a Map (JSON)
  factory NutritionalWorkout.fromJson(Map<String, dynamic> json) {
    return NutritionalWorkout(
      name: json['name'],
      meals: json['meals'],
    );
  }
}
