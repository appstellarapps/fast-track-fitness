import 'package:get/get.dart';

import '../controllers/nutrition__details_view_controller.dart';

class MealsDetailsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NutritionDetailsViewController>(
      () => NutritionDetailsViewController(),
    );
  }
}
