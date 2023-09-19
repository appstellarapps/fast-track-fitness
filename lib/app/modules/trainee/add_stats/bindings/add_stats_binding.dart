import 'package:get/get.dart';

import '../controllers/add_stats_controller.dart';

class AddStatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStatsController>(
      () => AddStatsController(),
    );
  }
}
