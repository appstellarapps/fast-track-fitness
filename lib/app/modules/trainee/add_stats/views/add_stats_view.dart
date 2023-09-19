
import 'package:fasttrackfitness/app/modules/trainee/add_stats/views/add_stats_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../controllers/add_stats_controller.dart';

class AddStatsView extends GetView<AddStatsController> with AddStatsComponents {
  AddStatsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: themeWhite,
        appBar: ScaffoldAppBar.appBar(
          title: "Add Stats",
          onBackPressed: () {
            Get.back();
          },
        ),
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? const SizedBox.shrink()
                    : controller.statsList.isEmpty
                        ? noDataFound()
                        : Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            color: inputGrey,
                            child: ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10.0),
                                itemBuilder: (context, index) {
                                  return statsView(index);
                                },
                                separatorBuilder: (_, index) {
                                  return Container(
                                    height: 20.0,
                                  );
                                },
                                itemCount: controller.statsList.length),
                          ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: colorGreyText,
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonRegular(
                      verticalPadding: 14.0,
                      buttonText: "Cancel",
                      onPress: () {
                        Get.back();
                      },
                      color: colorGreyText,
                    ),
                  ),
                  Expanded(
                    child: ButtonRegular(
                        verticalPadding: 14.0,
                        buttonText: "Save",
                        onPress: () {
                          controller.checkForUpdate();
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
