import 'package:get/get.dart';

import '../controllers/all_exercise_controller.dart';

class AllExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllExerciseController>(
      () => AllExerciseController(),
    );
  }
}
