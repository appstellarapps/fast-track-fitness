import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../controllers/exercise_details_controller.dart';
import 'exercise_details_components.dart';

class ExerciseDetailsView extends GetView<ExerciseDetailsController>
    with ExerciseDetailsComponents {
  ExerciseDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: themeWhite,
        bottomSheet: controller.tag == 1 && controller.isExercise == 0
            ? Obx(() => Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20, top: 20),
                  child: ButtonRegular(
                    buttonText: controller.isPreMadeAlreadyAdded.value
                        ? "Remove Pre-Made Workout"
                        : "Add Pre-Made Workout",
                    onPress: () {
                      if (controller.isPreMadeAlreadyAdded.value) {
                        for (final val1 in controller.getResourcesExerciseList) {
                          AppStorage.userSelectedExerciseList
                              .removeWhere((element) => element.id == val1.id);
                        }
                      } else {
                        AppStorage.userSelectedExerciseList
                            .addAll(controller.getResourcesExerciseList);
                      }
                      Get.back();
                    },
                  ),
                ))
            : controller.tag == 1 && controller.isExercise == 1 && !controller.isFromResource
                ? Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20, top: 20),
                      child: ButtonRegular(
                        buttonText: controller.isPreMadeAlreadyAdded.value ? "Remove" : "Add",
                        onPress: () {
                          if (controller.isPreMadeAlreadyAdded.value) {
                            for (final val1 in controller.getPreMadeMealList) {
                              AppStorage.preMadeMealLIst
                                  .removeWhere((element) => element.id == val1.categoryId);
                            }
                          } else {
                            AppStorage.preMadeMealLIst.add(controller.preMadeMealDetails.result!);
                          }
                          Get.back();
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
        body: Obx(() => controller.isLoading.value
            ? const SizedBox.shrink()
            : controller.isExercise == 0 && controller.exerciseDetailsModel.result != null
                ? mainExerciseView()
                : controller.isExercise == 1 && controller.tag == 0
                    ? customMealView()
                    : controller.isExercise == 1 && controller.tag == 1
                        ? preMadeMealView()
                        : Container()),
      ),
    );
  }
}
