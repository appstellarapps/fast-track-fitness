import 'package:fasttrackfitness/app/core/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/otp_controller.dart';
import 'otp_components.dart';

class OtpView extends GetView<OtpController> with OTPComponents {
  OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helper().hideKeyBoard(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: false,
        body: otpView(),
        floatingActionButton: btnView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
