import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/modules/notification/views/notification_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> with NotificationComponents {
  NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeWhite,
      appBar: ScaffoldAppBar.appBar(title: "Notifications"),
      body: Obx(() => controller.isLoading.value
          ? const SizedBox.shrink()
          : controller.notificationList.isEmpty
              ? noDataFound()
              : ListView.separated(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0, bottom: 16.0),
                  itemBuilder: (context, index) {
                    if (index == controller.notificationList.length - 1 &&
                        controller.haseMore.value) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child:
                              SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
                        ),
                      );
                    }
                    return notificationItem(controller.notificationList[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10.0);
                  },
                  itemCount: controller.notificationList.length)),
    );
  }
}
