import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/StartNutritionalWorkout.dart';

class StartTrackingCaloriesController extends GetxController {
  //TODO: Implement StartTrackingCaloriesController

  ScrollController scrollController = ScrollController();

  var isLoading = true.obs;
  var haseMore = false.obs;
  var page = 1;
  var startNutritionalWorkout = StartNutritionalWorkout();
  var workoutList = <Workout>[].obs;
  var nutritionalList = <NutritionalDetails>[];
  var lastFocusedList = [];
  var lastFocusNodeIndex = 0;

  @override
  void onInit() {
    super.onInit();
    apiLoader(asyncCall: () => startCaloriesWorkout());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    for (var a in workoutList) {
      for (var b in a.workoutNutritionalDaily) {
        for (var c in b.workoutNutritionalMealDaily) {
          c.focusNode.value.dispose();
        }
      }
    }
    super.dispose();
  }

  focusCheck() {
    print("this called");
    for (var a in workoutList) {
      for (var b in a.workoutNutritionalDaily) {
        for (var c in b.workoutNutritionalMealDaily) {
          print("this called");
          c.focusNode.value.addListener(() async {
            if (c.focusNode.value.hasFocus) {
              lastFocusedList.clear();
              lastFocusedList.add(workoutList.indexOf(a));
              lastFocusedList.add(a.workoutNutritionalDaily.indexOf(b));
              lastFocusedList.add(b.workoutNutritionalMealDaily.indexOf(c));
            } else {
              if (c.controller.text.isNotEmpty && c.controller.text != '0') {
                await getMealCalculation(
                    workoutList.indexOf(a),
                    a.workoutNutritionalDaily.indexOf(b),
                    b.workoutNutritionalMealDaily.indexOf(c),
                    c.controller.text);
              }
              lastFocusedList.clear();
            }
          });
        }
      }
    }
  }

  scroll() {
    if (scrollController.position.maxScrollExtent - 500 == scrollController.position.pixels - 500) {
      if (haseMore.value) {
        page++;

        startCaloriesWorkout();
      }
    }
  }

  Future saveNutritionalWork() async {
    // if (lastFocusedList.isNotEmpty) {
    //   List<WorkoutNutritionalMealDaily> tempList = workoutList[lastFocusedList[0]]
    //       .workoutNutritionalDaily[lastFocusedList[1]]
    //       .workoutNutritionalMealDaily;
    //   if (tempList[2].controller.text.isNotEmpty && tempList[2].controller.text != '0') {
    //     await getMealCalculation(
    //         lastFocusedList[0],
    //         lastFocusedList[1],
    //         lastFocusedList[2],
    //         workoutList[lastFocusedList[0]]
    //             .workoutNutritionalDaily[lastFocusedList[1]]
    //             .workoutNutritionalMealDaily[lastFocusedList[2]]
    //             .controller
    //             .text);
    //   }
    // }

    for (var i = 0; i < workoutList.length; i++) {
      for (var j = 0; j < workoutList[i].workoutNutritionalDaily.length; j++) {
        for (var k = 0;
            k < workoutList[i].workoutNutritionalDaily[j].workoutNutritionalMealDaily.length;
            k++) {
          if (workoutList[i]
                  .workoutNutritionalDaily[j]
                  .workoutNutritionalMealDaily[k]
                  .controller
                  .text
                  .isNotEmpty &&
              (workoutList[i]
                          .workoutNutritionalDaily[j]
                          .workoutNutritionalMealDaily[k]
                          .protein
                          .value !=
                      0 ||
                  workoutList[i]
                          .workoutNutritionalDaily[j]
                          .workoutNutritionalMealDaily[k]
                          .fat
                          .value !=
                      0 ||
                  workoutList[i]
                          .workoutNutritionalDaily[j]
                          .workoutNutritionalMealDaily[k]
                          .carbs
                          .value !=
                      0 ||
                  workoutList[i]
                          .workoutNutritionalDaily[j]
                          .workoutNutritionalMealDaily[k]
                          .calories
                          .value !=
                      0)) {
            nutritionalList.add(NutritionalDetails(
                weight: workoutList[i]
                    .workoutNutritionalDaily[j]
                    .workoutNutritionalMealDaily[k]
                    .weight
                    .value,
                workoutId: workoutList[i].workoutNutritionalDaily[j].workoutId,
                carbs: workoutList[i]
                    .workoutNutritionalDaily[j]
                    .workoutNutritionalMealDaily[k]
                    .carbs
                    .value,
                calories: workoutList[i]
                    .workoutNutritionalDaily[j]
                    .workoutNutritionalMealDaily[k]
                    .calories
                    .value,
                protein: workoutList[i]
                    .workoutNutritionalDaily[j]
                    .workoutNutritionalMealDaily[k]
                    .protein
                    .value,
                fat: workoutList[i]
                    .workoutNutritionalDaily[j]
                    .workoutNutritionalMealDaily[k]
                    .fat
                    .value,
                nutritionalMealId:
                    workoutList[i].workoutNutritionalDaily[j].workoutNutritionalMealDaily[k].id));
          }
        }
      }
    }

    if (nutritionalList.isNotEmpty) {
      apiLoader(asyncCall: () => saveNutritionalWorkout());
    } else {
      showSnackBar(title: "Alert", message: "Please enter  consumed value");
    }
  }

  void startCaloriesWorkout() {
    WebServices.postRequest(
      uri: EndPoints.START_NUTRITIONAL_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        startNutritionalWorkout = startNutritionalWorkoutFromJson(responseBody);
        workoutList.addAll(startNutritionalWorkout.result!.workouts);
        haseMore.value = startNutritionalWorkout.result!.hasMoreResults == 0 ? false : true;

        for (var i = 0; i < workoutList.length; i++) {
          for (var j = 0; j < workoutList[i].workoutNutritionalDaily.length; j++) {
            for (var k = 0;
                k < workoutList[i].workoutNutritionalDaily[j].workoutNutritionalMealDaily.length;
                k++) {
              workoutList[i]
                      .workoutNutritionalDaily[j]
                      .workoutNutritionalMealDaily[k]
                      .controller
                      .text =
                  workoutList[i]
                      .workoutNutritionalDaily[j]
                      .workoutNutritionalMealDaily[k]
                      .weight
                      .toString();
            }
          }
        }
        focusCheck();

        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void saveNutritionalWorkout() {
    var body = {'nutritionalMeal': nutritionalList};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.SAVE_NUTRINATION_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        commonBottomSheet(title: "Your nutritional workout saved successfully");
        nutritionalList.clear();
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        nutritionalList.clear();

        isLoading.value = false;
      },
    );
  }

  getMealCalculation(mainIndex, subIndex, subChildIndex, val) {
    List<WorkoutNutritionalMealDaily> workoutNutritionalDailyList =
        workoutList[mainIndex].workoutNutritionalDaily[subIndex].workoutNutritionalMealDaily;
    var body = {
      "workoutId": workoutList[mainIndex].workoutNutritionalDaily[subIndex].workoutId,
      "nutritionalMealId": workoutNutritionalDailyList[subChildIndex].id,
      "weight": int.parse(val),
      "foodname": workoutNutritionalDailyList[subChildIndex].foodName
    };
    WebServices.postRequest(
      uri: EndPoints.GET_MEAL_CALCULATION,
      hasBearer: true,
      body: body,
      hideKeyBoardOnRes: false,
      onStatusSuccess: (responseBody) {
        var res = jsonDecode(responseBody);
        hideAppLoader();
        workoutNutritionalDailyList[subChildIndex].weight.value = int.parse(val);
        Map<String, dynamic> result = res['result'];

        if (result.isNotEmpty) {
          workoutNutritionalDailyList[subChildIndex].calories.value = res['result']['calories'];
          workoutNutritionalDailyList[subChildIndex].protein.value = res['result']['protein'];
          workoutNutritionalDailyList[subChildIndex].carbs.value = res['result']['carbs'];
          workoutNutritionalDailyList[subChildIndex].fat.value = res['result']['fat'];
          isLoading.value = false;
        } else {
          showSnackBar(title: "Alert", message: "Something went wrong");
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}

class NutritionalDetails {
  NutritionalDetails(
      {this.workoutId,
      this.nutritionalMealId,
      this.weight,
      this.calories,
      this.protein,
      this.carbs,
      this.fat});
  String? workoutId;
  String? nutritionalMealId;
  int? weight;
  int? calories;
  int? protein;
  int? carbs;
  int? fat;

  // Method to convert NutritionalWorkout object to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'workoutId': workoutId,
      'nutritionalMealId': nutritionalMealId,
      'weight': weight,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat
    };
  }

  // Factory method to create a NutritionalWorkout object from a Map (JSON)
  factory NutritionalDetails.fromJson(Map<String, dynamic> json) {
    return NutritionalDetails(
        workoutId: json['workoutId'],
        nutritionalMealId: json['nutritionalMealId'],
        weight: json['weight'],
        calories: json['calories'],
        protein: json['protein'],
        carbs: json['carbs'],
        fat: json['fat']);
  }
}
