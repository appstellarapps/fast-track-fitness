import 'dart:convert';

import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/my_diary_model.dart';

class TraineeProfileController extends GetxController {
  var isFrom = Get.arguments[0]; // 0 = Exercise Diary, 1 = Nutrition Diary
  var userProfile = Get.arguments[1];
  var userName = Get.arguments[2];
  var phoneNo = Get.arguments[3];
  var traineeId = Get.arguments[4];
  var userEmail = Get.arguments[5];

  var diaryExercisesItems = [].obs;
  var isLoading = true.obs;
  var workOutSelected = 0.obs;

  @override
  void onInit() {
    apiLoader(asyncCall: () => getResourceCount(isFrom == 0 ? "Exercise" : "Nutrition"));
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

  void getResourceCount(type) {
    var body = {"traineeId": traineeId, "type": type};
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

          setData(count < 10 ? "0$count" : "$count");
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  setData(count) {
    if (isFrom == 0) {
      diaryExercisesItems.clear();
      diaryExercisesItems.add(DiaryItem(
          id: 1,
          image: ImageResourcePng.myWorkOutTwo,
          title: "Client Workout Plans",
          description: "$count Workouts"));

      diaryExercisesItems.add(DiaryItem(
          id: 2,
          image: ImageResourcePng.myWorkOutOne,
          title: "Client Workout Calendar",
          description: ""));

      diaryExercisesItems.add(DiaryItem(
          id: 3,
          image: ImageResourcePng.crateWorkOut,
          title: "Client Stats",
          description: "Workout Activity"));

      diaryExercisesItems.add(DiaryItem(
          id: 4,
          image: ImageResourcePng.crateWorkOut,
          title: "Create A Workout",
          description: "Workout Activity"));
    } else {
      diaryExercisesItems.clear();
      diaryExercisesItems.add(DiaryItem(
          id: 1,
          image: ImageResourcePng.myMealPan,
          title: "Client Meal Plans",
          description: "$count Workouts"));
      diaryExercisesItems.add(DiaryItem(
          id: 2,
          image: ImageResourcePng.myCalendarPlan,
          title: "Client Meal Calendar",
          description: ""));
      diaryExercisesItems.add(DiaryItem(
          id: 3,
          image: ImageResourcePng.createMealPlan,
          title: "Client Nutritional Stats",
          description: "Nutritional Intake"));
      diaryExercisesItems.add(DiaryItem(
          id: 4,
          image: ImageResourcePng.createMealPlan,
          title: "Create A Meal Plan",
          description: "Resource Library"));
    }
  }
}
