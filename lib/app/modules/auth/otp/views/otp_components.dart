import 'package:fasttrackfitness/app/modules/auth/otp/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/common_widget/custom_pincode.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/keyboard_avoider.dart';
import '../../../../core/helper/text_style.dart';

mixin OTPComponents {
  var controller = Get.put(OtpController());

  otpView() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageResourcePng.welcomeBg,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: IconButton(
                    icon: SvgPicture.asset(ImageResourceSvg.back),
                    onPressed: () {
                      Get.back();
                    },
                  )),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: KeyboardAvoider(
                autoScroll: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Enter OTP",
                      style: CustomTextStyles.bold(
                        fontColor: themeWhite,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'We have sent an OTP to\n',
                            style: CustomTextStyles.semiBold(
                              fontColor: themeWhite,
                              fontSize: 16.0,
                            ),
                          ),
                          WidgetSpan(
                            child: Text(
                              controller.mobileNumber.value,
                              style: CustomTextStyles.semiBold(
                                fontColor: themeWhite,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                                child: Text(
                                  ' (Edit)',
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
                    const SizedBox(height: 28.0),
                    PinCodeTextField(
                      controller: controller.otpController,
                      selectedFillColor: Colors.white,
                      activeColor: Colors.white,
                      inactiveColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      fieldWidth: 40,
                      fieldHeight: 40,
                      obsecureText: false,
                      textStyle: CustomTextStyles.bold(fontSize: 22.0, fontColor: themeBlack),
                      textInputType: TextInputType.number,
                      backgroundColor: Colors.transparent,
                      onCompleted: ((val) {}),
                      length: 6,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(40.0),
                      onChanged: (String value) {},
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  btnView() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 28.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => InkWell(
              onTap: controller.timerStart.value != 0
                  ? null
                  : () {
                      controller.otpController.clear();
                      Get.closeAllSnackbars();
                      apiLoader(asyncCall: () => controller.resendVerificationCode());
                    },
              child: controller.formatHHMMSS(controller.timerStart.value).isEmpty
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
                          "Request a new code in",
                          style: CustomTextStyles.semiBold(
                            fontSize: 17.0,
                            fontColor: themeWhite,
                          ),
                        ),
                        Text(
                          " (${controller.formatHHMMSS(controller.timerStart.value)})",
                          style: CustomTextStyles.semiBold(
                            fontSize: 17.0,
                            fontColor: themeGreen,
                          ),
                        )
                      ],
                    ))),
          const SizedBox(height: 20.0),
          ButtonRegular(
            buttonText: "SUBMIT",
            onPress: () {
              Get.closeAllSnackbars();
              if (controller.otpController.text.isEmpty) {
                showSnackBar(title: "Error", message: "Please enter OTP");
              } else if (controller.otpController.text.length != 6) {
                showSnackBar(title: "Error", message: "Please enter valid OTP");
              } else {
                apiLoader(asyncCall: () => controller.verifyOtpAPI());
              }
            },
          ),
        ],
      ),
    );
  }
}
