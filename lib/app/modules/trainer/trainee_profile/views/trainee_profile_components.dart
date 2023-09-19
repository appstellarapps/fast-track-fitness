
import 'package:fasttrackfitness/app/modules/trainer/trainee_profile/controllers/trainee_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/my_diary_model.dart';
import '../../../../routes/app_pages.dart';

mixin TraineeProfileComponents {
  var controller = Get.put(TraineeProfileController());

  appBar() {
    return Container(
      decoration: const BoxDecoration(
        color: themeBlack,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(ImageResourceSvg.backArrowIc)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: circleProfileNetworkImage(
                      borderRadius: 15.0,
                      width: 80,
                      height: 80,
                      networkImage: controller.userProfile,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    controller.userName,
                    style: CustomTextStyles.semiBold(
                      fontSize: 16.0,
                      fontColor: themeWhite,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    controller.phoneNo,
                    style: CustomTextStyles.medium(
                      fontSize: 14.0,
                      fontColor: themeWhite,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  listItem(DiaryItem diaryItem, int index) {
    return InkWell(
      onTap: () {
        if (controller.isFrom == 0) {
          if (index == 0) {
            Get.toNamed(Routes.WORKOUT_PLANE, arguments: [0, controller.traineeId]);
          } else if (index == 1) {
            Get.toNamed(Routes.WORKOUT_CALENDAR, arguments: [0, controller.traineeId]);
          } else if (index == 3) {
            createWorkoutDialog('Custom Workout', 'Pre-Made Workout');
          } else {
            Get.toNamed(Routes.USER_STATS, arguments: [controller.traineeId, 0]);
          }
        } else {
          if (index == 0) {
            Get.toNamed(Routes.WORKOUT_PLANE, arguments: [1, controller.traineeId]);
          } else if (index == 1) {
            Get.toNamed(Routes.WORKOUT_CALENDAR, arguments: [1, controller.traineeId]);
          } else if (index == 3) {
            createWorkoutDialog('Custom Meal', 'Pre-Made Meal Plan');
          } else {
            Get.toNamed(Routes.USER_STATS, arguments: [controller.traineeId, 1]);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: colorGreyEditText,
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: SizedBox(
                height: 70.0,
                width: 70.0,
                child: Image.asset(
                  diaryItem.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      diaryItem.title,
                      style: CustomTextStyles.bold(
                        fontSize: 15.0,
                        fontColor: themeBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: diaryItem.description.isNotEmpty ? 5.0 : 0.0),
                  diaryItem.description.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            diaryItem.description,
                            style: CustomTextStyles.semiBold(
                              fontSize: 14.0,
                              fontColor: themeBlack50,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(height: diaryItem.description.isNotEmpty ? 5.0 : 0.0),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SvgPicture.asset(ImageResourceSvg.rightArrowIc,
                    color: diaryItem.description.isNotEmpty ? themeBlack : themeTransparent)),
          ],
        ),
      ),
    );
  }

  createWorkoutDialog(titleOne, titleTwo) {
    return Get.bottomSheet(
        SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                color: themeWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create A Workout",
                    style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      controller.workOutSelected.value = 0;
                    },
                    child: Obx(
                      () => Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: colorGreyText),
                            borderRadius: BorderRadius.circular(10),
                            color: controller.workOutSelected.value == 0
                                ? themeGreen
                                : Colors.transparent),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          titleOne,
                          style: CustomTextStyles.semiBold(
                            fontColor:
                                controller.workOutSelected.value == 0 ? themeWhite : themeBlack,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        controller.workOutSelected.value = 1;
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: colorGreyText),
                              borderRadius: BorderRadius.circular(10),
                              color: controller.workOutSelected.value == 1
                                  ? themeGreen
                                  : Colors.transparent),
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            titleTwo,
                            style: CustomTextStyles.semiBold(
                              fontColor:
                                  controller.workOutSelected.value == 1 ? themeWhite : themeBlack,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
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
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: ButtonRegular(
                          verticalPadding: 14.0,
                          buttonText: "Next",
                          onPress: () {
                            Get.back();
                            Get.back();
                            if (controller.isFrom == 0) {
                              Get.toNamed(Routes.CREATE_WORKOUT, arguments: [
                                controller.workOutSelected.value,
                                '',
                                '',
                                controller.traineeId,
                                false
                              ]);
                              // Get.toNamed(Routes.CREATE_MEAL);
                            } else {
                              Get.toNamed(Routes.CREATE_NUTRITION_WORKOUT, arguments: [
                                controller.workOutSelected.value,
                                '',
                                '',
                                controller.traineeId,
                                false
                              ]);
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }
}
