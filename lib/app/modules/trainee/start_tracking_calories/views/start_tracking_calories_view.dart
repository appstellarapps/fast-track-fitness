import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/helper.dart';
import 'package:fasttrackfitness/app/modules/trainee/start_tracking_calories/views/start_tracking_calories_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/start_tracking_calories_controller.dart';

class StartTrackingCaloriesView extends GetView<StartTrackingCaloriesController>
    with StartTrackingCaloriesComponents {
  StartTrackingCaloriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () async {
          // for (var i = 0; i < controller.workoutList.length; i++) {
          //   for (var j = 0; j < controller.workoutList[i].workoutNutritionalDaily.length; j++) {
          //     for (var k = 0;
          //         k <
          //             controller.workoutList[i].workoutNutritionalDaily[j]
          //                 .workoutNutritionalMealDaily.length;
          //         k++) {
          //       if (controller.workoutList[i].workoutNutritionalDaily[j]
          //               .workoutNutritionalMealDaily[k].isSelected.value &&
          //           controller.workoutList[i].workoutNutritionalDaily[j]
          //                   .workoutNutritionalMealDaily[k].controller.text !=
          //               '0') {
          //         await apiLoader(
          //             asyncCall: () => controller.getMealCalculation(
          //                 i,
          //                 j,
          //                 k,
          //                 controller.workoutList[i].workoutNutritionalDaily[j]
          //                     .workoutNutritionalMealDaily[k].controller.value.text));
          //         controller.workoutList[i].workoutNutritionalDaily[j]
          //             .workoutNutritionalMealDaily[k].isSelected.value = false;
          //       }
          //     }
          //   }
          // }
          Helper().hideKeyBoard();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: themeWhite,
          appBar: ScaffoldAppBar.appBar(
            title: "START DAILY WORKOUT",
            onBackPressed: () {
              Get.back();
            },
          ),
          body: Obx(
            () => controller.isLoading.value
                ? const SizedBox.shrink()
                : controller.workoutList.isEmpty
                    ? noDataFound()
                    : startNutritionalWorkoutList(context),
          ),
        ),
      ),
    );
  }
}
