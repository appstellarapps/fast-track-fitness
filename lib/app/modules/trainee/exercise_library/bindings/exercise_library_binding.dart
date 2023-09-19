import 'package:get/get.dart';

import '../controllers/exercise_library_controller.dart';

class ExerciseLibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExerciseLibraryController>(
      () => ExerciseLibraryController(),
    );
  }
}
