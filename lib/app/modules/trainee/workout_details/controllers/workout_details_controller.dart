import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/workout_details_model.dart';

class WorkoutDetailsController extends GetxController {
  //TODO: Implement WorkoutDetailsController

  var title = Get.arguments[0];
  var id = Get.arguments[1];
  var isLoading = true.obs;

  var workoutDetail = WorkoutDetailsModel();
  var workoutExerciseList = <WorkoutExerciseDetail>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiLoader(asyncCall: () => getStartWorkoutDetails());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  getStartWorkoutDetails() {
    var body = {
      'workoutId': id,
      'workoutDate': DateFormat('yyyy-MM-dd').format(title),
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_WORKOUT_DETAILS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        workoutDetail = workoutDetailsModelFromJson(responseBody);
        workoutExerciseList.addAll(workoutDetail.result!.workoutExerciseDetails);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
