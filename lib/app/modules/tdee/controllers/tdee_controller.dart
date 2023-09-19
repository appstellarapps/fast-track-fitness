import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/constants.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/tdee_model.dart';
import 'package:get/get.dart';

import '../../trainee/my_diary/controllers/my_diary_controller.dart';
import '../../trainee/trainee_dashboard/trainee_dashboard/controllers/trainee_dashboard_controller.dart';

class TdeeController extends GetxController {
  //TODO: Implement TdeeController

  var protein = 0.0.obs;
  var carbs = 0.0.obs;
  var fat = 0.0.obs;
  var TCI = 0.0.obs;

  var proteinPer = 40.0.obs;
  var carbsPer = 40.0.obs;
  var fatPer = 20.0.obs;
  var isModifyOpen = false.obs;
  var selectedStepsIndex = 1.obs;
  var completedStepsIndex = 1.obs;
  var gender = 1.obs;
  var heightInCM = true.obs;
  var weightInKG = true.obs;
  var height = 148.0.obs;
  var heightMI = 91.0.obs;
  var heightMX = 214.0.obs;
  var weightOfHuman = 40.0.obs;
  var age = 25.obs;
  var touchedIndex = 1.obs;
  var selectedActivityIndex = 1.obs;
  var selectedGoalIndex = 1.obs;

  List<TdeeModel> mainTitle = [
    TdeeModel("ABOUT YOU", "", 0),
    TdeeModel("WHAT IS YOUR ACTIVITY LEVEL", "", 0),
    TdeeModel("WHAT’S YOUR GOAL?", "", 0),
    TdeeModel("TDEE RESULT", "", 0),
    TdeeModel("TDEE RESULT", "", 0),
  ];

  List<TdeeModel> tdeeActivityLevel = [
    TdeeModel("Sedentary", "Little or no exercise e.g. desk job", 1.2),
    TdeeModel("Lightly Active", "Light exercise e.g. exercising 1-3 days per week", 1.375),
    TdeeModel("Moderately Active", "Moderate exercise e.g. exercising 3-5 days per week", 1.55),
    TdeeModel("Very Active", "Heavy exercise e.g. exercise 6-7 days per week", 1.725),
    TdeeModel("Extremely Active", "Very heavy exercise daily combined with a physical job", 1.9),
  ];

  List<TdeeModel> tdeeGoalLevel = [
    TdeeModel("Build Muscle", "Primary goal to build lean muscle and improve strength.", 250),
    TdeeModel("Fat Loss", "Primary goal to lose body fat.", -500),
    TdeeModel("Maintenance",
        "Primary goal to improve performance without gaining or losing any weight.", 0),
  ];

  @override
  void onInit() {
    apiLoader(asyncCall: () => getData());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  calculation() {
    var BMR;
    var TDEE;

    var weight = weightInKG.value ? weightOfHuman.value : 0.453592 * weightOfHuman.value;
    var heigths = heightInCM.value ? height.value : 30.48 * height.value;
    if (gender.value == 1) {
      BMR = (10 * weight) + (6.25 * heigths) - (5 * age.value) + 5;
    } else {
      BMR = (10 * weight) + (6.25 * heigths) - (5 * age.value) - 161;
    }

    TDEE = BMR * tdeeActivityLevel[selectedActivityIndex.value].value;
    TCI.value = TDEE + tdeeGoalLevel[selectedGoalIndex.value].value;
    protein.value = ((proteinPer.value / 100) * TCI.value) / 4;
    carbs.value = ((carbsPer.value / 100) * TCI.value) / 4;
    fat.value = ((fatPer.value / 100) * TCI.value) / 9;
  }

  void convertFeetToCm() {
    height.value = height.value * 30.48;
  }

  void convertCmToFeet() {
    height.value = height.value / 30.48;
  }

  void convertKgToLb() {
    weightOfHuman.value = (weightOfHuman.value * 2.20462).roundToDouble();
  }

  void convertLbToKg() {
    weightOfHuman.value = (weightOfHuman.value / 2.20462).roundToDouble();
  }

  getData() {
    WebServices.postRequest(
      uri: EndPoints.GET_TDEE_DATA,
      body: {},
      hasBearer: true,
      onStatusSuccess: (responseBody) async {
        TdeeDataModel tdeeDataModel = tdeeDataModelFromJson(responseBody);
        if (tdeeDataModel.result != null) {
          gender.value = tdeeDataModel.result!.gender == "Male" ? 1 : 2;
          height.value = tdeeDataModel.result!.height.toDouble();
          heightInCM.value = tdeeDataModel.result!.heightType == "cm" ? true : false;

          if (tdeeDataModel.result!.heightType == 'cm') {
            heightMI.value = 91.0;
            heightMX.value = 214.0;
          } else {
            heightMI.value = 3.0;
            heightMX.value = 7.0;
          }
          weightOfHuman.value = tdeeDataModel.result!.weight;
          weightInKG.value = tdeeDataModel.result!.weightType == "kg" ? true : false;
          age.value = tdeeDataModel.result!.age;
          TCI.value = tdeeDataModel.result!.calories.toDouble();
          protein.value = tdeeDataModel.result!.protein.toDouble();
          proteinPer.value = double.parse(tdeeDataModel.result!.proteinPercentage);
          carbs.value = tdeeDataModel.result!.carbs.toDouble();
          carbsPer.value = double.parse(tdeeDataModel.result!.carbsPercentage);
          fat.value = tdeeDataModel.result!.fat.toDouble();
          fatPer.value = double.parse(tdeeDataModel.result!.fatPercentage);

          for (int i = 0; i < tdeeActivityLevel.length; i++) {
            if (tdeeDataModel.result!.activityLevel == tdeeActivityLevel[i].title) {
              selectedActivityIndex.value = i;
            }
          }
          for (int i = 0; i < tdeeGoalLevel.length; i++) {
            if (tdeeDataModel.result!.goalName == tdeeGoalLevel[i].title) {
              selectedGoalIndex.value = i;
            }
          }
        }
        hideAppLoader();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  sendData() {
    var data = {
      "gender": gender.value == 1 ? "Male" : "Female",
      "height": height.value.toString(),
      "heightType": heightInCM.value ? "cm" : "ft",
      "weight": weightOfHuman.value.toString(),
      "weightType": weightInKG.value ? "kg" : "lb",
      "age": age.value,
      "activityLevel": tdeeActivityLevel[selectedActivityIndex.value].title,
      "goalName": tdeeGoalLevel[selectedGoalIndex.value].title,
      "calories": TCI.value.toInt(),
      "protein": protein.value.toInt(),
      "proteinPercentage": "${proteinPer.value}",
      "carbs": carbs.value.toInt(),
      "carbsPercentage": "${carbsPer.value}",
      "fat": fat.value.toInt(),
      "fatPercentage": "${fatPer.value}"
    };

    WebServices.postRequest(
      uri: EndPoints.SEND_TDEE_DATA,
      body: data,
      hasBearer: true,
      onStatusSuccess: (responseBody) async {
        hideAppLoader();
        Get.back();
        var ctr = Get.put(TraineeDashboardController());
        ctr.selectedTab.value = 2;
        var ctr1 = Get.put(MyDiaryController());
        ctr1.selectTabIndex.value = 0;
        ctr1.onInit();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }
}
