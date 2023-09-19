import 'package:get/get.dart';

import '../controllers/my_diary_controller.dart';

class MyDiaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDiaryController>(
      () => MyDiaryController(),
    );
  }
}
