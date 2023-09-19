import 'package:get/get.dart';

import '../controllers/training_type_controller.dart';

class TrainingTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingTypeController>(
      () => TrainingTypeController(),
    );
  }
}
