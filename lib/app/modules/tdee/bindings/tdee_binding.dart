import 'package:get/get.dart';

import '../controllers/tdee_controller.dart';

class TdeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TdeeController>(
      () => TdeeController(),
    );
  }
}
