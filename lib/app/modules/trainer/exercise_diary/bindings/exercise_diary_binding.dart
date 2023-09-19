import 'package:get/get.dart';

import '../controllers/exercise_diary_controller.dart';

class ExerciseDiaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExerciseDiaryController>(
      () => ExerciseDiaryController(),
    );
  }
}
