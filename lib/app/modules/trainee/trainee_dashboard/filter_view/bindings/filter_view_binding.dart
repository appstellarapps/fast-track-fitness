import 'package:get/get.dart';

import '../controllers/filter_view_controller.dart';

class FilterViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterViewController>(
      () => FilterViewController(),
    );
  }
}
