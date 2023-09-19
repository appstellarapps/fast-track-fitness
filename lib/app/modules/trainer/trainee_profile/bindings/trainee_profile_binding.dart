import 'package:get/get.dart';

import '../controllers/trainee_profile_controller.dart';

class TraineeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraineeProfileController>(
      () => TraineeProfileController(),
    );
  }
}
