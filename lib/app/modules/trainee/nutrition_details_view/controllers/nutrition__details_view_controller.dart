import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/get_nutritional_workout_details.dart';
import '../../../../data/get_pre_made_nutritional_details.dart';

class NutritionDetailsViewController extends GetxController {
  ScrollController scrollController = ScrollController();

  var type = Get.arguments[0];
  var id = Get.arguments[1];
  var date = Get.arguments[2];
  var haseMore = false.obs;
  var page = 1;
  var isLoading = true.obs;
  var workoutDetailsList = <WorkoutDetail>[].obs;
  var preMadeWorkoutDetailsList = <PreMadeWorkoutDetails>[].obs;

  @override
  void onInit() {
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    apiLoader(asyncCall: () => getNutritionalDetails());
    super.onInit();

    print("object$date");
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
        getNutritionalDetails();
      }
    }
  }

  void getNutritionalDetails() {
    var body = {
      'workoutId': id,
      'workoutDate': DateFormat('yyyy-MM-dd').format(date),
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_NUTRITIONAK_CUSTOM_WORK_OUT_DETAILS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        isLoading.value = false;

        GetWorkouCustomtNutritionalDetails getWorkoutNutritionalDetails =
            getWorkouCustomtNutritionalDetailsFromJson(responseBody);
        workoutDetailsList.addAll(getWorkoutNutritionalDetails.result.workoutDetails);
        haseMore.value = getWorkoutNutritionalDetails.result!.hasMoreResults == 0 ? false : true;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
