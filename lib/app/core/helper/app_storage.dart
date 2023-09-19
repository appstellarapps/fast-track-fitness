import 'dart:convert';

import 'package:fasttrackfitness/app/data/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/custom_local_meal_plan.dart';
import '../../data/get_exercise_details_model.dart';
import '../../data/get_premade_meals_details.dart';
import 'constants.dart';

class AppStorage {
  static late GetStorage box;
  static UserModel userData = UserModel();
  static RxList<Excercise> userSelectedExerciseList = <Excercise>[].obs;
  static RxList<CustomLocalMealPlan> mainCustomMealList = <CustomLocalMealPlan>[].obs;
  static RxList<PreMadeResult> preMadeMealLIst = <PreMadeResult>[].obs;

  static var isCompleted = 0.obs;
  static var fcmToken = '';
  static var isNotificationIsRead = false.obs;

  static initializeApp() async {
    await GetStorage.init('FTF');
    box = GetStorage('FTF');
  }

  static setData(key, value) {
    box.write(key, value);
    box.save();
  }

  static getData(key) {
    if (box.hasData(key)) {
      return box.read(key);
    }
    return null;
  }

  static setModel(key, var model) {
    box.write(key, jsonEncode(model));
  }

  static getModel(key) {
    if (box.hasData(key)) {
      var json = box.read(key);

      return json;
    }
    return null;
  }

  static setAppLogin(bool isUserLoggedIn) {
    box.write(SessionKeys.keyLogin, isUserLoggedIn);
  }

  static isLogin() {
    if (box.hasData(SessionKeys.keyLogin)) {
      return box.read(SessionKeys.keyLogin);
    }
    return false;
  }

  static setAccessToken(String accessToken) {
    box.write(SessionKeys.keyAccessToken, accessToken);
  }

  static getAccessToken() {
    if (box.hasData(SessionKeys.keyAccessToken)) {
      return box.read(SessionKeys.keyAccessToken);
    }
    return null;
  }

  static setUserType(String userType) {
    box.write(SessionKeys.keyUserType, userType);
  }

  static getUserType() {
    if (box.hasData(SessionKeys.keyUserType)) {
      return box.read(SessionKeys.keyUserType);
    }
    return null;
  }

  static getUserId() {
    if (box.hasData(SessionKeys.keyUserId)) {
      return box.read(SessionKeys.keyUserId);
    }
    return '';
  }

  static setLoginProfileModel(UserModel model) {
    box.write(SessionKeys.keyLoginProfile, jsonEncode(model));
  }

  static getLoginProfileModel() {
    if (box.hasData(SessionKeys.keyLoginProfile)) {
      var json = box.read(SessionKeys.keyLoginProfile);
      return json;
    }
    return null;
  }

  static setUserName(String userName) {
    box.write(SessionKeys.keyUserName, userName);
  }

  static getUserName() {
    if (box.hasData(SessionKeys.keyUserName)) {
      return box.read(SessionKeys.keyUserName);
    }
    return '';
  }

  static setUserProfilePic(String profilePic) {
    box.write(SessionKeys.keyUserProfilePic, profilePic);
  }

  static getUserProfilePic() {
    if (box.hasData(SessionKeys.keyUserProfilePic)) {
      return box.read(SessionKeys.keyUserProfilePic);
    }
    return '';
  }
}
