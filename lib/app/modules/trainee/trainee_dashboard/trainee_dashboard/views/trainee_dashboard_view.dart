import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/app_storage.dart';
import '../../../../../core/helper/common_widget/custom_drawer.dart';
import '../../../../../core/helper/constants.dart';
import '../../../../../core/helper/images_resources.dart';
import '../../../../../core/helper/text_style.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/trainee_dashboard_controller.dart';
import 'trainee_dashboard_components.dart';

class TraineeDashboardView extends GetView<TraineeDashboardController>
    with TraineeDashboardComponents {
  TraineeDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(),
      child: Scaffold(
        backgroundColor: themeBlack,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: CommonDrawer(
          advancedDrawerController: controller.advancedDrawerController,
          mainWidget: Scaffold(
            resizeToAvoidBottomInset: false,
            key: controller.scaffoldKey,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Obx(() => screens()),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: themeBlack,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (controller.isDashboardLoading.isFalse) {
                                controller.advancedDrawerController.showDrawer();
                              }
                            },
                            child: SvgPicture.asset(ImageResourceSvg.guestUserIc)),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Hello,${!AppStorage.isLogin() ? "Guest" : ""}",
                                style: CustomTextStyles.normal(
                                  fontSize: 14.0,
                                  fontColor: themeLightWhite,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  FTFGlobal.userName.value.isEmpty
                                      ? "Welcome"
                                      : FTFGlobal.userName.value,
                                  style: CustomTextStyles.bold(
                                    fontColor: themeWhite,
                                    fontSize: 18.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        IconButton(
                            onPressed: () {
                              if (controller.isDashboardLoading.isFalse) {
                                Get.toNamed(Routes.GLOBAL_SEARCH);
                              }
                            },
                            icon: SvgPicture.asset(ImageResourceSvg.searchIc)),
                        const SizedBox(width: 16.0),
                        InkWell(
                          onTap: () {
                            if (AppStorage.isLogin() && controller.isDashboardLoading.isFalse) {
                              Get.toNamed(Routes.NOTIFICATION);
                            } else {
                              CustomMethod.guestDialog();
                            }
                          },
                          child: Obx(
                            () => AppStorage.isNotificationIsRead.value
                                ? SvgPicture.asset(ImageResourceSvg.mainNotification)
                                : SvgPicture.asset(ImageResourceSvg.notificationTwo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: themeWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffE5E5E5),
                            spreadRadius: 0.5,
                            blurRadius: 10.0,
                            offset: Offset(0.0, -5.0),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonTab(0, icon: ImageResourceSvg.icFooterHome, activeText: "Home"),
                          commonTab(1,
                              icon: ImageResourceSvg.trainingTabIc, activeText: "My Sessions"),
                          commonTab(2, icon: ImageResourceSvg.diaryTabIc, activeText: "Diary"),
                          commonTab(3,
                              icon: ImageResourceSvg.resourceTabIc, activeText: "Resources"),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
