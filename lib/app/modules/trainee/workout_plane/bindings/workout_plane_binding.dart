import 'package:get/get.dart';

import '../controllers/workout_plane_controller.dart';

class WorkoutPlaneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkoutPlaneController>(
      () => WorkoutPlaneController(),
    );
  }
}
