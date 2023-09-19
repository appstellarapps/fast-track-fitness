import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/data/my_diary_model.dart';
import 'package:fasttrackfitness/app/modules/trainee/my_diary/controllers/my_diary_controller.dart';
import 'package:fasttrackfitness/app/modules/trainee/my_diary/views/my_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../routes/app_pages.dart';

mixin MyDiaryComponents {
  var controller = Get.put(MyDiaryController());

  tabs() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          tabViews(0, tabText: "Exercise"),
          tabViews(1, tabText: "Nutritional"),
          tabViews(2, tabText: "My Stats"),
        ],
      ),
    );
  }

  tabViews(index, {tabText}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (controller.selectTabIndex.value != index) {
            if (index != 2) {
              controller.selectTabIndex.value = index;
              if (AppStorage.isLogin()) {
                controller.selectTabIndex.value = index;

                apiLoader(
                    asyncCall: () =>
                        controller.getResourceCount(index == 0 ? "Exercise" : "Nutrition"));
              }
            } else {
              if (AppStorage.isLogin()) {
                controller.selectTabIndex.value = index;
                controller.isTabLoading.value = true;
                controller.isLoading.value = false;
                apiLoader(asyncCall: () => controller.getMyExerciseStats());
              } else {
                CustomMethod.guestDialog();
              }
            }
          }
        },
        child: Obx(
          () => Column(
            children: [
              Center(
                child: Text(
                  tabText,
                  style: CustomTextStyles.semiBold(
                    fontColor: controller.selectTabIndex.value == index ? themeBlack : themeBlack50,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: controller.selectTabIndex.value == index ? themeGreen : colorGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 2.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  tabItems() {
    if (controller.selectTabIndex.value == 0) {
      return exerciseView();
    } else if (controller.selectTabIndex.value == 1) {
      return nutritionalView();
    } else {
      controller.selectedStateIndex.value = 0;
      return myStatsView();
    }
  }

  exerciseView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.89),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, index) {
          return listItem(controller.diaryExercisesItems[index], index);
        },
        itemCount: controller.diaryExercisesItems.length);
  }

  nutritionalView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.89),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, index) {
          return listItem(controller.diaryNutritionalItems[index], index);
        },
        itemCount: controller.diaryNutritionalItems.length);
  }

  myStatsView() {
    return MyStats();
  }

  listItem(DiaryItem diaryItem, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: () {
        if (AppStorage.isLogin()) {
          var diaryController = Get.put(MyDiaryController());
          // Get.toNamed(Routes.myDiary, arguments: type);
          if (index == 0) {
            Get.toNamed(Routes.WORKOUT_PLANE, arguments: [controller.selectTabIndex.value, ""]);
          }

          if (index == 1) {
            Get.toNamed(Routes.WORKOUT_CALENDAR, arguments: [controller.selectTabIndex.value, ""]);
          }
          if (index == 2) {
            if (diaryController.selectTabIndex.value == 1) {
              createMealDialog();
            } else {
              createWorkoutDialog();
            }
          }
        } else {
          CustomMethod.guestDialog();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: colorGreyEditText,
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: SizedBox(
                    height: 70.0,
                    width: 70.0,
                    child: Image.asset(
                      diaryItem.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox(width: 10.0)),
                Padding(
                    padding: const EdgeInsets.only(right: 7.0, top: 10.0),
                    child: SvgPicture.asset(ImageResourceSvg.rightArrowIc, color: themeBlack))
              ],
            ),
            const SizedBox(height: 10.0),
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
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                diaryItem.description,
                style: CustomTextStyles.semiBold(
                  fontSize: 14.0,
                  fontColor: themeBlack50,
                ),
              ),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );
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
                              if (controller.selectTabIndex.value == 0) {
                                Get.toNamed(Routes.CREATE_WORKOUT, arguments: [
                                  controller.workOutSelected.value,
                                  '',
                                  '',
                                  '',
                                  false
                                ]);
                                // Get.toNamed(Routes.CREATE_MEAL);
                              } else {
                                Get.toNamed(Routes.CREATE_NUTRITION_WORKOUT, arguments: [
                                  controller.workOutSelected.value,
                                  '',
                                  '',
                                  '',
                                  false
                                ]);
                              }
                            }),
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
                            if (controller.selectTabIndex.value == 0) {
                              Get.toNamed(Routes.CREATE_WORKOUT,
                                  arguments: [controller.workOutSelected.value, '', '', '', false]);
                              // Get.toNamed(Routes.CREATE_MEAL);
                            } else {
                              Get.toNamed(Routes.CREATE_NUTRITION_WORKOUT,
                                  arguments: [controller.workOutSelected.value, '', '', '', false]);
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
