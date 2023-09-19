import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/my_diary/views/my_diary_components.dart';
import 'package:fasttrackfitness/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/images_resources.dart';
import '../controllers/my_diary_controller.dart';

class MyDiaryView extends GetView<MyDiaryController> with MyDiaryComponents {
  MyDiaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeWhite,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: inputGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 2.0,
              ),
            ),
            Obx(
              () => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 95, bottom: 75.0),
                  child: Column(
                    children: [
                      tabs(),
                      controller.isLoading.value
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Obx(() => tabItems()),
                                    controller.selectTabIndex.value != 2
                                        ? InkWell(
                                            onTap: () {
                                              if (AppStorage.isLogin()) {
                                                if (controller.selectTabIndex.value == 0) {
                                                  Get.toNamed(Routes.START_WORKOUT);
                                                } else {
                                                  Get.toNamed(Routes.START_TRACKING_CALORIES);
                                                }
                                              } else {
                                                CustomMethod.guestDialog();
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(20.0),
                                              padding: const EdgeInsets.all(10.0),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(20.0)),
                                                  color: themeGreen),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18.0),
                                                    child: SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: Stack(
                                                        children: [
                                                          Image.asset(
                                                            ImageResourcePng.startWorkOut,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 20.0),
                                                      child: Text(
                                                        controller.selectTabIndex.value == 0
                                                            ? "Start Workout"
                                                            : "Start Tracking Calories",
                                                        style: CustomTextStyles.bold(
                                                            fontSize: 18.0, fontColor: themeWhite),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 7.0),
                                                    child: SvgPicture.asset(
                                                        ImageResourceSvg.rightArrowIc,
                                                        color: themeWhite),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
