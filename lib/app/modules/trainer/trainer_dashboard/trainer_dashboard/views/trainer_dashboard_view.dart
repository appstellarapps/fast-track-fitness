import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/modules/trainer/trainer_dashboard/trainer_dashboard/views/trainer_dashboard_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_drawer.dart';
import '../../../../../core/helper/constants.dart';
import '../../../../../core/helper/images_resources.dart';
import '../../../../../core/helper/text_style.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/trainer_dashboard_controller.dart';

class TrainerDashboardView extends GetView<TrainerDashboardController>
    with TrainerDashboardComponents {
  TrainerDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonDrawer(
        advancedDrawerController: controller.advancedDrawerController,
        mainWidget: WillPopScope(
          onWillPop: () => controller.onWillPop(),
          child: Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              color: themeGreen,
              onRefresh: () async {
                controller.onInit();
              },
              child: Obx(
                () => Stack(
                  children: [
                    controller.isLoading.value
                        ? const SizedBox.shrink()
                        : controller.trainerDashboardModel.result == null
                            ? noDataFound(imageHeight: 200)
                            : dashboardList(),
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
                                controller.advancedDrawerController.showDrawer();
                              },
                              child: SvgPicture.asset(ImageResourceSvg.dashboard),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Hello,",
                                    style: CustomTextStyles.normal(
                                      fontSize: 15.0,
                                      fontColor: themeWhite,
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
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.NOTIFICATION);
                              },
                              child: Obx(() => AppStorage.isNotificationIsRead.value
                                  ? SvgPicture.asset(ImageResourceSvg.mainNotification)
                                  : SvgPicture.asset(ImageResourceSvg.notificationTwo)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonBottomContainer(
                              icon: ImageResourceSvg.blackResources,
                              title: "Resources",
                              onTap: () {
                                Get.toNamed(Routes.RESOURCE);
                              },
                            ),
                            // const SizedBox(width: 10.0),
                            // commonBottomContainer(
                            //   icon: ImageResourceSvg.blackDownload,
                            //   title: "Downloads",
                            //   onTap: () {},
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
