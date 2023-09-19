import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/trainer_dashboard_%20model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/app_storage.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/constants.dart';
import '../../../../../core/services/notification_services.dart';

class TrainerDashboardController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final advancedDrawerController = AdvancedDrawerController();
  DateTime? currentBackPressTime;

  var userName = "".obs;
  var profilePic = "".obs;
  var trainerDashboardModel = TrainerDashboardModel();
  var isLoading = true.obs;
  var deviceToken = '';
  var deviceType = '';

  @override
  void onInit() {
    super.onInit();
    apiLoader(asyncCall: () => getTrainerDashboardDetail());
    getDeviceInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> onWillPop() {
    showSnackBar(
      title: "Exit",
      message: "Double tap again to exit",
    );
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  getDeviceInfo() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken = androidDeviceInfo.id;
      deviceType = 'android';
    } else {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken = iosDeviceInfo.identifierForVendor!;
      deviceType = 'ios';
    }

    await getDeviceInfoApi();
    initPushNotify();
  }

  void getTrainerDashboardDetail() {
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINER_DASHBOARD_DETAIL,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        trainerDashboardModel = trainerDashboardModelFromJson(responseBody);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  getDeviceInfoApi() {
    var body = {
      "userId": AppStorage.userData.result!.user.id,
      "deviceToken": deviceToken,
      "deviceType": deviceType,
      "fcmToken": AppStorage.fcmToken,
      "latitude": AppStorage.userData.result!.user.latitude,
      "longitude": AppStorage.userData.result!.user.longitude,
    };
    WebServices.postRequest(
      uri: EndPoints.Device_Info,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        var res = jsonDecode(responseBody);
        AppStorage.isNotificationIsRead.value =
            res['result']['notificationIsRead'] == 0 ? false : true;
      },
      onFailure: (error) {},
    );
  }
}
