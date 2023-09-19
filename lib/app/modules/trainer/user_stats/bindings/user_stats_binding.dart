import 'package:get/get.dart';

import '../controllers/user_stats_controller.dart';

class UserStatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserStatsController>(
      () => UserStatsController(),
    );
  }
}
