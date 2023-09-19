import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/modules/settings/contact_us/controllers/contact_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_button.dart';

mixin ContactUsComponents {
  var controller = Get.put(ContactUsController());

  var commonBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ));

  btnView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0, left: 20.0, right: 20.0, top: 100.0),
      child: ButtonRegular(
        buttonText: "Submit",
        onPress: () {
          if (controller.subController.text.isEmpty) {
            showSnackBar(title: "Error", message: "Please Enter Subject");
          } else if (controller.msgController.text.isEmpty) {
            showSnackBar(title: "Error", message: "Please Enter Message");
          } else {
            apiLoader(asyncCall: () => controller.contactUsApi());
          }
        },
        isShadow: true,
      ),
    );
  }
}
