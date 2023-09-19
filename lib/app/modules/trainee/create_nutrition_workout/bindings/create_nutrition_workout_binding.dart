import 'package:get/get.dart';

import '../controllers/create_nutrition_workout_controller.dart';

class CreateNutritionWorkoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNutritionWorkoutController>(
      () => CreateNutritionWorkoutController(),
    );
  }
}
