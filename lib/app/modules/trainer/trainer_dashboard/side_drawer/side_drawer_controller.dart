import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/user_model.dart';
import '../../../../routes/app_pages.dart';

class SideDrawerController extends GetxController {
  var selectedIndex = 1.obs;
  var userModel = UserModel();

  void becomeTrainer() {
    WebServices.postRequest(
      uri: EndPoints.BECOME_TRAINER,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        userModel = userModelFromJson(responseBody);
        AppStorage.setAccessToken(userModel.result!.accessToken);
        AppStorage.setLoginProfileModel(userModel);
        AppStorage.setAppLogin(true);
        AppStorage.setUserType(userModel.result!.user.roleName);
        AppStorage.userData = userModelFromJson(AppStorage.getLoginProfileModel());
        FTFGlobal.firstName.value = AppStorage.userData.result!.user.firstName!.value;
        FTFGlobal.lastName.value = AppStorage.userData.result!.user.lastName!.value;
        FTFGlobal.userName.value = AppStorage.userData.result!.user.fullName!.value;
        FTFGlobal.mobileNo.value = AppStorage.userData.result!.user.phoneNumber!.value;
        FTFGlobal.email.value = AppStorage.userData.result!.user.email!.value;
        FTFGlobal.userProfilePic.value = AppStorage.userData.result!.user.profileImage;

        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
          if (AppStorage.userData.result!.user.isProfileVerified == 0) {
            Get.offAllNamed(Routes.CREATE_TRAINER_PROFILE);
          } else if (AppStorage.userData.result!.user.isSubscribed == 0 &&
              AppStorage.userData.result!.user.isFreeTrail == 0) {
            Get.offAllNamed(Routes.SUBSCRIPTION);
          } else {
            Get.offAllNamed(Routes.TRAINER_DASHBOARD);
          }
        } else {
          Get.offAllNamed(Routes.TRAINEE_DASHBOARD);
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  confirmationBottomSheet() {
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
                  AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
                      ? "Become A Trainer"
                      : "Switch User",
                  style: CustomTextStyles.bold(fontColor: themeBlack, fontSize: 24.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
                      ? "Are you sure you want to become a trainer?"
                      : "Are you sure you want to switch user",
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40.0,
                ),
                child: ButtonRegular(
                  verticalPadding: 14.0,
                  buttonText: "Ok",
                  onPress: () {
                    if (Get.isBottomSheetOpen!) Get.back();
                    becomeTrainer();
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: colorGreyText),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Cancel",
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }
}
