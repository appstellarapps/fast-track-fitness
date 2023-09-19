
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/get_exercise_workout_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/workout_calendar_controller.dart';

mixin MyWorkoutCalendarComponents {
  var controller = Get.put(WorkoutCalendarController());

  weekdayListView() {
    return SizedBox(
        height: 100,
        child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20, left: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return weekCalendar(index);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 20.0);
            },
            itemCount: controller.weekDayList.length));
  }

  planeView(Workout workout, index) {
    return InkWell(
      onTap: () {
        if (controller.tag == 0) {
          if (controller.weekDayList[controller.selectedWeekIndex].index == DateTime.now().day &&
              AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE &&
              workout.isExcerWorkoutStart == 0) {
            Get.toNamed(Routes.CREATE_WORKOUT, arguments: [
              controller.workoutList[index].type == "PreMade" ? 1 : 0,
              controller.workoutList[index].id,
              controller.workoutList[index].workoutDate,
              controller.id,
              true
            ]);
          } else {
            Get.toNamed(Routes.WORKOUT_DETAILS, arguments: [workout.workoutDate, workout.id]);
          }
        } else {
          if (controller.weekDayList[controller.selectedWeekIndex].index == DateTime.now().day &&
              AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE &&
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
                print('');
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

  weekCalendar(index) {
    return InkWell(
      onTap: () {
        for (var i = 0; i < controller.weekDayList.length; i++) {
          if (controller.weekDayList[i].isSelected.value) {
            controller.weekDayList[i].isSelected.value = false;
          }
        }
        controller.weekDayList[index].isSelected.value = true;

        if (controller.previousIndex != controller.weekDayList[index].index) {
          controller.selectedWeekIndex = index;
          controller.previousIndex = controller.weekDayList[index].index;
          controller.weekDayList[index].isSelected.value = true;
          controller.page = 1;
          controller.workoutList.clear();
          controller.isLoading.value = true;
          controller.selectedDate =
              "${controller.weekDayList[index].year}-${controller.weekDayList[index].month < 10 ? "0${controller.weekDayList[index].month}" : controller.weekDayList[index].month}-"
              "${controller.weekDayList[index].index < 10 ? "0${controller.weekDayList[index].index}" : controller.weekDayList[index].index}";
          apiLoader(asyncCall: () => controller.getMyWorkout());
        }
      },
      child: Obx(
        () => Container(
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: controller.weekDayList[index].isSelected.value
                ? themeGreen
                : const Color(0xffEBEBEB),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.weekDayList[index].day,
                style: CustomTextStyles.semiBold(fontSize: 10.0, fontColor: themeBlack),
              ),
              const SizedBox(height: 10.0),
              Text(
                controller.weekDayList[index].index.toString(),
                style: CustomTextStyles.bold(fontSize: 18.0, fontColor: themeBlack),
              ),
            ],
          ),
        ),
      ),
    );
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
}
