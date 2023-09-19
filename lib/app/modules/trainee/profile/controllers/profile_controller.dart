import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/trainee_profile_model.dart';
import 'package:fasttrackfitness/app/data/user_model.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';

class ProfileController extends GetxController {
  var id = Get.arguments;
  var userModel = GetTraineeProfileDetailModel().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    apiLoader(asyncCall: () => getProfileAPI());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getProfileAPI() {
    WebServices.postRequest(
      body: {'traineeId': AppStorage.userData.result!.user.id},
      uri: EndPoints.GET_TRAINEE_PROFILE,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        userModel.value = getTraineeProfileDetailModelFromJson(responseBody);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
