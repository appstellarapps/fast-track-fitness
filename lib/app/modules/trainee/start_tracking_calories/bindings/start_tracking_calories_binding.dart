import 'package:get/get.dart';

import '../controllers/start_tracking_calories_controller.dart';

class StartTrackingCaloriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartTrackingCaloriesController>(
      () => StartTrackingCaloriesController(),
    );
  }
}
