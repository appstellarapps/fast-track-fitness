import 'package:get/get.dart';

import '../controllers/add_card_controller.dart';

class AddCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCardController>(
      () => AddCardController(),
    );
  }
}
