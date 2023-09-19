import 'dart:convert';

import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';

class PrivacyPolicyController extends GetxController {
  var policy = "".obs;
  var isLoading = true.obs;
  var type = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    apiLoader(asyncCall: () => privacyPolicyApi());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void privacyPolicyApi() {
    var body = {"slug": type == "privacy" ? "privacy-policy" : "terms-and-conditions"};
    WebServices.postRequest(
      uri: EndPoints.CMS_DATA,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        var res = jsonDecode(responseBody);
        policy.value = res['result']['cmsData']['content'];
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
