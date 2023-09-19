import 'package:get/get.dart';

import '../controllers/workout_calendar_controller.dart';

class WorkoutCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkoutCalendarController>(
      () => WorkoutCalendarController(),
    );
  }
}
