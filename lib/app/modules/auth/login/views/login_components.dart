import 'package:fasttrackfitness/app/modules/auth/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/keyboard_avoider.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../routes/app_pages.dart';

mixin LoginComponents {
  var controller = Get.put(LoginController());

  loginView() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              ImageResourcePng.welcomeBg,
            ),
            fit: BoxFit.fill),
      ),
      child: SafeArea(
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Helper().hideKeyBoard(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0, top: 10.0),
                  child: InkWell(
                    onTap: () {
                      Get.offAllNamed(Routes.TRAINEE_DASHBOARD);
                    },
                    child: Text(
                      "Skip",
                      style: CustomTextStyles.bold(
                        fontSize: 16.0,
                        fontColor: themeWhite,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: KeyboardAvoider(
                  autoScroll: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: CustomTextStyles.bold(
                          fontColor: themeWhite,
                          fontSize: 34.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Let’s Get Started",
                        style: CustomTextStyles.normal(
                          fontSize: 14.0,
                          fontColor: themeWhite,
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      CustomTextFormField(
                        key: controller.keyMobile,
                        hintText: "Mobile Number",
                        errorMsg: "mobile number",
                        controller: controller.mobileController,
                        prefix: SvgPicture.asset(ImageResourceSvg.mobile),
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        maxLength: 16,
                        validateTypes: ValidateTypes.mobile,
                        inputFormat: [FilteringTextInputFormatter.digitsOnly], // Only numbers c
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  nextBtn() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 28.0,
        left: 20.0,
        right: 20.0,
      ),
      child: ButtonRegular(
          buttonText: "NEXT",
          onPress: () {
            controller.validateLogin();
          }
          // },
          ),
    );
  }
}
