
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/keyboard_avoider.dart';
import '../controllers/edit_profile_controller.dart';
import 'edit_profile_components.dart';

class EditProfileView extends GetView<EditProfileController> with EditProfileViewComponents {
  EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeWhite,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            appBar(),
            Expanded(
              child: KeyboardAvoider(
                autoScroll: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        key: controller.keyFName,
                        hintText: "Enter First Name",
                        errorMsg: "first name",
                        controller: controller.fNameController,
                        hasBorder: false,
                        fontColor: themeBlack,
                        fillColor: colorGreyEditText,
                        focusNode: controller.focusFName,
                        focusNext: controller.focusLName,
                        validateTypes: ValidateTypes.name,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextFormField(
                        key: controller.keyLName,
                        hintText: "Enter Last name",
                        errorMsg: "last name",
                        controller: controller.lNameController,
                        hasBorder: false,
                        fontColor: themeBlack,
                        fillColor: colorGreyEditText,
                        focusNode: controller.focusLName,
                        focusNext: controller.focusMobile,
                        validateTypes: ValidateTypes.name,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextFormField(
                        prefix: SvgPicture.asset(ImageResourceSvg.mobileNoIc),
                        key: controller.keyMobile,
                        hintText: "Enter your mobile no",
                        errorMsg: "mobile no",
                        controller: controller.mobileController,
                        hasBorder: false,
                        fontColor: themeBlack,
                        fillColor: colorGreyEditText,
                        focusNode: controller.focusMobile,
                        focusNext: controller.focusEmail,
                        textInputType: TextInputType.number,
                        maxLength: 16,
                        inputFormat: [FilteringTextInputFormatter.digitsOnly],
                        validateTypes: ValidateTypes.mobile,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextFormField(
                        key: controller.keyEmail,
                        hintText: "Enter your email",
                        errorMsg: "your email",
                        controller: controller.emailController,
                        prefix: SvgPicture.asset(ImageResourceSvg.profileEmail),
                        hasBorder: false,
                        fontColor: themeBlack,
                        fillColor: colorGreyEditText,
                        focusNode: controller.focusEmail,
                        textInputType: TextInputType.emailAddress,
                        validateTypes: ValidateTypes.email,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: ButtonRegular(
                onPress: () {
                  if (controller.keyFName.currentState!.checkValidation()) {
                    controller.isValidate.value = false;
                  }
                  if (controller.keyLName.currentState!.checkValidation()) {
                    controller.isValidate.value = false;
                  }
                  if (controller.keyMobile.currentState!.checkValidation()) {
                    controller.isValidate.value = false;
                  }
                  if (controller.keyEmail.currentState!.checkValidation()) {
                    controller.isValidate.value = false;
                  }
                  if (controller.isValidate.value) {
                    apiLoader(asyncCall: () => controller.updateProfileAPI());
                  }
                },
                buttonText: "SAVE")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
