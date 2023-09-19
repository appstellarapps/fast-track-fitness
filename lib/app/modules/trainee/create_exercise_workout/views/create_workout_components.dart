import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/get_exercise_details_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/create_workout_controller.dart';

mixin CreateWorkoutComponents {
  var controller = Get.put(CreateWorkoutController());

  exerciseListView() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return controller.tag == 0 ? exerciseView(index) : preMadeExerciseView(index);
      },
      separatorBuilder: (context, index) {
        if (controller.tag == 0) {
          return Container(
            margin: const EdgeInsets.only(top: 0.0, bottom: 15.0),
            height: 1,
            color: colorGreyText,
          );
        } else {
          if (index < AppStorage.userSelectedExerciseList.length - 1 &&
              AppStorage.userSelectedExerciseList[index].categoryId !=
                  AppStorage.userSelectedExerciseList[index + 1].categoryId) {
            return Container(
              margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              height: 1,
              color: colorGreyText,
            );
          }
        }
        return const SizedBox.shrink();
      },
      itemCount: AppStorage.userSelectedExerciseList.length,
    );
  }

  checkView() {
    return Stack(
      children: [
        controller.tag == 1 && AppStorage.userSelectedExerciseList.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.EXERCISE_LIBRARY,
                          arguments: [controller.tag, AppStorage.mainCustomMealList.length]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImageResourceSvg.addRound),
                        const SizedBox(width: 10),
                        Text(
                          'Add Exercise',
                          style: CustomTextStyles.bold(fontSize: 13.0, fontColor: themeBlack),
                        )
                      ],
                    ),
                  ),
                ),
              ),
        AppStorage.userSelectedExerciseList.isNotEmpty || controller.tag == 1
            ? Align(
                alignment: Alignment.bottomCenter,
                child: ButtonRegular(
                  buttonText: controller.tag == 1 && AppStorage.userSelectedExerciseList.isEmpty
                      ? "Add Workout From Library"
                      : "Save",
                  onPress: () {
                    Helper().hideKeyBoard();
                    if (controller.tag == 1 && AppStorage.userSelectedExerciseList.isEmpty) {
                      Get.toNamed(Routes.EXERCISE_LIBRARY, arguments: [controller.tag, 0]);
                    } else {
                      controller.validateLogin();
                    }
                  },
                ),
              )
            : AppStorage.mainCustomMealList.isNotEmpty || AppStorage.preMadeMealLIst.isNotEmpty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonRegular(
                      buttonText: "Save",
                      onPress: () {
                        Helper().hideKeyBoard();
                        // if (controller.tag == 1 &&
                        //     AppStorage.userSelectedExerciseList.isEmpty) {
                        //   Get.toNamed(Routes.EXERCISE_LIBRARY, arguments: [
                        //     controller.tag,
                        //     controller.isExercise,
                        //     0
                        //   ]);
                        // }
                        // else {
                        controller.validateLogin();
                        // }
                      },
                    ),
                  )
                : const SizedBox.shrink()
      ],
    );
  }

  exerciseView(index) {
    return Column(
      children: [
        Row(
          children: [
            circleProfileNetworkImage(
                networkImage: AppStorage.userSelectedExerciseList[index].imageUrl,
                width: Get.width * 0.2,
                height: Get.height * 0.10,
                borderRadius: 20.0,
                avatarRadius: 20.0),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStorage.userSelectedExerciseList[index].title.toString(),
                          style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                        ),
                      ),
                      controller.isOnlyView
                          ? const SizedBox.shrink()
                          : Obx(
                              () => controller.tag == 0
                                  ? InkWell(
                                      onTap: () {
                                        AppStorage
                                                .userSelectedExerciseList[index].isSelected.value =
                                            !AppStorage
                                                .userSelectedExerciseList[index].isSelected.value;

                                        if (AppStorage
                                            .userSelectedExerciseList[index].isSelected.value) {
                                          AppStorage.userSelectedExerciseList
                                              .add(AppStorage.userSelectedExerciseList[index]);
                                        } else {
                                          AppStorage.userSelectedExerciseList.removeWhere(
                                              (element) =>
                                                  element.id ==
                                                  AppStorage.userSelectedExerciseList[index].id);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            AppStorage.userSelectedExerciseList[index].isSelected
                                                    .value
                                                ? "Remove"
                                                : "Add",
                                            style: CustomTextStyles.semiBold(
                                                fontSize: 12.0,
                                                fontColor: AppStorage
                                                        .userSelectedExerciseList[index]
                                                        .isSelected
                                                        .value
                                                    ? errorColor
                                                    : themeGreen)),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        AppStorage
                                                .userSelectedExerciseList[index].isSelected.value =
                                            !AppStorage
                                                .userSelectedExerciseList[index].isSelected.value;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            AppStorage.userSelectedExerciseList[index].isSelected
                                                    .value
                                                ? "Hide Details"
                                                : "Show Details",
                                            style: CustomTextStyles.semiBold(
                                                fontSize: 12.0,
                                                fontColor: AppStorage
                                                        .userSelectedExerciseList[index]
                                                        .isSelected
                                                        .value
                                                    ? themeGreen
                                                    : const Color(0xff0062D4))),
                                      ),
                                    ),
                            )
                    ],
                  ),
                  Text(
                    AppStorage.userSelectedExerciseList[index].description,
                    style: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      SvgPicture.asset(ImageResourceSvg.redClock),
                      const SizedBox(width: 10.0),
                      Text(
                        "Rest Time: ${CustomMethod.checkTime(AppStorage.userSelectedExerciseList[index].restTimeMinutes)}",
                        style: CustomTextStyles.semiBold(fontSize: 11.0, fontColor: colorGreyText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Obx(
          () => ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
                top: AppStorage.userSelectedExerciseList[index].isSelected.value ? 40.0 : 0.0,
                bottom: AppStorage.userSelectedExerciseList[index].isSelected.value ? 20.0 : 0.0),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return AppStorage.userSelectedExerciseList[index].isSelected.value
                  ? setsView(
                      AppStorage.userSelectedExerciseList[index].resourceExerciseSets[i], i, index)
                  : const SizedBox.shrink();
            },
            separatorBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              );
            },
            itemCount: AppStorage.userSelectedExerciseList[index].resourceExerciseSets.length,
          ),
        )
        // const SizedBox(height: 100.0),
      ],
    );
  }

  preMadeExerciseView(index) {
    bool isIdChanged = index < AppStorage.userSelectedExerciseList.length - 1 &&
        AppStorage.userSelectedExerciseList[index].categoryId !=
            AppStorage.userSelectedExerciseList[index + 1].categoryId;
    bool isLastId = index == AppStorage.userSelectedExerciseList.length - 1 ||
        AppStorage.userSelectedExerciseList[index].categoryId !=
            AppStorage.userSelectedExerciseList[index].categoryId;

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
      decoration: BoxDecoration(color: colorGreyEditText, borderRadius: BorderRadius.circular(0.0)),
      child: Column(
        children: [
          Row(
            children: [
              circleProfileNetworkImage(
                  networkImage: AppStorage.userSelectedExerciseList[index].imageUrl,
                  width: Get.width * 0.2,
                  height: Get.height * 0.10,
                  borderRadius: 20.0,
                  avatarRadius: 20.0),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppStorage.userSelectedExerciseList[index].title.toString(),
                            style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                          ),
                        ),
                        Obx(
                          () => controller.tag == 0
                              ? InkWell(
                                  onTap: () {
                                    AppStorage.userSelectedExerciseList[index].isSelected.value =
                                        !AppStorage
                                            .userSelectedExerciseList[index].isSelected.value;

                                    if (AppStorage
                                        .userSelectedExerciseList[index].isSelected.value) {
                                      AppStorage.userSelectedExerciseList
                                          .add(AppStorage.userSelectedExerciseList[index]);
                                    } else {
                                      AppStorage.userSelectedExerciseList.removeWhere((element) =>
                                          element.id ==
                                          AppStorage.userSelectedExerciseList[index].id);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        AppStorage.userSelectedExerciseList[index].isSelected.value
                                            ? "Remove"
                                            : "Add",
                                        style: CustomTextStyles.semiBold(
                                            fontSize: 12.0,
                                            fontColor: AppStorage.userSelectedExerciseList[index]
                                                    .isSelected.value
                                                ? errorColor
                                                : themeGreen)),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    AppStorage.userSelectedExerciseList[index].isSelected.value =
                                        !AppStorage
                                            .userSelectedExerciseList[index].isSelected.value;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        AppStorage.userSelectedExerciseList[index].isSelected.value
                                            ? "Hide Details"
                                            : "Show Details",
                                        style: CustomTextStyles.semiBold(
                                            fontSize: 12.0,
                                            fontColor: AppStorage.userSelectedExerciseList[index]
                                                    .isSelected.value
                                                ? themeGreen
                                                : const Color(0xff0062D4))),
                                  ),
                                ),
                        )
                      ],
                    ),
                    Text(
                      AppStorage.userSelectedExerciseList[index].description,
                      style: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        SvgPicture.asset(ImageResourceSvg.redClock),
                        const SizedBox(width: 10.0),
                        Text(
                          "Rest Time: ${CustomMethod.checkTime(AppStorage.userSelectedExerciseList[index].restTimeMinutes)}",
                          style:
                              CustomTextStyles.semiBold(fontSize: 11.0, fontColor: colorGreyText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                  top: AppStorage.userSelectedExerciseList[index].isSelected.value ? 40.0 : 0.0,
                  bottom: AppStorage.userSelectedExerciseList[index].isSelected.value ? 20.0 : 0.0),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return AppStorage.userSelectedExerciseList[index].isSelected.value
                    ? setsView(AppStorage.userSelectedExerciseList[index].resourceExerciseSets[i],
                        i, index)
                    : const SizedBox.shrink();
              },
              separatorBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                );
              },
              itemCount: AppStorage.userSelectedExerciseList[index].resourceExerciseSets.length,
            ),
          ),
          if (isIdChanged || isLastId) ...[
            controller.isOnlyView
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: () {
                      AppStorage.userSelectedExerciseList.removeWhere((item) =>
                          item.categoryId == AppStorage.userSelectedExerciseList[index].categoryId);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Remove",
                            style:
                                CustomTextStyles.semiBold(fontSize: 12.0, fontColor: errorColor)),
                      ),
                    ),
                  ),
          ],

          // const SizedBox(height: 100.0),
        ],
      ),
    );
  }

  setsView(ResourceExerciseSet resourceExerciseSet, i, index) {
    if (resourceExerciseSet.repsControllers.text.isEmpty) {
      if (resourceExerciseSet.reps.toString() != '0') {
        resourceExerciseSet.repsControllers.text = resourceExerciseSet.reps.toString();
      }
    }
    if (resourceExerciseSet.weightControllers.text.isEmpty) {
      if (resourceExerciseSet.weight.toString() != '0') {
        resourceExerciseSet.weightControllers.text = resourceExerciseSet.weight.toString();
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Set ${i + 1} : ",
          style: CustomTextStyles.normal(fontSize: 15.0, fontColor: themeBlack),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: SizedBox(
            height: 48,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      readOnly: controller.tag == 1 || controller.isOnlyView ? true : false,
                      style: CustomTextStyles.normal(
                          fontSize: 15.0,
                          fontColor: controller.tag == 0 ? themeBlack : colorGreyText),
                      controller: resourceExerciseSet.repsControllers,
                      maxLength: 3,
                      cursorColor: themeGrey,
                      textAlign: TextAlign.center,
                      // focusNode: focusNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 5),
                        counterText: "",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGreyText, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: inputGrey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 0.0),
                      child: Text('Reps',
                          style: CustomTextStyles.normal(fontSize: 10.0, fontColor: colorGreyText)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            height: 48,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      readOnly: controller.tag == 1 || controller.isOnlyView ? true : false,
                      style: CustomTextStyles.normal(
                          fontSize: 15.0,
                          fontColor: controller.tag == 0 ? themeBlack : colorGreyText),
                      controller: resourceExerciseSet.weightControllers,
                      maxLength: 5,
                      cursorColor: themeGrey,
                      textAlign: TextAlign.center,
                      // focusNode: focusNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 5),
                        counterText: "",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGreyText, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: inputGrey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 0.0),
                      child: Text('Weight',
                          style: CustomTextStyles.normal(fontSize: 10.0, fontColor: colorGreyText)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        controller.tag == 0 && !controller.isOnlyView
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    if (i == 0) {
                      AppStorage.userSelectedExerciseList[index].resourceExerciseSets.add(
                          ResourceExerciseSet(
                              id: '', resourceLibraryId: '', sets: 0, reps: 0, weight: 0));
                      AppStorage.userSelectedExerciseList.refresh();
                    } else {
                      AppStorage.userSelectedExerciseList[index].resourceExerciseSets.removeAt(i);
                      AppStorage.userSelectedExerciseList.refresh();
                    }
                  },
                  child: SvgPicture.asset(
                    i == 0 ? ImageResourceSvg.plusRoundIcon : ImageResourceSvg.removeRoundRed,
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
