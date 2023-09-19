import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/get_exercise_workout_model.dart';

class WorkoutPlaneController extends GetxController {
  var workTypeList = <WorkoutType>[].obs;
  ScrollController scrollController = ScrollController();

  var isLoading = true.obs;
  var haseMore = false.obs;
  var page = 1;
  var workoutList = <Workout>[].obs;
  var selectedTypeList = ['Custom'];
  var sortOutText = 'Ascending'.obs;
  var tag = Get.arguments[0];
  var id = Get.arguments[1];
  var selectedOldValue = '';
  var workOutSelected = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    apiLoader(asyncCall: () => getMyWorkout());
    workTypeList.add(WorkoutType(title: "Custom", isSelected: true.obs));
    workTypeList.add(WorkoutType(title: "Trainer", isSelected: false.obs));
    workTypeList.add(WorkoutType(title: "PreMade", isSelected: false.obs));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  scroll() {
    if (scrollController.position.maxScrollExtent - 500 == scrollController.position.pixels - 500) {
      if (haseMore.value) {
        page++;
        getMyWorkout();
      }
    }
  }

  getMyWorkout() {
    var body = {
      'page': page,
      "traineeId": id != "" ? id : AppStorage.userData.result!.user.id,
      "tagName": "MyWorkout",
      "type": selectedTypeList,
      "sortBy": sortOutText.value == 'Ascending' ? 'asc' : 'desc',
    };
    WebServices.postRequest(
      body: body,
      uri: tag == 0 ? EndPoints.GET_EXERCISE_WORKOUT : EndPoints.GET_NUTRITIONAL_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        GetExerciseModel getExerciseModel = getExerciseModelFromJson(responseBody);
        workoutList.addAll(getExerciseModel.result!.workouts);
        haseMore.value = getExerciseModel.result!.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  removeExerciseWorkout(index) {
    var body = {
      "tagName": workoutList[index].type,
      "workoutId": workoutList[index].id,
      "workoutDate": DateFormat('yyyy-MM-dd').format(workoutList[index].workoutDate),
      "traineeId": id != "" ? id : AppStorage.userData.result!.user.id,
    };
    WebServices.postRequest(
      body: body,
      uri: tag == 0 ? EndPoints.REMOVE_EXERCISE_WORKOUT : EndPoints.REMOVE_NUTRITIONAL_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        workoutList.removeAt(index);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}

class WorkoutType {
  var title = '';
  var isSelected = false.obs;

  WorkoutType({required this.title, required this.isSelected});
}
