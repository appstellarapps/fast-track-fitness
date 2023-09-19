import 'package:get/get.dart';

import '../controllers/nutrition_library_controller.dart';

class NutritionLibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NutritionLibraryController>(
      () => NutritionLibraryController(),
    );
  }
}
