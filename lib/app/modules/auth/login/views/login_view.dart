import 'package:fasttrackfitness/app/modules/auth/login/views/login_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> with LoginComponents {
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeWhite,
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: loginView(),
      floatingActionButton: nextBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
