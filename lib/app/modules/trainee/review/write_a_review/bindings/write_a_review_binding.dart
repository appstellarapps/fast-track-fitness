import 'package:get/get.dart';

import '../controllers/write_a_review_controller.dart';

class WriteAReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WriteAReviewController>(
      () => WriteAReviewController(),
    );
  }
}
