import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';

import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/helper.dart';

class EditProfileController extends GetxController {
  final focusFName = FocusNode(),
      focusLName = FocusNode(),
      focusMobile = FocusNode(),
      focusEmail = FocusNode();
  TextEditingController fNameController = TextEditingController(),
      lNameController = TextEditingController(),
      mobileController = TextEditingController(),
      emailController = TextEditingController();
  final GlobalKey<CustomTextFormFieldState> keyFName = GlobalKey<CustomTextFormFieldState>(),
      keyLName = GlobalKey<CustomTextFormFieldState>(),
      keyMobile = GlobalKey<CustomTextFormFieldState>(),
      keyEmail = GlobalKey<CustomTextFormFieldState>();

  final picker = ImagePicker();
  var profilePic = "".obs;
  var apiProfilePicName = "".obs;
  var phoneCode = "+91".obs;
  var profilePictureUrl = "".obs;
  var isValidate = true.obs;
  var timerStart = 0.obs;
  var selectedProfile = File("").obs;

  Timer? _timer;

  late UserModel userModel;

  @override
  void onInit() {
    fNameController.text = FTFGlobal.firstName.value;
    lNameController.text = FTFGlobal.lastName.value;
    mobileController.text = FTFGlobal.mobileNo.value;
    emailController.text = FTFGlobal.email.value;

    profilePic.value = FTFGlobal.userProfilePic.value;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  verifyNumberSheet() {
    TextEditingController otpController = TextEditingController();
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
            color: themeWhite,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 16.0),
              child: Text(
                "Enter OTP",
                style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
              ),
            ),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'We have sent OTP on\n',
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 16.0,
                    ),
                  ),
                  WidgetSpan(
                    child: Text(
                      "${phoneCode.value} ${mobileController.text}",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        focusMobile.requestFocus();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                        child: Text(
                          ' (Edit)',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.semiBold(
                            fontColor: themeGreen,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0, top: 16.0),
              child: Pinput(
                controller: otpController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme,
                submittedPinTheme: defaultPinTheme,
                showCursor: false,
                onCompleted: (pin) => printLog(pin),
              ),

              /*PinCodeTextField(
                controller: otpController,
                selectedFillColor: themeBlack,
                activeColor: themeBlack,
                activeFillColor: themeBlack,
                inactiveColor: Colors.transparent,
                selectedColor: Colors.transparent,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                fieldWidth: 40,
                fieldHeight: 40,
                obsecureText: false,
                textStyle: CustomTextStyles.bold(fontSize: 16.0, fontColor: themeWhite),
                textInputType: TextInputType.number,
                onCompleted: ((val) {}),
                length: 6,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(40.0),
                onChanged: (String value) {},
              ),*/
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(
              () => InkWell(
                onTap: timerStart.value != 0
                    ? null
                    : () {
                        apiLoader(asyncCall: () => resendVerificationCode());
                      },
                child: formatHHMMSS(timerStart.value).isEmpty
                    ? Text(
                        "Resend Code",
                        style: CustomTextStyles.semiBold(
                          fontSize: 17.0,
                          fontColor: themeGreen,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get a new code",
                            style: CustomTextStyles.semiBold(
                              fontSize: 17.0,
                              fontColor: themeBlack,
                            ),
                          ),
                          Text(
                            " (${formatHHMMSS(timerStart.value)})",
                            style: CustomTextStyles.semiBold(
                              fontSize: 17.0,
                              fontColor: themeGreen,
                            ),
                          )
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 20.0, top: 20.0),
              child: ButtonRegular(
                buttonText: "Submit",
                onPress: () {
                  if (otpController.text.isEmpty) {
                    showSnackBar(title: "Error", message: "Please Enter OTP");
                  } else if (otpController.text.length != 6) {
                    showSnackBar(title: "Error", message: "Please enter valid OTP");
                  } else {
                    apiLoader(asyncCall: () => verifyOtpAPI(otpController.text));
                  }
                },
              ),
            )
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: true,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  void verifyOtpAPI(otp) {
    Helper().hideKeyBoard();
    var body = {
      "countryCode": phoneCode.value,
      "phoneNumber": AppStorage.userData.result!.user.phoneNumber!.value,
      "otp": otp,
      "type": "Update",
      "newPhoneNumber": mobileController.text,
    };
    WebServices.postRequest(
      uri: EndPoints.VERIFY_OTP,
      body: body,
      hasBearer: false,
      onStatusSuccess: (responseBody) async {
        hideAppLoader();
        userModel = userModelFromJson(responseBody);
        if (userModel.status == 1) {
          AppStorage.setAccessToken(userModel.result!.accessToken);

          AppStorage.setLoginProfileModel(userModel);
          AppStorage.userData = userModelFromJson(AppStorage.getLoginProfileModel());
          printLog(AppStorage.userData.result!.user.fullName!.value);

          FTFGlobal.firstName.value = AppStorage.userData.result!.user.firstName!.value;
          FTFGlobal.lastName.value = AppStorage.userData.result!.user.lastName!.value;
          FTFGlobal.userName.value = AppStorage.userData.result!.user.fullName!.value;
          FTFGlobal.mobileNo.value = AppStorage.userData.result!.user.phoneNumber!.value;
          FTFGlobal.email.value = AppStorage.userData.result!.user.email!.value;
          FTFGlobal.userProfilePic.value = AppStorage.userData.result!.user.profileImage;

          profilePictureUrl.value = userModel.result!.user.profileImage;
          if (userModel.result!.user.fullName!.value != null) {
            AppStorage.setUserName(userModel.result!.user.fullName!.value.toString());
          }
          profilePictureUrl.value = userModel.result!.user.profileImage;
          AppStorage.setUserProfilePic(userModel.result!.user.profileImage);
          mobileController.text = userModel.result!.user.phoneNumber!.value.toString();
          if (Get.isBottomSheetOpen!) {
            Get.back();
          }
          Get.back();
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void updateProfileAPI() {
    var body = {
      "firstName": fNameController.text,
      "lastName": lNameController.text,
      "email": emailController.text,
      "isPrivate": "0"
    };
    WebServices.postRequest(
      uri: EndPoints.UPDATE_TRAINEE_PROFILE,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) async {
        hideAppLoader();

        var data = userModelFromJson(responseBody);
        if (AppStorage.userData.result!.user.phoneNumber!.value.toString() ==
            mobileController.text) {
          AppStorage.setLoginProfileModel(data);

          AppStorage.userData = userModelFromJson(AppStorage.getLoginProfileModel());
          FTFGlobal.firstName.value = AppStorage.userData.result!.user.firstName!.value;
          FTFGlobal.lastName.value = AppStorage.userData.result!.user.lastName!.value;
          FTFGlobal.userName.value = AppStorage.userData.result!.user.fullName!.value;
          FTFGlobal.mobileNo.value = AppStorage.userData.result!.user.phoneNumber!.value;
          FTFGlobal.email.value = AppStorage.userData.result!.user.email!.value;
          FTFGlobal.userProfilePic.value = AppStorage.userData.result!.user.profileImage;
          Get.back();
          showSnackBar(title: "Success", message: data.message);
        } else {
          apiLoader(asyncCall: () => updateMobileNumber());
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
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

  void updateMobileNumber() {
    var body = {
      "countryCode": phoneCode.value,
      "phoneNumber": mobileController.text,
    };
    WebServices.postRequest(
      uri: EndPoints.UPDATE_MOBILE_NUMBER,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        var data = jsonDecode(responseBody);
        if (data['status'] == 1) {
          timerStart.value = 120;
          startTimer();
          Get.closeAllSnackbars();
          Helper().hideKeyBoard();
          hideAppLoader();
          verifyNumberSheet();
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void resendVerificationCode() {
    var body = {
      "countryCode": phoneCode.value,
      "phoneNumber": mobileController.text,
    };
    WebServices.postRequest(
      uri: EndPoints.UPDATE_MOBILE_NUMBER,
      body: body,
      hasBearer: true,
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

  void callUploadProfileFileAPI(imageFile) {
    WebServices.uploadImage(
      uri: EndPoints.UPLOAD_FILE,
      hasBearer: true,
      type: "traineeprofilepic",
      file: imageFile,
      moduleId: AppStorage.userData.result!.user.id,
      onSuccess: (response) {
        hideAppLoader();
        var json = jsonDecode(response);
        if (json['status'] == 1) {
          profilePic.value = json['result']['fileUrl'];
          apiProfilePicName.value = json['result']['fileUrl'];
          profilePictureUrl.value = json['result']['fileUrl'];
          FTFGlobal.userProfilePic.value = json['result']['fileUrl'];
          Get.back();
          AppStorage.setUserProfilePic(profilePic.value);
        }
      },
      onFailure: (error) {
        hideAppLoader();
      },
    );
  }

  static PinTheme defaultPinTheme = PinTheme(
    width: 45,
    height: 45,
    margin: const EdgeInsets.all(3.0),
    textStyle: const TextStyle(fontSize: 20, color: themeWhite, fontWeight: FontWeight.bold),
    decoration: BoxDecoration(
      color: themeBlack,
      border: Border.all(color: themeBlack),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
