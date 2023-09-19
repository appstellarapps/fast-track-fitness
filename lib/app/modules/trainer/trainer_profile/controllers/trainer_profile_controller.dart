import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/get_my_trainer_profile_model.dart';

class TrainerProfileController extends GetxController {
  PageController pageController = PageController();

  var isSelected = 0.obs;
  var getMyTrainerProfileModel = GetTrainerProfileDetailModel();
  var isLoading = true.obs;
  var userId = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      viewportFraction: 0.6,
      initialPage: 0,
    );
    if (AppStorage.isLogin()) {
      apiLoader(asyncCall: () => getMyTrainerProfileAPI());
    } else {
      apiLoader(asyncCall: () => getMyTrainerProfileAsGuestAPI());
    }
    print("object$userId");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getMyTrainerProfileAPI() {
    WebServices.postRequest(
      body: AppStorage.userData.result!.user.id != userId ? {'id': userId} : {},
      uri: AppStorage.userData.result!.user.id != userId
          ? EndPoints.GET_TRAINER_VIEW_DETAIL
          : EndPoints.GET_MY_TRAINER_PROFILE,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        getMyTrainerProfileModel = getTrainerProfileDetailModelFromJson(responseBody);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void getMyTrainerProfileAsGuestAPI() {
    WebServices.postRequest(
      body: {"id": userId},
      uri: EndPoints.GET_TRAINER_VIEW_DETAIL_AS_GUEST,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        getMyTrainerProfileModel = getTrainerProfileDetailModelFromJson(responseBody);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void bookAppointment() {
    WebServices.postRequest(
      body: {'trainerId': getMyTrainerProfileModel.result!.user.id},
      uri: EndPoints.BOOK_APPOINMENT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        Get.closeAllSnackbars();
        thankYouSheet();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        Get.closeAllSnackbars();
        showSnackBar(title: "Error", message: "Something went wrong please try again");

        isLoading.value = false;
      },
    );
  }

  thankYouSheet() {
    return Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Successful!",
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 30.0,
                  bottom: 30.0,
                ),
                child: Text(
                  "Trainer will contact you soon regarding \nyour booking request",
                  style: CustomTextStyles.normal(
                    fontSize: 14.0,
                    fontColor: grey50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: ButtonRegular(
                  buttonText: "Ok",
                  onPress: () {
                    if (Get.isBottomSheetOpen!) Get.back();
                    Get.back(result: true);
                  },
                ),
              )
            ],
          ),
        ),
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: false);
  }
}
