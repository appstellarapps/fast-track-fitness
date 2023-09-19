import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../core/helper/constants.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController

  ScrollController scrollController = ScrollController();

  var haseMore = false.obs;
  var page = 1;
  var notificationList = <NotificationsData>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    apiLoader(asyncCall: () => getNotificationAPI());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  scroll() {
    if (scrollController.position.maxScrollExtent - 500 == scrollController.position.pixels - 500) {
      if (haseMore.value) {
        page++;
        getNotificationAPI();
      }
    }
  }

  void getNotificationAPI() {
    var body = {'page': page};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_NOTIFICATION,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        NotificationModel notificationModel = notificationModelFromJson(responseBody);
        notificationList.addAll(notificationModel.result!.notification!);
        haseMore.value = notificationModel.result!.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
        AppStorage.isNotificationIsRead.value = false;
        hideAppLoader();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void acceptRejectScheduleReqByTrainerAPI({bookingId, action}) {
    var body = {"bookingId": bookingId, "action": action};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.ACC_REJ_SCHEDULE_REQ,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        Get.closeAllSnackbars();
        hideAppLoader();
        isLoading.value = false;
        Get.back();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
