import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/modules/trainee/my_sessions/views/my_session_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/my_sessions_controller.dart';

class MySessionsView extends GetView<MySessionsController>
    with MySessionComponents {
  MySessionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeWhite,
        body: Column(
          children: [
            sessionTabs(),
            Obx(
              () => controller.isLoading.value
                  ? const SizedBox.shrink()
                  : Expanded(
                      child: controller.selectedSession.value == 1
                          ? controller.traineeOnGoingBookings.isEmpty
                              ? noDataFound()
                              : onGoingListView()
                          : controller.selectedSession.value == 2
                              ? controller.traineeUpComingBookings.isEmpty
                                  ? noDataFound()
                                  : pendingListView()
                              : historyTabView(),
                    ),
            ),
          ],
        ));
  }
}
