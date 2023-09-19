import 'package:get/get.dart';

import '../controllers/trainee_dashboard_controller.dart';

class TraineeDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraineeDashboardController>(
      () => TraineeDashboardController(),
    );
  }
}
