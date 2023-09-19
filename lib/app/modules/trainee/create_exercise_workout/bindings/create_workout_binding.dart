import 'package:get/get.dart';

import '../controllers/create_workout_controller.dart';

class CreateWorkoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateWorkoutController>(
      () => CreateWorkoutController(),
    );
  }
}
