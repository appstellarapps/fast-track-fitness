import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/welcome_controller.dart';

mixin WelcomesComponents {
  var controller = Get.put(WelcomeController());

  welcomeView() {
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
        child: Center(
          child: Stack(alignment: Alignment.topCenter, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  ImageResourceSvg.logo,
                  height: 100,
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text(
                    "Fast Track Fitness",
                    style: CustomTextStyles.normalKusunagi(
                      fontSize: 16.0,
                      fontColor: themeWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 40),
                  child: Text(
                    "Welcome to The \n Home of Fitness!".toUpperCase(),
                    style: CustomTextStyles.semiBold(
                      fontSize: 28.0,
                      fontColor: themeWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0, top: 80.0),
                  child: ButtonRegular(
                    buttonText: "GET STARTED",
                    onPress: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
