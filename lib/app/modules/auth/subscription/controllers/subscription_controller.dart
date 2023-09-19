import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/subscripation_model.dart';

class SubscriptionController extends GetxController {
  //TODO: Implement SubscriptionController

  var subscriptionModel = SubscriptionModel().obs;
  var isLoading = true.obs;
  var isPlanSelected = false.obs;
  var selectedType = '';
  var selectedPlanId = '';

  @override
  void onInit() {
    super.onInit();
    apiLoader(asyncCall: () => getSubscriptionPlan());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getSubscriptionPlan() {
    WebServices.postRequest(
      uri: EndPoints.GETSUBSCRIPATION,
      hasBearer: false,
      onStatusSuccess: (res) {
        hideAppLoader();
        subscriptionModel.value = subscriptionModelFromJson(res);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
