import 'package:get/get.dart';

import '../controllers/get_location_map_controller.dart';

class GetLocationMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetLocationMapController>(
      () => GetLocationMapController(),
    );
  }
}
