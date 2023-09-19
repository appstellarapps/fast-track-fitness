import 'package:fasttrackfitness/app/modules/trainer/user_stats/views/user_stats_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/user_stats_controller.dart';

class UserStatsView extends GetView<UserStatsController> with UserStatsComponents {
  UserStatsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeWhite,
        appBar: ScaffoldAppBar.appBar(title: "Trainee Stats"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    myStateTab(0, tabText: "Exercise"),
                    myStateTab(1, tabText: "Nutritional"),
                  ],
                ),
                Obx(() => controller.isTabLoading.value
                    ? Padding(
                        padding: EdgeInsets.only(top: Get.height / 3.5),
                        child: const CircularProgressIndicator(
                          color: themeGreen,
                        ),
                      )
                    : controller.selectedStateIndex.value == 0
                        ? exerciseStateView()
                        : nutritionalStateView())
              ],
            ),
          ),
        ));
  }
}
