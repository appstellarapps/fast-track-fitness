import 'package:fasttrackfitness/app/modules/auth/welcome/views/welcome_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> with WelcomesComponents {
  WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeWhite,
      body: welcomeView(),
    );
  }
}
