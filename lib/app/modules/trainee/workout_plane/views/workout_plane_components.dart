import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/modules/trainee/workout_plane/controllers/workout_plane_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/get_exercise_workout_model.dart';
import '../../../../routes/app_pages.dart';

mixin WorkoutPlaneComponents {
  var controller = Get.put(WorkoutPlaneController());

  workoutListView() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          workoutTypeView(0),
          workoutTypeView(1),
          workoutTypeView(2),
        ],
      ),
    );
  }

  workoutTypeView(index) {
    return InkWell(
      onTap: () {
        var selectedTab = 0;
        for (int i = 0; i < controller.workTypeList.length; i++) {
          if (controller.workTypeList[i].isSelected.value) {
            selectedTab++;
          }
        }

        var isCallApi = selectedTab > 1 ? true : false;

        controller.workTypeList[index].isSelected.value =
            selectedTab > 1 && controller.workTypeList[index].isSelected.value ? false : true;

        controller.selectedTypeList.clear();
        for (int i = 0; i < controller.workTypeList.length; i++) {
          if (controller.workTypeList[i].isSelected.value) {
            controller.selectedTypeList.add(controller.workTypeList[i].title);
          }
        }

        if (controller.selectedTypeList.length != 1) {
          if (controller.selectedTypeList.isNotEmpty) {
            controller.page = 1;
            controller.workoutList.clear();
            controller.isLoading.value = true;
            apiLoader(asyncCall: () => controller.getMyWorkout());
          }
        } else {
          printLog(controller.selectedOldValue);
          printLog(controller.selectedTypeList[0]);

          if (isCallApi || controller.selectedOldValue != controller.selectedTypeList[0]) {
            controller.selectedOldValue = controller.selectedTypeList[0];
            controller.page = 1;
            controller.workoutList.clear();
            controller.isLoading.value = true;
            apiLoader(asyncCall: () => controller.getMyWorkout());
          }
        }
      },
      child: Obx(
        () => Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    color:
                        controller.workTypeList[index].isSelected.value ? themeGreen : colorGrey),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: Text(
                    controller.workTypeList[index].title == "PreMade"
                        ? "Library"
                        : controller.workTypeList[index].title,
                    style: CustomTextStyles.semiBold(
                      fontColor: controller.workTypeList[index].isSelected.value
                          ? themeBlack
                          : themeBlack50,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sortByView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (details) => showPopupMenu(Get.context, details),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Sort By",
                style: CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
              ),
            ),
            Obx(
              () => Text(
                controller.sortOutText.value,
                style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(
              ImageResourceSvg.sortBy,
            )
          ],
        ),
      ),
    );
  }

  planeView(Workout workout, index) {
    return InkWell(
      onTap: () {
        if (controller.tag == 0) {
          if (workout.isExcerWorkoutStart == 0 ||
              AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
            Get.toNamed(Routes.CREATE_WORKOUT, arguments: [
              controller.workoutList[index].type == "PreMade" ? 1 : 0,
              controller.workoutList[index].id,
              controller.workoutList[index].workoutDate,
              controller.id,
              true
            ]);
          } else {
            Get.toNamed(Routes.START_WORKOUT);
          }
        } else {
          if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE &&
              workout.isNutriWorkoutStart == 0) {
            Get.toNamed(Routes.CREATE_NUTRITION_WORKOUT, arguments: [
              controller.workoutList[index].type == "PreMade" ? 1 : 0,
              controller.workoutList[index].id,
              controller.workoutList[index].workoutDate,
              controller.id,
              true
            ]);
          } else {
            Get.toNamed(Routes.MEALS_DETAILS_VIEW,
                arguments: [workout.type, workout.id, workout.workoutDate]);
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        decoration: BoxDecoration(
          border: Border.all(color: colorGreyText, width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                print("object");
              },
              child: Container(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Text(
                      workout.type,
                      style: CustomTextStyles.bold(
                        fontColor: themeBlack50,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    workout.createdBy == "Trainer"
                        ? Container(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                            decoration: BoxDecoration(
                                color: themeGreen, borderRadius: BorderRadius.circular(12.0)),
                            child: Text(
                              "Trainer",
                              style:
                                  CustomTextStyles.semiBold(fontSize: 12.0, fontColor: themeWhite),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const Spacer(),
                    checkForEdit(index)
                  ],
                ),
              ),
            ),
            Container(
              height: 2,
              color: colorGreyText,
            ),
            Container(
              width: Get.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: inputGrey),
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.name,
                    style: CustomTextStyles.bold(
                      fontColor: themeBlack,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    controller.tag == 0
                        ? "${workout.workoutExcerciseDailyCount} Exercises"
                        : "${workout.workoutNutritionalDailyCount} Meals",
                    style: CustomTextStyles.normal(
                      fontColor: themeBlack50,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showPopupMenu(context, details) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ), //position where you want to show the menu on screen
      items: [
        const PopupMenuItem<String>(value: '1', child: Text('Ascending')),
        const PopupMenuItem<String>(value: '2', child: Text('Descending')),
      ],
      elevation: 8.0,
    ).then<void>((String? itemSelected) {
      if (itemSelected == null) return;
      if (controller.selectedTypeList.isNotEmpty) {
        if (itemSelected == "1") {
          controller.sortOutText.value = 'Ascending';
          controller.page = 1;
          controller.workoutList.clear();
          controller.isLoading.value = true;
          apiLoader(asyncCall: () => controller.getMyWorkout());
        } else {
          controller.sortOutText.value = 'Descending';
          controller.page = 1;
          controller.workoutList.clear();
          controller.isLoading.value = true;
          apiLoader(asyncCall: () => controller.getMyWorkout());
        }
      }
    });
  }

  showPopupMenuWithIcon(context, details, index) {
    showMenu<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),

      //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
            value: '1',
            child: Row(
              children: [
                SvgPicture.asset(ImageResourceSvg.edit),
                const SizedBox(width: 5.0),
                Text(
                  'Edit',
                  style: CustomTextStyles.normal(fontSize: 14.0, fontColor: themeBlack),
                ),
              ],
            )),
        PopupMenuItem<String>(
            value: '2',
            child: Row(
              children: [
                SvgPicture.asset(ImageResourceSvg.delete),
                const SizedBox(width: 5.0),
                Text(
                  controller.tag == 0 ? 'Remove workout' : "Remove Meal plan",
                  style: CustomTextStyles.normal(fontSize: 14.0, fontColor: Colors.red),
                ),
              ],
            )),
      ],
      elevation: 8.0,
    ).then<void>((String? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        if (controller.tag == 0) {
          Get.toNamed(Routes.CREATE_WORKOUT, arguments: [
            controller.workoutList[index].type == "PreMade" ? 1 : 0,
            controller.workoutList[index].id,
            controller.workoutList[index].workoutDate,
            controller.id,
            false
          ]);
        } else {
          Get.toNamed(Routes.CREATE_NUTRITION_WORKOUT, arguments: [
            controller.workoutList[index].type == "PreMade" ? 1 : 0,
            controller.workoutList[index].id,
            controller.workoutList[index].workoutDate,
            controller.id,
            false
          ]);
        }
      } else if (itemSelected == "2") {
        apiLoader(asyncCall: () => controller.removeExerciseWorkout(index));
      } else {
        //code here
      }
    });
  }

  createMealDialog() {
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
                    "Create A New",
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
                          "Custom Meal",
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
                            "Pre-Made Meal Plan",
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
                            if (controller.tag == 0) {
                              Get.toNamed(Routes.CREATE_WORKOUT, arguments: [
                                controller.workOutSelected.value,
                                '',
                                '',
                                controller.id,
                                false
                              ]);
                              // Get.toNamed(Routes.CREATE_MEAL);
                            } else {
                              Get.toNamed(Routes.CREATE_NUTRITION_WORKOUT, arguments: [
                                controller.workOutSelected.value,
                                '',
                                '',
                                controller.id,
                                false
                              ]);
                            }

                            // Get.toNamed(Routes.CREATE_MEAL);
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

  createWorkoutDialog() {
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
                          "Custom Workout",
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
                            "Pre-Made Workout",
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
                            if (controller.tag == 0) {
                              Get.toNamed(Routes.CREATE_WORKOUT, arguments: [
                                controller.workOutSelected.value,
                                '',
                                '',
                                controller.id,
                                false
                              ]);
                              // Get.toNamed(Routes.CREATE_MEAL);
                            } else {
                              Get.toNamed(Routes.CREATE_NUTRITION_WORKOUT, arguments: [
                                controller.workOutSelected.value,
                                '',
                                '',
                                controller.id,
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

  checkForEdit(index) {
    if (controller.workoutList[index].endDate.isAfter(DateTime.now()) ||
        controller.workoutList[index].endDate ==
            (DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
      if (controller.workoutList[index].createdBy == "Trainee") {
        if (controller.tag == 0 && controller.workoutList[index].isExcerWorkoutStart == 0) {
          return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (details) => showPopupMenuWithIcon(Get.context, details, index),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
                    ? SvgPicture.asset(ImageResourceSvg.threeDot)
                    : const SizedBox.shrink(),
              ));
        } else {
          if (controller.tag == 1 && controller.workoutList[index].isNutriWorkoutStart == 0) {
            return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (details) => showPopupMenuWithIcon(Get.context, details, index),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
                      ? SvgPicture.asset(ImageResourceSvg.threeDot)
                      : const SizedBox.shrink(),
                ));
          } else {
            return const SizedBox.shrink();
          }
        }
      } else if (controller.workoutList[index].createdBy == "Trainer") {
        if (controller.tag == 0 && controller.workoutList[index].isExcerWorkoutStart == 0) {
          return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (details) => showPopupMenuWithIcon(Get.context, details, index),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER
                    ? SvgPicture.asset(ImageResourceSvg.threeDot)
                    : const SizedBox.shrink(),
              ));
        } else {
          if (controller.tag == 1 && controller.workoutList[index].isNutriWorkoutStart == 0) {
            return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (details) => showPopupMenuWithIcon(Get.context, details, index),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER
                      ? SvgPicture.asset(ImageResourceSvg.threeDot)
                      : const SizedBox.shrink(),
                ));
          } else {
            return const SizedBox.shrink();
          }
        }
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
