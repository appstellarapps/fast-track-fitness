import 'package:get/get.dart';

import '../controllers/trainer_resource_controller.dart';

class TrainerResourceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainerResourceController>(
      () => TrainerResourceController(),
    );
  }
}
