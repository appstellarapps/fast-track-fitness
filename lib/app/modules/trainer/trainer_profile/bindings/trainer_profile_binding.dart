import 'package:get/get.dart';

import '../controllers/trainer_profile_controller.dart';

class TrainerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainerProfileController>(
      () => TrainerProfileController(),
    );
  }
}
