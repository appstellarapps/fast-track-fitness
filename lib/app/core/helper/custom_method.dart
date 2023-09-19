import 'dart:convert';

import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/trainee_dashboard/trainee_dashboard/controllers/trainee_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../routes/app_pages.dart';
import '../services/web_services.dart';
import 'app_storage.dart';
import 'common_widget/custom_app_widget.dart';
import 'common_widget/custom_button.dart';
import 'constants.dart';

class CustomMethod {
  static String convertDateFormat(String dateTimeString, String oldFormat, String newFormat) {
    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }

  static showFullImages(path) {
    return showDialog(
        context: Get.context!,
        builder: (_) => Material(
              color: themeWhite,
              child: Stack(
                children: [
                  PhotoView(
                    imageProvider: NetworkImage(path),
                  ),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: themeWhite,
                      ))
                ],
              ),
            ));
  }

  static checkTime(timeString) {
    Duration duration = Duration(
      hours: int.parse(timeString.split(':')[0]),
      minutes: int.parse(timeString.split(':')[1]),
      seconds: int.parse(timeString.split(':')[2]),
    );
    if (duration.inHours > 1) {
      return "${duration.inHours} Hours";
    } else if (duration.inMinutes > 1) {
      return "${duration.inMinutes} Minute";
    } else {
      return "${duration.inSeconds} Seconds";
    }
  }

  static guestDialog() {
    var ctr = Get.put(TraineeDashboardController());

    return Get.bottomSheet(
        WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: themeWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOGIN",
                          style: CustomTextStyles.bold(fontColor: themeBlack, fontSize: 24.0),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(ImageResourceSvg.logout)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                    child: Text(
                      "You are currently in guest mode. Please log in to access this feature.",
                      style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: ButtonRegular(
                      verticalPadding: 14.0,
                      buttonText: "Ok",
                      onPress: () {
                        if (Get.isBottomSheetOpen!) Get.back();
                        Get.toNamed(Routes.LOGIN);
                      },
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      if (ctr.selectedTab.value == 3) {
                        ctr.selectedTab.value = 0;
                      }
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: colorGreyText),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancel",
                        style: CustomTextStyles.semiBold(
                          fontColor: themeBlack,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        isDismissible: ctr.selectedTab.value == 3 ? false : true,
        enableDrag: ctr.selectedTab.value == 3 ? false : true,
        isScrollControlled: false);
  }

  static subscriptionDialog(amount, validity) {
    return Get.bottomSheet(
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: false,
        WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: themeWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 30, right: 30),
                    child: Text(
                      'Please purchase the $validity subscription of AU $amount to access the library diary with validity of $validity.',
                      style: CustomTextStyles.semiBold(fontColor: colorGreyText, fontSize: 13.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: ButtonRegular(
                      verticalPadding: 14.0,
                      buttonText: "Subscribe",
                      onPress: () {
                        var ctr = Get.put(TraineeDashboardController());
                        ctr.selectedTab.value = 0;
                        Get.back();

                        Get.toNamed(Routes.ADD_CARD);
                      },
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      if (Get.isBottomSheetOpen!) {
                        Get.back();
                      }
                      Get.back();
                      var ctr = Get.put(TraineeDashboardController());
                      ctr.selectedTab.value = 0;
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: colorGreyText),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Home",
                        style: CustomTextStyles.semiBold(
                          fontColor: themeBlack,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  static logoutBottomSheet() {
    return Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Logout",
                  style: CustomTextStyles.bold(fontColor: themeBlack, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Are you sure you want to Logout?",
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40.0,
                ),
                child: ButtonRegular(
                  verticalPadding: 14.0,
                  buttonText: "Ok",
                  onPress: () {
                    if (Get.isBottomSheetOpen!) Get.back();
                    apiLoader(asyncCall: () => logoutAPI());
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: colorGreyText),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Cancel",
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }

  static logoutAPI() {
    print("this is auth token ${AppStorage.userData.result?.accessToken}");
    WebServices.postRequest(
      uri: EndPoints.LOG_OUT,
      hasBearer: true,
      hideLoaderOnFail: true,
      hideLoaderOnSuccess: true,
      onStatusSuccess: (responseBody) {
        var res = jsonDecode(responseBody);
        if (res['status'] == 1) {
          AppStorage.setAppLogin(false);
          FTFGlobal.firstName.value = '';
          FTFGlobal.lastName.value = '';
          FTFGlobal.mobileNo.value = '';
          FTFGlobal.email.value = '';
          FTFGlobal.userProfilePic.value = '';
          FTFGlobal.userName.value = '';

          AppStorage.box.erase();

          Get.offAllNamed(Routes.LOGIN);
        }
      },
      onFailure: (error) {},
    );
  }
}
