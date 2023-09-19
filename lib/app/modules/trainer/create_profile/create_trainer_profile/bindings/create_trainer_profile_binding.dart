import 'package:get/get.dart';

import '../controllers/create_trainer_profile_controller.dart';

class CreateTrainerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTrainerProfileController>(
      () => CreateTrainerProfileController(),
    );
  }
}
