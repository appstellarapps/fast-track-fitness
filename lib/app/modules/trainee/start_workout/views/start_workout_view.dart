import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/modules/trainee/start_workout/views/start_workout_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/start_workout_controller.dart';

class StartWorkoutView extends GetView<StartWorkoutController> with StartWorkoutComponents {
  StartWorkoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (AppStorage.isCompleted.value == 0 && controller.startWorkoutList.isNotEmpty) {
          confirmationBottomSheet();
        }
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
            backgroundColor: themeWhite,
            appBar: ScaffoldAppBar.appBar(
                title: "START DAILY WORKOUT",
                onBackPressed: () {
                  if (AppStorage.isCompleted.value == 0 && controller.startWorkoutList.isNotEmpty) {
                    confirmationBottomSheet();
                  } else {
                    Get.back();
                  }
                }),
            body: Obx(
              () => controller.isLoading.value
                  ? const SizedBox.shrink()
                  : controller.startWorkoutList.isEmpty
                      ? noDataFound()
                      : ListView.separated(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          shrinkWrap: true,
                          itemBuilder: (context, mainIndex) {
                            return exerciseListView(mainIndex);
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 25,
                            );
                          },
                          itemCount: controller.startWorkoutList.length,
                        ),
            )),
      ),
    );
  }
}
