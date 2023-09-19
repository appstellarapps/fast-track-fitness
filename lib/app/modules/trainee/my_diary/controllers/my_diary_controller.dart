import 'dart:convert';

import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/data/my_diary_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/custom_method.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/nutritional_stats_model.dart';
import '../../../../data/stats_distance_model.dart';

class MyDiaryController extends GetxController {
  TextEditingController startDateCtr = TextEditingController();
  TextEditingController endDateCtr = TextEditingController();

  GlobalKey<CustomTextFormFieldState> startDateKey = GlobalKey<CustomTextFormFieldState>();
  GlobalKey<CustomTextFormFieldState> endDateKey = GlobalKey<CustomTextFormFieldState>();

  var selectTabIndex = 0.obs;
  var selectedStateIndex = 0.obs;
  var workOutSelected = 0.obs;
  var isLoading = true.obs;
  var isTabLoading = true.obs;
  var selectedTypeIndex = 0.obs;

  var diaryExercisesItems = [].obs;
  var diaryNutritionalItems = [].obs;
  var typeList = ['Distance', 'Time'];

  TooltipBehavior tooltip = TooltipBehavior(enable: true);
  Rx<StatsDistanceModel> distanceModel = StatsDistanceModel().obs;
  NutritionalStatsModel nutritionalStatsModel = NutritionalStatsModel();

  @override
  void onInit() {
    if (AppStorage.isLogin()) {
      apiLoader(
          asyncCall: () => getResourceCount(selectTabIndex.value == 0 ? "Exercise" : "Nutrition"));
      startDateCtr.text = CustomMethod.convertDateFormat(
          DateFormat('dd-MM-yyyy').format(DateTime.now()), 'dd-MM-yyyy', 'dd, MMM-yyyy');
      endDateCtr.text = CustomMethod.convertDateFormat(
          DateFormat('dd-MM-yyyy').format(DateTime.now()), 'dd-MM-yyyy', 'dd, MMM-yyyy');
    } else {
      isLoading.value = false;
      startDateCtr.text = CustomMethod.convertDateFormat(
          DateFormat('dd-MM-yyyy').format(DateTime.now()), 'dd-MM-yyyy', 'dd, MMM-yyyy');
      endDateCtr.text = CustomMethod.convertDateFormat(
          DateFormat('dd-MM-yyyy').format(DateTime.now()), 'dd-MM-yyyy', 'dd, MMM-yyyy');
      setData(0);
    }
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

  selectDate(isStartDate) {
    return showDatePicker(
      context: Get.context!,
      initialDate:
          DateFormat("dd, MMM-yyyy").parse(isStartDate ? startDateCtr.text : endDateCtr.text),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      if (value != null) {
        final String formatted = formatter.format(value);
        if (isStartDate) {
          startDateCtr.text =
              CustomMethod.convertDateFormat(formatted, 'dd-MM-yyyy', 'dd, MMM-yyyy');
        } else {
          endDateCtr.text = CustomMethod.convertDateFormat(formatted, 'dd-MM-yyyy', 'dd, MMM-yyyy');
        }
      }
      isTabLoading.value = true;
      if (selectedStateIndex.value == 0) {
        apiLoader(asyncCall: () => getMyExerciseStats());
      } else {
        apiLoader(asyncCall: () => getMyNutritionalStats());
      }
    });
  }

  void getResourceCount(type) {
    if (AppStorage.isLogin()) {
      var body = {"traineeId": AppStorage.userData.result!.user.id, "type": type};
      WebServices.postRequest(
        body: body,
        uri: EndPoints.GET_RESOURCE_COUNT,
        hasBearer: true,
        onStatusSuccess: (responseBody) {
          hideAppLoader();
          isLoading.value = false;
          var data = jsonDecode(responseBody);
          if (data['status'] == 1) {
            var count = data['result']['count'];
            AppStorage.isCompleted.value = data['result']['isCompletedWorkoutCount'];

            setData(count < 10 ? "0$count" : "$count");
          }
        },
        onFailure: (error) {
          hideAppLoader(hideSnacks: false);
        },
      );
    }
  }

  void getMyExerciseStats() {
    if (AppStorage.isLogin()) {
      var body = {
        "traineeId": AppStorage.userData.result!.user.id,
        "startDate": CustomMethod.convertDateFormat(
            startDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
        "endDate": CustomMethod.convertDateFormat(
            endDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
        "type": typeList[selectedTypeIndex.value]
      };
      WebServices.postRequest(
        body: body,
        uri: EndPoints.GET_STATS_DATA,
        hasBearer: true,
        onStatusSuccess: (responseBody) {
          hideAppLoader();
          distanceModel.value = statsDistanceModelFromJson(responseBody);
          distanceModel.refresh();
          isTabLoading.value = false;
        },
        onFailure: (error) {
          hideAppLoader(hideSnacks: false);
          isTabLoading.value = false;
        },
      );
    } else {
      hideAppLoader();
      isTabLoading.value = false;
    }
  }

  void getMyNutritionalStats() {
    var body = {
      "traineeId": AppStorage.userData.result!.user.id,
      "startDate": CustomMethod.convertDateFormat(
          startDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
      "endDate":
          CustomMethod.convertDateFormat(endDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_NUTRITIONAL_STATS_DATA,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        nutritionalStatsModel = nutritionalStatsModelFromJson(responseBody);

        isTabLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isTabLoading.value = false;
      },
    );
  }

  setData(count) {
    if (selectTabIndex.value == 0) {
      diaryExercisesItems.clear();
      diaryExercisesItems.add(DiaryItem(
          id: 1,
          image: ImageResourcePng.myWorkOutTwo,
          title: "My Workout Plans",
          description: "$count Workouts"));

      diaryExercisesItems.add(DiaryItem(
          id: 2,
          image: ImageResourcePng.myWorkOutOne,
          title: "My Workout Calendar",
          description: "${DateFormat('MMMM').format(DateTime.now())} ${DateTime.now().year}"));

      diaryExercisesItems.add(DiaryItem(
          id: 3,
          image: ImageResourcePng.crateWorkOut,
          title: "Create a Workout",
          description: "Workout Library"));
    } else {
      diaryNutritionalItems.clear();
      diaryNutritionalItems.add(DiaryItem(
          id: 1,
          image: ImageResourcePng.myMealPan,
          title: "My Meal \nPlans",
          description: "$count Meals"));
      diaryNutritionalItems.add(DiaryItem(
          id: 2,
          image: ImageResourcePng.myCalendarPlan,
          title: "My Meal Calendar",
          description: "${DateFormat('MMMM').format(DateTime.now())} ${DateTime.now().year}"));
      diaryNutritionalItems.add(DiaryItem(
          id: 3,
          image: ImageResourcePng.createMealPlan,
          title: "Create a Meal Plan",
          description: "Resource Library"));
    }
  }
}
