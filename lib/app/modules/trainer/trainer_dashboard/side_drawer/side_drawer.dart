import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainer/trainer_dashboard/side_drawer/side_drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../routes/app_pages.dart';
import '../trainer_dashboard/controllers/trainer_dashboard_controller.dart';

class SideDrawer extends GetView<SideDrawerController> {
  Function? onClosePress;

  SideDrawer(this.onClosePress, {super.key});

  @override
  var controller = Get.put(SideDrawerController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 16.0),
          child: IconButton(
            onPressed: () {
              onClosePress!();
            },
            icon: SvgPicture.asset(ImageResourceSvg.close),
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: AppStorage.isLogin() &&
                          AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER
                      ? [
                          menuItem(
                            1,
                            icon: ImageResourceSvg.home,
                            title: "Home",
                          ),
                          commonDivider(),
                          menuItem(
                            2,
                            icon: ImageResourceSvg.profile,
                            title: "My Profile",
                          ),
                          commonDivider(),
                          menuItem(
                            3,
                            icon: ImageResourceSvg.notification,
                            title: "Notifications",
                          ),
                          commonDivider(),
                          menuItem(
                            4,
                            icon: ImageResourceSvg.subscription,
                            title: "Subscription",
                          ),
                          commonDivider(),
                          menuItem(
                            11,
                            icon: ImageResourceSvg.history,
                            title: "History",
                          ),
                          // commonDivider(),
                          // menuItem(
                          //   5,
                          //   icon: ImageResourceSvg.resources,
                          //   title: "Resources",
                          // ),
                          commonDivider(),
                          menuItem(
                            6,
                            icon: ImageResourceSvg.switchUser,
                            title: "Switch User",
                          ),
                          commonDivider(),
                          menuItem(
                            7,
                            icon: ImageResourceSvg.terms,
                            title: "Terms & Condition",
                          ),
                          commonDivider(),
                          menuItem(
                            8,
                            icon: ImageResourceSvg.privacy,
                            title: "Privacy Policy",
                          ),
                          commonDivider(),
                          menuItem(
                            9,
                            icon: ImageResourceSvg.contact,
                            title: "Contact Us",
                          ),
                          commonDivider(),
                          menuItem(
                            10,
                            icon: ImageResourceSvg.share,
                            title: "Share App",
                          ),
                        ]
                      : AppStorage.isLogin() &&
                              AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
                          ? [
                              menuItem(
                                1,
                                icon: ImageResourceSvg.home,
                                title: "Home",
                              ),
                              commonDivider(),
                              menuItem(
                                2,
                                icon: ImageResourceSvg.profile,
                                title: "My Profile",
                              ),
                              commonDivider(),
                              menuItem(
                                3,
                                icon: ImageResourceSvg.icTDEE,
                                title: "TDEE Calc",
                              ),
                              commonDivider(),
                              menuItem(
                                4,
                                icon: ImageResourceSvg.subscription,
                                title: "Payment",
                              ),
                              commonDivider(),
                              menuItem(
                                11,
                                icon: ImageResourceSvg.history,
                                title: "History",
                              ),
                              commonDivider(),
                              menuItem(
                                5,
                                icon: ImageResourceSvg.notification,
                                title: "Notifications",
                              ),
                              commonDivider(),
                              menuItem(
                                6,
                                icon: ImageResourceSvg.icBecomeATrainer,
                                title: "Become a Trainer",
                              ),
                              commonDivider(),
                              menuItem(
                                7,
                                icon: ImageResourceSvg.contact,
                                title: "Contact Us",
                              ),
                              commonDivider(),
                              menuItem(
                                8,
                                icon: ImageResourceSvg.terms,
                                title: "Terms & Condition",
                              ),
                              commonDivider(),
                              menuItem(
                                9,
                                icon: ImageResourceSvg.privacy,
                                title: "Privacy Policy ",
                              ),
                              commonDivider(),
                              menuItem(
                                10,
                                icon: ImageResourceSvg.share,
                                title: "Share App",
                              ),
                            ]
                          : [
                              menuItem(
                                1,
                                icon: ImageResourceSvg.home,
                                title: "Home",
                              ),
                              commonDivider(),
                              menuItem(
                                6,
                                icon: ImageResourceSvg.contact,
                                title: "Contact Us",
                              ),
                              commonDivider(),
                              menuItem(
                                7,
                                icon: ImageResourceSvg.terms,
                                title: "Terms & Conditions",
                              ),
                              commonDivider(),
                              menuItem(
                                8,
                                icon: ImageResourceSvg.privacy,
                                title: "Privacy Policy",
                              ),
                              commonDivider(),
                              menuItem(
                                10,
                                icon: ImageResourceSvg.share,
                                title: "Share App",
                              ),
                            ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 14.0),
          child: InkWell(
            onTap: () {
              CustomMethod.logoutBottomSheet();
            },
            child: Row(
              children: [
                AppStorage.isLogin()
                    ? SvgPicture.asset(ImageResourceSvg.logout)
                    : const SizedBox.shrink(),
                const SizedBox(width: 10.0),
                Expanded(
                  child: AppStorage.isLogin()
                      ? Text("Log Out",
                          style: CustomTextStyles.medium(
                            fontColor: themeBlack,
                            fontSize: 13.0,
                          ))
                      : const SizedBox.shrink(),
                ),
                Text(
                  "Version 01.02",
                  style: CustomTextStyles.medium(fontSize: 14.0, fontColor: themeGrey),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  menuItem(index, {icon, title, hasSwitch = false, enable = true}) {
    return InkWell(
      onTap: enable
          ? () {
              controller.selectedIndex.value = index;
              onClosePress!();
              navigation(controller.selectedIndex.value);
            }
          : null,
      child: Obx(() => Container(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0),
            decoration: BoxDecoration(
                gradient: controller.selectedIndex.value == index
                    ? LinearGradient(colors: [
                        const Color(0xff4DDA65).withOpacity(1.0),
                        const Color(0xff4DDA65).withOpacity(0.0)
                      ])
                    : null),
            child: Row(
              children: [
                SvgPicture.asset(icon,
                    color: controller.selectedIndex.value == index ? themeBlack : themeGrey),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(title,
                      style: CustomTextStyles.semiBold(
                        fontColor: controller.selectedIndex.value == index ? themeBlack : themeGrey,
                        fontSize: 13.0,
                      )),
                ),
              ],
            ),
          )),
    );
  }

  navigation(index) {
    switch (index) {
      case 1:
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
          controller.selectedIndex.value = 1;
          var trainerCtr = Get.put(TrainerDashboardController());
          trainerCtr.onInit();
        } else {}
        break;
      case 2:
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
          Get.toNamed(Routes.CREATE_TRAINER_PROFILE,
              arguments: AppStorage.userData.result!.user.id);
        } else {
          Get.toNamed(Routes.PROFILE);
        }
        break;
      case 3:
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
          Get.toNamed(Routes.NOTIFICATION);
        } else {
          Get.toNamed(Routes.TDEE);
        }
        break;
      case 4:
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE) {
          Get.toNamed(Routes.ADD_CARD);
        } else {
          Get.toNamed(Routes.SUBSCRIPTION);
        }
        break;
      case 5:
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE) {
          Get.toNamed(Routes.NOTIFICATION);
        } else {
          Get.toNamed(Routes.TRAINER_RESOURCES);
        }
        break;
      case 6:
        if (!AppStorage.isLogin()) {
          Get.toNamed(Routes.CONTACT_US);
        } else {
          controller.confirmationBottomSheet();
        }

        break;
      case 7:
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
          Get.toNamed(Routes.PRIVACY_POLICY, arguments: "terms");
        } else if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE) {
          Get.toNamed(Routes.CONTACT_US);
        } else {
          Get.toNamed(Routes.PRIVACY_POLICY, arguments: "terms");
        }
        break;
      case 8:
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER || !AppStorage.isLogin()) {
          Get.toNamed(Routes.PRIVACY_POLICY, arguments: "privacy");
        } else {
          Get.toNamed(Routes.PRIVACY_POLICY, arguments: "terms");
        }
        break;
      case 9:
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
          Get.toNamed(Routes.CONTACT_US);
        } else {
          Get.toNamed(Routes.PRIVACY_POLICY, arguments: "privacy");
        }
        break;

      case 10:
        shareApp();
        break;

      case 11:
        Get.toNamed(Routes.HISTORY, arguments: "privacy");

        break;
    }
  }

  commonDivider() {
    return const SizedBox(height: 10.0);
  }
}
