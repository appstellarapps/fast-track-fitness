import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/custom_local_meal_plan.dart';
import '../../../../data/custom_meal_model.dart';
import '../../../../data/get_exercise_details_model.dart';
import '../../../../routes/app_pages.dart';
import '../../resources/controllers/resources_controller.dart';
import '../controllers/exercise_details_controller.dart';

mixin ExerciseDetailsComponents {
  var controller = Get.put(ExerciseDetailsController());

  exerciseTopView() {
    return SizedBox(
      height: Get.height * 0.3,
      child: Stack(
        children: [
          exerciseNetworkImage(
              networkImage: controller.exerciseDetailsModel.result!.category.imageUrl,
              width: Get.width,
              height: Get.height * 0.3,
              borderRadius: 0.0,
              avatarRadius: 0.0),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                child: SvgPicture.asset(
                  ImageResourceSvg.back,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                controller.exerciseDetailsModel.result!.category.title,
                style: CustomTextStyles.semiBold(fontSize: 20.0, fontColor: themeWhite),
              ),
            ),
          )
        ],
      ),
    );
  }

  exerciseListView() {
    return Expanded(
      child: Obx(
        () => controller.getResourcesExerciseList.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.only(left: 20, right: 30.0, bottom: 100.0, top: 20.0),
                controller: controller.scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == controller.getResourcesExerciseList.length - 1 &&
                      controller.haseMore.value) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: themeGreen),
                      )),
                    );
                  }
                  return controller.tag == 0 ? exerciseView(index) : preMadeExerciseView(index);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  );
                },
                itemCount: controller.getResourcesExerciseList.length,
              )
            : noDataFound(),
      ),
    );
  }

  exerciseView(index) {
    return Row(
      children: [
        Stack(
          children: [
            mediaNetworkImage(
                networkImage: controller.getResourcesExerciseList[index].imageUrl,
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
                    controller.getResourcesExerciseList[index].videoUrl,
                    controller.getResourcesExerciseList[index].title,
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.getResourcesExerciseList[index].title.toString(),
                      style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                    ),
                  ),
                  !controller.isFromResource
                      ? InkWell(
                          onTap: () {
                            controller.getResourcesExerciseList[index].isSelected.value =
                                !controller.getResourcesExerciseList[index].isSelected.value;

                            if (controller.getResourcesExerciseList[index].isSelected.value) {
                              AppStorage.userSelectedExerciseList
                                  .add(controller.getResourcesExerciseList[index]);
                            } else {
                              AppStorage.userSelectedExerciseList.removeWhere((element) =>
                                  element.id == controller.getResourcesExerciseList[index].id);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => Text(
                                controller.getResourcesExerciseList[index].isSelected.value
                                    ? "Remove"
                                    : "Add",
                                style: CustomTextStyles.semiBold(
                                    fontSize: 12.0,
                                    fontColor:
                                        controller.getResourcesExerciseList[index].isSelected.value
                                            ? errorColor
                                            : themeGreen))),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                controller.getResourcesExerciseList[index].description,
                style: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  SvgPicture.asset(ImageResourceSvg.redClock),
                  const SizedBox(width: 10.0),
                  Text(
                    "Rest Time: ${CustomMethod.checkTime(controller.getResourcesExerciseList[index].duration)}",
                    style: CustomTextStyles.semiBold(fontSize: 11.0, fontColor: colorGreyText),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  setsView(ResourceExerciseSet resourceExerciseSet, i, index) {
    resourceExerciseSet.repsControllers.text = resourceExerciseSet.reps.toString();
    resourceExerciseSet.weightControllers.text = resourceExerciseSet.weight.toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Set ${i + 1}     :",
          style: CustomTextStyles.normal(fontSize: 15.0, fontColor: themeBlack),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    style: CustomTextStyles.normal(fontSize: 13.0, fontColor: colorGreyText),
                    readOnly: true,
                    controller: resourceExerciseSet.repsControllers,
                    maxLength: 2,
                    cursorColor: themeGrey,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    // focusNode: focusNode,
                    decoration: InputDecoration(
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
                  color: themeWhite,
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
        const SizedBox(width: 20),
        Expanded(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    readOnly: true,
                    style: CustomTextStyles.normal(fontSize: 13.0, fontColor: colorGreyText),

                    controller: resourceExerciseSet.weightControllers,
                    maxLength: 2,
                    cursorColor: themeGrey,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    // focusNode: focusNode,
                    decoration: InputDecoration(
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
                  color: themeWhite,
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
      ],
    );
  }

  mainExerciseView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        exerciseTopView(),
        controller.exerciseDetailsModel.result!.category.description.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: ReadMoreText(
                  controller.exerciseDetailsModel.result!.category.description.toString(),
                  trimLines: 4,
                  style: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colorGreyText),
                ),
              )
            : const SizedBox.shrink(),
        controller.getResourcesExerciseList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: [
                    Text(
                      "${controller.getResourcesExerciseList.length} Exercises",
                      style: CustomTextStyles.semiBold(fontSize: 18.0, fontColor: themeBlack),
                    ),
                    controller.isFromResource &&
                            AppStorage.getUserType() != EndPoints.USER_TYPE_TRAINER &&
                            AppStorage.isLogin()
                        ? InkWell(
                            onTap: () {
                              var resCtr = Get.put(ResourcesController());
                              resCtr.resourceId =
                                  controller.exerciseDetailsModel.result!.category.id;
                              resCtr.getWorkOut("Exercise");
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(8.0),
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: themeGreen,
                              ),
                              child: SvgPicture.asset(ImageResourceSvg.plus),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              )
            : const SizedBox.shrink(),
        exerciseListView()
      ],
    );
  }

  preMadeExerciseView(index) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              children: [
                mediaNetworkImage(
                    networkImage: controller.getResourcesExerciseList[index].imageUrl,
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
                        controller.getResourcesExerciseList[index].videoUrl,
                        controller.getResourcesExerciseList[index].title,
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.getResourcesExerciseList[index].title.toString(),
                          style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                        ),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            controller.getResourcesExerciseList[index].isSelected.value =
                                !controller.getResourcesExerciseList[index].isSelected.value;

                            // if (controller.getResourcesExerciseList[index].isSelected.value) {
                            //   SessionImpl.userSelectedExerciseList
                            //       .add(controller.getResourcesExerciseList[index]);
                            // } else {
                            //   SessionImpl.userSelectedExerciseList.removeWhere((element) =>
                            //       element.id == controller.getResourcesExerciseList[index].id);
                            // }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                controller.getResourcesExerciseList[index].isSelected.value
                                    ? "Hide Details"
                                    : "Show Details",
                                style: CustomTextStyles.semiBold(
                                    fontSize: 12.0,
                                    fontColor:
                                        controller.getResourcesExerciseList[index].isSelected.value
                                            ? themeGreen
                                            : const Color(0xff0062D4))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    controller.getResourcesExerciseList[index].description,
                    style: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      SvgPicture.asset(ImageResourceSvg.redClock),
                      const SizedBox(width: 10.0),
                      Text(
                        "Rest Time: ${CustomMethod.checkTime(controller.getResourcesExerciseList[index].duration)}",
                        style: CustomTextStyles.semiBold(fontSize: 11.0, fontColor: colorGreyText),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Obx(() => controller.getResourcesExerciseList[index].isSelected.value
            ? ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 40),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return setsView(
                      controller.getResourcesExerciseList[index].resourceExerciseSets[i], i, index);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  );
                },
                itemCount: controller.getResourcesExerciseList[index].resourceExerciseSets.length,
              )
            : const SizedBox.shrink()),
      ],
    );
  }

  customMealView() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.4,
          child: Stack(
            children: [
              exerciseNetworkImage(
                  networkImage: controller.customMeal.image,
                  width: Get.width,
                  height: Get.height * 0.4,
                  borderRadius: 0.0,
                  avatarRadius: 0.0),
              InkWell(
                onTap: () => Get.back(),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                    child: SvgPicture.asset(
                      ImageResourceSvg.back,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    controller.customMeal.foodName.toString(),
                    style: CustomTextStyles.semiBold(fontSize: 20.0, fontColor: themeWhite),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: dietView(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: ButtonRegular(
                  verticalPadding: 14.0,
                  buttonText: "Go Back",
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
                  buttonText: "Add",
                  onPress: () {
                    List<CustomMeals> tempList = [];

                    if (!AppStorage.mainCustomMealList.asMap().containsKey(controller.mealIndex)) {
                      AppStorage.mainCustomMealList.insert(
                          controller.mealIndex,
                          (CustomLocalMealPlan(
                              mealName: "Meal ${controller.mealIndex + 1}",
                              subMealList: tempList)));
                    } else {
                      if (AppStorage.mainCustomMealList.isNotEmpty) {
                        for (var data
                            in AppStorage.mainCustomMealList[controller.mealIndex].subMealList!) {
                          tempList.add(data);
                        }
                      }
                      AppStorage.mainCustomMealList[controller.mealIndex].subMealList!
                          .add(controller.customMeal);
                      AppStorage.mainCustomMealList.refresh();
                    }
                    tempList.add(controller.customMeal);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  dietView() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.customMeal.foodName.toString(),
                style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
              ),
              Text(
                "Per ${controller.customMeal.weight} g",
                style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
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
                              "${controller.customMeal.protein} g",
                              style: CustomTextStyles.normal(fontSize: 13.0, fontColor: themeBlack),
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
                          child: Text('Protein',
                              style: CustomTextStyles.normal(
                                  fontSize: 10.0, fontColor: colorGreyText)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 40,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: colorGreyText)),
                            child: Text(
                              "${controller.customMeal.fat} g",
                              style: CustomTextStyles.normal(fontSize: 13.0, fontColor: themeBlack),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                          color: themeWhite,
                          child: Text('Fat',
                              style: CustomTextStyles.normal(
                                  fontSize: 10.0, fontColor: colorGreyText)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 40,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: colorGreyText)),
                            child: Text(
                              "${controller.customMeal.carbs} g",
                              style: CustomTextStyles.normal(fontSize: 13.0, fontColor: themeBlack),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                          color: themeWhite,
                          child: Text('Carbs',
                              style: CustomTextStyles.normal(
                                  fontSize: 10.0, fontColor: colorGreyText)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 40,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: colorGreyText)),
                            child: Text(
                              "${controller.customMeal.calories} g",
                              style: CustomTextStyles.normal(fontSize: 13.0, fontColor: themeBlack),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                          margin: const EdgeInsets.only(left: 10),
                          color: themeWhite,
                          child: Text('Calories',
                              style: CustomTextStyles.normal(
                                  fontSize: 10.0, fontColor: colorGreyText)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  preMadeMealView() {
    return Column(
      children: [
        Stack(
          children: [
            mediaNetworkImage(
                networkImage: controller.preMadeMealDetails.result!.imageUrl.toString(),
                width: Get.width,
                height: Get.height * 0.3,
                borderRadius: 0.0,
                avatarRadius: 0.0),
            InkWell(
              onTap: () => Get.back(),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                  child: SvgPicture.asset(
                    ImageResourceSvg.back,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  controller.preMadeMealDetails.result!.title.toString(),
                  style: CustomTextStyles.semiBold(fontSize: 20.0, fontColor: themeWhite),
                ),
              ),
            )
          ],
        ),
        controller.preMadeMealDetails.result!.description.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: ReadMoreText(
                  controller.preMadeMealDetails.result!.description.toString(),
                  trimLines: 4,
                  style: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colorGreyText),
                ),
              )
            : const SizedBox.shrink(),
        controller.isFromResource &&
                AppStorage.getUserType() != EndPoints.USER_TYPE_TRAINER &&
                AppStorage.isLogin()
            ? Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Add to Nutritional Diary",
                      style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack),
                    ),
                    InkWell(
                      onTap: () {
                        var resCtr = Get.put(ResourcesController());
                        resCtr.resourceId = controller.preMadeMealDetails.result!.id;
                        resCtr.getWorkOut("Nutritional");
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeGreen,
                        ),
                        child: SvgPicture.asset(ImageResourceSvg.plus),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.only(top: 10, bottom: 100),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return preMadeDietView(i);
              },
              separatorBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                );
              },
              itemCount: controller.getPreMadeMealList.length),
        )
      ],
    );
  }

  preMadeDietView(index) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
      decoration:
          BoxDecoration(color: colorGreyEditText, borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.getPreMadeMealList[index].title.toString(),
            style: CustomTextStyles.bold(fontSize: 16.0, fontColor: themeBlack),
          ),
          const SizedBox(height: 30),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return preDietView(index, i);
            },
            separatorBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              );
            },
            itemCount: controller.getPreMadeMealList[index].resourcePreMadeMeals!.length,
          )
        ],
      ),
    );
  }

  preDietView(mainIndex, subIndex) {
    return Column(
      children: [
        Row(
          children: [
            mediaNetworkImage(
                networkImage:
                    controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals![subIndex].image,
                width: Get.width * 0.2,
                height: Get.height * 0.10,
                borderRadius: 20.0,
                avatarRadius: 20.0),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals![subIndex].foodName
                    .toString(),
                style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
              ),
            ),
            InkWell(
              onTap: () {
                controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals![subIndex].isShow
                        .value =
                    !controller
                        .getPreMadeMealList[mainIndex].resourcePreMadeMeals![subIndex].isShow.value;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => SvgPicture.asset(controller
                        .getPreMadeMealList[mainIndex].resourcePreMadeMeals![subIndex].isShow.value
                    ? ImageResourceSvg.upArrow
                    : ImageResourceSvg.downArrow)),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() =>
            controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals[subIndex].isShow.value
                ? Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals![subIndex]
                                .foodName,
                            style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                          ),
                          Text(
                            "Per ${controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals![subIndex].weight} g",
                            style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
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
                                          "${controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals[subIndex].protein} g",
                                          style: CustomTextStyles.normal(
                                              fontSize: 13.0, fontColor: themeBlack),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                                      margin: const EdgeInsets.only(right: 10),
                                      color: colorGreyEditText,
                                      child: Text('Protein',
                                          style: CustomTextStyles.normal(
                                              fontSize: 10.0, fontColor: colorGreyText)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: 40,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: colorGreyText)),
                                        child: Text(
                                          "${controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals[subIndex].fat} g",
                                          style: CustomTextStyles.normal(
                                              fontSize: 13.0, fontColor: themeBlack),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                                      color: colorGreyEditText,
                                      child: Text('Fat',
                                          style: CustomTextStyles.normal(
                                              fontSize: 10.0, fontColor: colorGreyText)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: 40,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: colorGreyText)),
                                        child: Text(
                                          "${controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals[subIndex].carbs} g",
                                          style: CustomTextStyles.normal(
                                              fontSize: 13.0, fontColor: themeBlack),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                                      color: colorGreyEditText,
                                      child: Text('Carbs',
                                          style: CustomTextStyles.normal(
                                              fontSize: 10.0, fontColor: colorGreyText)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: 40,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: colorGreyText)),
                                        child: Text(
                                          "${controller.getPreMadeMealList[mainIndex].resourcePreMadeMeals[subIndex].calories} g",
                                          style: CustomTextStyles.normal(
                                              fontSize: 13.0, fontColor: themeBlack),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                                      margin: const EdgeInsets.only(left: 10),
                                      color: colorGreyEditText,
                                      child: Text('Calories',
                                          style: CustomTextStyles.normal(
                                              fontSize: 10.0, fontColor: colorGreyText)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink())
      ],
    );
  }
}
