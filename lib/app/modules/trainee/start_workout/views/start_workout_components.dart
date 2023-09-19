import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/start_workout/controllers/start_workout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/custom_method.dart';
import '../../../../data/get_start_work_out_model.dart';
import '../../../../routes/app_pages.dart';

mixin StartWorkoutComponents {
  var controller = Get.put(StartWorkoutController());

  setView(mainIndex, subIndex, subChildIndex) {
    return Obx(() => Row(
          children: [
            Text(
              "Set ${subChildIndex + 1} :  ",
              style: CustomTextStyles.normal(fontSize: 15.0, fontColor: themeBlack),
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 40,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          margin: const EdgeInsets.only(left: 0.0, right: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colorGreyText)),
                          child: Text(
                            controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                                .workoutExcerciseSetsDaily[subChildIndex].reps
                                .toString(),
                            style: CustomTextStyles.normal(fontSize: 13.0, fontColor: themeBlack),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.only(right: 5, left: 5, top: 0),
                        margin: const EdgeInsets.only(right: 10),
                        color: themeWhite,
                        child: Text('Resp',
                            style:
                                CustomTextStyles.normal(fontSize: 10.0, fontColor: colorGreyText)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 40,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          margin: const EdgeInsets.only(left: 0.0, right: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colorGreyText)),
                          child: Text(
                            "${controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex].workoutExcerciseSetsDaily[subChildIndex].weight} kg",
                            style: CustomTextStyles.normal(fontSize: 13.0, fontColor: themeBlack),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                        margin: const EdgeInsets.only(right: 10),
                        color: themeWhite,
                        child: Text(
                          'Weight',
                          style: CustomTextStyles.normal(fontSize: 10.0, fontColor: colorGreyText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (!controller.isDone.value) {
                  RxList<WorkoutExcerciseSetsDaily> workOutSetDailyList = controller
                      .startWorkoutList[mainIndex]
                      .workoutExcerciseDaily[subIndex]
                      .workoutExcerciseSetsDaily
                      .obs;
                  if (workOutSetDailyList[subChildIndex].isCompleted.value == 0) {
                    for (var i = 0; i < controller.startWorkoutList.length; i++) {
                      for (var j = 0;
                          j < controller.startWorkoutList[i].workoutExcerciseDaily.length;
                          j++) {
                        for (var k = 0;
                            k <
                                controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                    .workoutExcerciseSetsDaily.length;
                            k++) {
                          if (controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                  .workoutExcerciseSetsDaily[k].isStarted.value &&
                              controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                      .workoutExcerciseSetsDaily[k].id !=
                                  controller
                                      .startWorkoutList[mainIndex]
                                      .workoutExcerciseDaily[subIndex]
                                      .workoutExcerciseSetsDaily[subChildIndex]
                                      .id) {
                            controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                .workoutExcerciseSetsDaily[k].isStarted.value = false;
                            controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                .workoutExcerciseSetsDaily[k].workingFlag.value = 'Pause';
                            controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                    .workoutExcerciseSetsDaily[k].workoutTimeFormat.value =
                                controller.formatSecondsToMinuteSeconds(controller
                                    .startWorkoutList[i]
                                    .workoutExcerciseDaily[j]
                                    .workoutExcerciseSetsDaily[k]
                                    .localSecond
                                    .value);
                            controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                .workoutExcerciseSetsDaily[k].timer!
                                .cancel();

                            controller.isDone.value = true;
                            controller.actionWorkout(i, j, k);
                          }
                        }
                      }
                    }

                    if (!workOutSetDailyList[subChildIndex].isStarted.value) {
                      controller.startTimer(mainIndex, subIndex, subChildIndex);
                      workOutSetDailyList[subChildIndex].workoutTimeFormat.value =
                          controller.formatSecondsToMinuteSeconds(
                              workOutSetDailyList[subChildIndex].localSecond.value);
                      workOutSetDailyList[subChildIndex].isStarted.value = true;
                      workOutSetDailyList[subChildIndex].workingFlag.value = 'Start';

                      controller.isDone.value = true;
                      controller.actionWorkout(mainIndex, subIndex, subChildIndex);
                    } else {
                      workOutSetDailyList[subChildIndex].timer!.cancel();
                      workOutSetDailyList[subChildIndex].workoutTimeFormat.value =
                          controller.formatSecondsToMinuteSeconds(
                              workOutSetDailyList[subChildIndex].localSecond.value);

                      workOutSetDailyList[subChildIndex].isStarted.value = false;
                      workOutSetDailyList[subChildIndex].workingFlag.value = 'Pause';
                      workOutSetDailyList[subChildIndex].isCompleted.value = 0;

                      controller.isDone.value = true;
                      controller.actionWorkout(mainIndex, subIndex, subChildIndex);
                    }
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: SvgPicture.asset(
                  controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                          .workoutExcerciseSetsDaily[subChildIndex].workingFlag.isEmpty
                      ? ImageResourceSvg.start
                      : controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                                  .workoutExcerciseSetsDaily[subChildIndex].workingFlag.value ==
                              "Start"
                          ? ImageResourceSvg.pause
                          : controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                                      .workoutExcerciseSetsDaily[subChildIndex].isCompleted.value ==
                                  1
                              ? ImageResourceSvg.greyStart
                              : ImageResourceSvg.start,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (!controller.isDone.value) {
                  RxList<WorkoutExcerciseSetsDaily> workOutSetDailyList = controller
                      .startWorkoutList[mainIndex]
                      .workoutExcerciseDaily[subIndex]
                      .workoutExcerciseSetsDaily
                      .obs;

                  if (workOutSetDailyList[subChildIndex].workingFlag.isNotEmpty &&
                      workOutSetDailyList[subChildIndex].isCompleted.value == 0) {
                    if (workOutSetDailyList[subChildIndex].timer != null) {
                      workOutSetDailyList[subChildIndex].timer!.cancel();
                    }
                    workOutSetDailyList[subChildIndex].isStarted.value = false;
                    workOutSetDailyList[subChildIndex].workingFlag.value = 'End';
                    workOutSetDailyList[subChildIndex].isCompleted.value = 1;
                    workOutSetDailyList[subChildIndex].workoutTimeFormat.value =
                        controller.formatSecondsToMinuteSeconds(
                            workOutSetDailyList[subChildIndex].localSecond.value);
                    controller.isDone.value = true;
                    var allCompleted = true;
                    for (var a in controller.startWorkoutList) {
                      for (var b in a.workoutExcerciseDaily) {
                        for (var c in b.workoutExcerciseSetsDaily) {
                          if (c.isCompleted.value != 1) {
                            controller.endItemList.removeWhere((id) => id == a.id);
                            allCompleted = false;
                          } else {
                            controller.endItemList
                                .addIf(!controller.endItemList.contains(a.id), a.id);
                          }
                        }
                      }
                    }

                    if (allCompleted) {
                      AppStorage.isCompleted.value = 1;
                      completedBottomSheet();
                    }
                    controller.actionWorkout(mainIndex, subIndex, subChildIndex);
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: SvgPicture.asset(controller
                                .startWorkoutList[mainIndex]
                                .workoutExcerciseDaily[subIndex]
                                .workoutExcerciseSetsDaily[subChildIndex]
                                .isCompleted
                                .value ==
                            1 ||
                        controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                            .workoutExcerciseSetsDaily[subChildIndex].workingFlag.isEmpty
                    ? ImageResourceSvg.greyEnd
                    : ImageResourceSvg.end),
              ),
            ),
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: themeBlack),
                padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
                child: Obx(
                  () => Text(
                    controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                            .workoutExcerciseSetsDaily[subChildIndex].isStarted.value
                        ? controller.formatSecondsToMinuteSeconds(controller
                            .startWorkoutList[mainIndex]
                            .workoutExcerciseDaily[subIndex]
                            .workoutExcerciseSetsDaily[subChildIndex]
                            .localSecond
                            .value)
                        : controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                            .workoutExcerciseSetsDaily[subChildIndex].workoutTimeFormat.value,
                    style: CustomTextStyles.medium(fontSize: 12.0, fontColor: themeWhite),
                  ),
                ))
          ],
        ));
  }

  disabledSetView(mainIndex, subIndex, subChildIndex) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: colorGreyText),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: themeBlack),
            child: Text(
              "${subIndex + 1}",
              style: CustomTextStyles.normal(fontSize: 15.0, fontColor: themeWhite),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              Text(
                controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                    .workoutExcerciseSetsDaily[subChildIndex].reps
                    .toString(),
                style: CustomTextStyles.medium(fontSize: 16.0, fontColor: themeBlack),
                textAlign: TextAlign.center,
              ),
              Text(
                "Reps",
                style: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            height: 40,
            color: colorGreyText,
            width: 1,
          ),
          Column(
            children: [
              Text(
                controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
                    .workoutExcerciseSetsDaily[subChildIndex].weight
                    .toString(),
                style: CustomTextStyles.medium(fontSize: 16.0, fontColor: themeBlack),
                textAlign: TextAlign.center,
              ),
              Text(
                "Kg",
                style: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            height: 40,
            color: colorGreyText,
            width: 1,
          ),
          Column(
            children: [
              Text(
                controller
                    .formatDuration(controller
                        .startWorkoutList[mainIndex]
                        .workoutExcerciseDaily[subIndex]
                        .workoutExcerciseSetsDaily[subChildIndex]
                        .totalSeconds)
                    .toString(),
                style: CustomTextStyles.medium(fontSize: 16.0, fontColor: themeBlack),
                textAlign: TextAlign.center,
              ),
              Text(
                "min : sec",
                style: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }

  exerciseView(subIndex, mainIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Exercise ${subIndex + 1}",
          style: CustomTextStyles.bold(fontSize: 16.0, fontColor: colorGreyText),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Stack(
              children: [
                mediaNetworkImage(
                    networkImage: controller
                        .startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex].imageUrl,
                    width: Get.width * 0.24,
                    height: Get.height * 0.12,
                    borderRadius: 20.0,
                    avatarRadius: 20.0),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.VIDEO_PLAYER, arguments: [
                        controller
                            .startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex].videoUrl,
                        controller
                            .startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex].title,
                        '',
                      ]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: SvgPicture.asset(
                        ImageResourceSvg.icPlayBlack,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex].title,
                    style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    controller
                        .startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex].description,
                    style: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      SvgPicture.asset(ImageResourceSvg.redClock),
                      const SizedBox(width: 10.0),
                      Text(
                        "Rest Time: ${CustomMethod.checkTime(controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex].restTimeMinutes)}",
                        style: CustomTextStyles.semiBold(fontSize: 11.0, fontColor: colorGreyText),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Current / Repeat Week',
              style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: colorGreyText),
            ),
            Text(
              'Stopwatch',
              style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: themeBlack),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, subChildIndex) {
            return AppStorage.isCompleted.value == 0
                ? setView(mainIndex, subIndex, subChildIndex)
                : disabledSetView(mainIndex, subIndex, subChildIndex);
          },
          separatorBuilder: (context, subChildIndex) {
            return Container(
              height: 25,
            );
          },
          itemCount: controller.startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex]
              .workoutExcerciseSetsDaily.length,
        ),
      ],
    );
  }

  exerciseListView(mainIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          controller.startWorkoutList[mainIndex].name,
          style: CustomTextStyles.bold(fontSize: 20.0, fontColor: themeBlack),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, subIndex) {
            return exerciseView(subIndex, mainIndex);
          },
          separatorBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              height: 2,
              color: colorGreyText,
            );
          },
          itemCount: controller.startWorkoutList[mainIndex].workoutExcerciseDaily.length,
        ),
      ],
    );
  }

  confirmationBottomSheet() {
    return Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Are you sure want \nto leave?",
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 22.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40.0,
                ),
                child: ButtonRegular(
                  verticalPadding: 14.0,
                  buttonText: "Confirm",
                  onPress: () {
                    if (Get.isBottomSheetOpen!) Get.back();
                    for (var i = 0; i < controller.startWorkoutList.length; i++) {
                      for (var j = 0;
                          j < controller.startWorkoutList[i].workoutExcerciseDaily.length;
                          j++) {
                        for (var k = 0;
                            k <
                                controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                    .workoutExcerciseSetsDaily.length;
                            k++) {
                          if (controller.startWorkoutList[i].workoutExcerciseDaily[j]
                              .workoutExcerciseSetsDaily[k].isStarted.value) {
                            print("this issss=========true");
                            controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                .workoutExcerciseSetsDaily[k].timer!
                                .cancel();
                            controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                .workoutExcerciseSetsDaily[k].isStarted.value = false;
                            controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                .workoutExcerciseSetsDaily[k].workingFlag.value = 'Pause';
                            controller.startWorkoutList[i].workoutExcerciseDaily[j]
                                    .workoutExcerciseSetsDaily[k].workoutTimeFormat.value =
                                controller.formatSecondsToMinuteSeconds(controller
                                    .startWorkoutList[i]
                                    .workoutExcerciseDaily[j]
                                    .workoutExcerciseSetsDaily[k]
                                    .localSecond
                                    .value);
                            controller.actionWorkout(i, j, k);
                          }
                        }
                      }
                    }

                    Get.back();
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: colorGreyText),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Cancel",
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }

  completedBottomSheet() {
    return Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SvgPicture.asset(ImageResourceSvg.workoutCompleted),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Great work! You have finished the workout for today!",
                style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Your Session time will now be added to My Stats",
                style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonRegular(
                verticalPadding: 14.0,
                buttonText: "Done",
                onPress: () {
                  if (Get.isBottomSheetOpen!) Get.back();

                  Get.back();
                },
              ),
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }
}
