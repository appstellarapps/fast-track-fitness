import 'dart:async';
import 'dart:convert';

import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/role_model.dart';
import '../../../../routes/app_pages.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  Timer? _timer;

  var mobileNumber = "".obs;
  var timerStart = 0.obs;
  var isShowError = false.obs;
  var phoneCode = "".obs;
  var mobile = "".obs;
  var isCodeSent = false.obs;
  var userModel = UserModel();
  var roleModel = RoleModel();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      var authData = Get.arguments;
      phoneCode.value = authData[1] == "" ? "+91" : authData[1];
      mobile.value = authData[0];
      mobileNumber.value = authData[1].toString() == "" || authData[1] == null
          ? "+91 ${authData[0]}"
          : "${authData[1]} ${authData[0]}";
    }
    timerStart.value = 120;
    startTimer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String formatHHMMSS(int seconds) {
    if (seconds > 0) {
      int minutes = (seconds / 60).truncate();
      int second = seconds - (minutes * 60);
      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (second).toString().padLeft(2, '0');
      return "$minutesStr:$secondsStr";
    } else {
      return "";
    }
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerStart.value < 1) {
          _timer!.cancel();
        } else {
          timerStart.value = timerStart.value - 1;
        }
      },
    );
  }

  void resendVerificationCode() {
    var body = {
      "countryCode": phoneCode.value,
      "phoneNumber": mobile.value,
    };
    WebServices.postRequest(
      uri: EndPoints.LOG_IN,
      body: body,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        timerStart.value = 120;
        startTimer();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void verifyOtpAPI() {
    var body = {
      "otp": otpController.text,
      "countryCode": phoneCode.value,
      "phoneNumber": mobile.value,
    };
    WebServices.postRequest(
      uri: EndPoints.VERIFY_OTP,
      body: body,
      hasBearer: false,
      onStatusSuccess: (responseBody) async {
        hideAppLoader();
        userModel = userModelFromJson(responseBody);
        AppStorage.setAccessToken(userModel.result!.accessToken);
        AppStorage.setLoginProfileModel(userModel);
        if (userModel.result!.user.roleName.isEmpty) {
          //Go for select role of user
          apiLoader(asyncCall: () => getRolesAPI());
        } else {
          //Go to home
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
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void getRolesAPI() {
    WebServices.postRequest(
      uri: EndPoints.ROLE_LIST,
      hasBearer: false,
      onStatusSuccess: (res) {
        hideAppLoader();
        roleModel = roleModelFromJson(res);
        roleBottomSheet(roleModel.result!.roles);
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void addRoleAPI({roleId}) {
    var body = {
      "roleId": roleId,
    };
    WebServices.postRequest(
      uri: EndPoints.ADD_ROLE,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) async {
        hideAppLoader();
        var res = jsonDecode(responseBody);
        userModel = userModelFromJson(responseBody);
        if (res['status'] == 1) {
          AppStorage.setAppLogin(true);
          AppStorage.setUserType(res['result']['user']['roleName']);
          AppStorage.setLoginProfileModel(userModel);
          AppStorage.userData = userModelFromJson(AppStorage.getLoginProfileModel());
          if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
            if (AppStorage.userData.result!.user.isProfileVerified == 0) {
              Get.offAllNamed(Routes.CREATE_TRAINER_PROFILE);
            } else if (AppStorage.userData.result!.user.isSubscribed == 0) {
              Get.offAllNamed(Routes.SUBSCRIPTION);
            } else {
              Get.offAllNamed(Routes.TRAINER_DASHBOARD);
            }
          } else {
            Get.offAllNamed(Routes.TRAINEE_DASHBOARD);
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  roleBottomSheet(List<Role> roles) {
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
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                  "SIGN IN AS :",
                  style: CustomTextStyles.bold(fontColor: themeBlack, fontSize: 20.0),
                ),
              ),
              Column(
                children: List.generate(roles.length, (index) {
                  return roleItem(roles[index], index, roles);
                }),
              ),
              const SizedBox(height: 20.0)
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }

  roleItem(Role rol, int index, List<Role> roles) {
    return InkWell(
      onTap: () {
        rol.isSelected.value = true;
        apiLoader(asyncCall: () => addRoleAPI(roleId: roles[index].id));
      },
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 14.0),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: rol.isSelected.value ? themeGreen : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: themeGreen),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              rol.roleName == "Trainee" ? "Trainee" : "Trainer",
              style: CustomTextStyles.semiBold(
                fontColor: rol.isSelected.value ? themeWhite : themeBlack,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
