import 'package:get/get.dart';

import '../controllers/my_booking_trainee_controller.dart';

class MyBookingTraineeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBookingTraineeController>(
      () => MyBookingTraineeController(),
    );
  }
}
