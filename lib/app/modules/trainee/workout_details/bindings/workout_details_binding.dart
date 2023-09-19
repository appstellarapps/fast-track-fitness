import 'package:get/get.dart';

import '../controllers/workout_details_controller.dart';

class WorkoutDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkoutDetailsController>(
      () => WorkoutDetailsController(),
    );
  }
}
