import 'dart:convert';
import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';

class ContactUsController extends GetxController {
  TextEditingController subController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  TextEditingController attachController = TextEditingController();
  var file = '';

  @override
  void onInit() {
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

  Future<void> contactUsApi() async {
    var body = {
      'firstName': AppStorage.isLogin() ? AppStorage.userData.result!.user.firstName!.value : "",
      'lastName': AppStorage.isLogin() ? AppStorage.userData.result!.user.lastName!.value : "",
      'email': AppStorage.isLogin() ? AppStorage.userData.result!.user.email!.value : "",
      'subject': subController.text.trim(),
      'message': msgController.text.trim(),
      'type': 'contactusfile',
      'moduleId': AppStorage.isLogin() ? AppStorage.userData.result!.user.id : "",
    };

    WebServices.multipartReq(
      uri: EndPoints.CONTACT_US,
      file: File(file),
      body: body,
      hasBearer: false,
      onSuccess: (responseBody) {
        hideAppLoader();
        var json = jsonDecode(responseBody);
        if (json['status'] == 1) {
          Get.back();
          showSnackBar(
              title: 'Success', message: json['message'], duration: const Duration(seconds: 2));
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }
}
