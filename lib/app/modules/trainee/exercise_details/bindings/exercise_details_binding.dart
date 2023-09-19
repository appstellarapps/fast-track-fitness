import 'package:get/get.dart';

import '../controllers/exercise_details_controller.dart';

class ExerciseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExerciseDetailsController>(
      () => ExerciseDetailsController(),
    );
  }
}
