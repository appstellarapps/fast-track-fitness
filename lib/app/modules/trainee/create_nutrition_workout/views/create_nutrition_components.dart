import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/get_premade_meals_details.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/create_nutrition_workout_controller.dart';

mixin CreateNutritionComponents {
  var controller = Get.put(CreateNutritionWorkoutController());

  checkView() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.NUTRITION_LIBRARY,
                    arguments: [controller.tag, AppStorage.mainCustomMealList.length]);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageResourceSvg.addRound),
                  const SizedBox(width: 10),
                  Text(
                    "Add new meal",
                    style: CustomTextStyles.bold(fontSize: 13.0, fontColor: themeBlack),
                  )
                ],
              ),
            ),
          ),
        ),
        AppStorage.mainCustomMealList.isNotEmpty || AppStorage.preMadeMealLIst.isNotEmpty
            ? Align(
                alignment: Alignment.bottomCenter,
                child: ButtonRegular(
                  buttonText: "Save",
                  onPress: () {
                    Helper().hideKeyBoard();

                    controller.validateLogin();
                  },
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  customMealListView() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return customMealView(index);
      },
      separatorBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        );
      },
      itemCount: AppStorage.mainCustomMealList.length,
    );
  }

  customMealView(i) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
      decoration:
          BoxDecoration(color: colorGreyEditText, borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStorage.mainCustomMealList[i].mealName.toString(),
                  style: CustomTextStyles.bold(fontSize: 16.0, fontColor: themeBlack),
                ),
              ),
              controller.isViewOnly
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        Get.toNamed(Routes.NUTRITION_LIBRARY, arguments: [controller.tag, i]);
                      },
                      child: Text(
                        "Add",
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeGreen),
                      ),
                    ),
              const SizedBox(width: 10),
              controller.isViewOnly
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        AppStorage.mainCustomMealList.removeAt(i);
                      },
                      child: Text(
                        "Remove",
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: errorColor),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 10.0),
          Obx(() => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return dietView(index, i);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  );
                },
                itemCount: AppStorage.mainCustomMealList[i].subMealList!.length,
              ))
        ],
      ),
    );
  }

  dietView(subIndex, mainIndex) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].isShow.value =
                !AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].isShow.value;
          },
          child: Row(
            children: [
              circleProfileNetworkImage(
                  networkImage:
                      AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].image,
                  width: Get.width * 0.2,
                  height: Get.height * 0.10,
                  borderRadius: 20.0,
                  avatarRadius: 20.0),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].foodName
                      .toString(),
                  style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                ),
              ),
              controller.isViewOnly
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        AppStorage.mainCustomMealList[mainIndex].subMealList!.removeAt(subIndex);
                        AppStorage.mainCustomMealList.refresh();

                        if (AppStorage.mainCustomMealList[mainIndex].subMealList!.isEmpty) {
                          AppStorage.mainCustomMealList.removeAt(mainIndex);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(ImageResourceSvg.delete),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => SvgPicture.asset(
                    AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].isShow.value
                        ? ImageResourceSvg.upArrow
                        : ImageResourceSvg.downArrow)),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].isShow.value
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].foodName!,
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                      ),
                      Text(
                        "Per ${AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].weight} g",
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
                                      "${AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].protein} g",
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
                                      "${AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].fat} g",
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
                                      "${AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].carbs} g",
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
                                      "${AppStorage.mainCustomMealList[mainIndex].subMealList![subIndex].calories} g",
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

  preMadeMealListView() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return preMadeMealView(index);
      },
      separatorBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        );
      },
      itemCount: AppStorage.preMadeMealLIst.length,
    );
  }

  preMadeMealView(i) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
      decoration:
          BoxDecoration(color: colorGreyEditText, borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Meal ${i + 1}",
                  style: CustomTextStyles.bold(fontSize: 16.0, fontColor: themeBlack),
                ),
              ),
              controller.isViewOnly
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        AppStorage.preMadeMealLIst.removeAt(i);
                      },
                      child: Text(
                        "Remove",
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: errorColor),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 10.0),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return mealView(index, i);
            },
            separatorBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              );
            },
            itemCount: AppStorage.preMadeMealLIst[i].getResourcesNutrition!.length,
          )
        ],
      ),
    );
  }

  mealView(subIndex, mainIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return preDietView(mainIndex, subIndex, index);
          },
          separatorBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            );
          },
          itemCount: AppStorage.preMadeMealLIst[mainIndex].getResourcesNutrition[subIndex]
              .resourcePreMadeMeals.length,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  preDietView(mainIndex, subIndex, subChildIndex) {
    List<ResourcePreMadeMeal> resourcePreMadeMeals =
        AppStorage.preMadeMealLIst[mainIndex].getResourcesNutrition[subIndex].resourcePreMadeMeals;
    return Column(
      children: [
        InkWell(
          onTap: () {
            resourcePreMadeMeals[subChildIndex].isShow.value =
                !resourcePreMadeMeals[subChildIndex].isShow.value;
          },
          child: Row(
            children: [
              mediaNetworkImage(
                  networkImage: resourcePreMadeMeals[subChildIndex].image,
                  width: Get.width * 0.2,
                  height: Get.height * 0.10,
                  borderRadius: 20.0,
                  avatarRadius: 20.0),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  resourcePreMadeMeals[subChildIndex].foodName.toString(),
                  style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => SvgPicture.asset(resourcePreMadeMeals[subChildIndex].isShow.value
                    ? ImageResourceSvg.upArrow
                    : ImageResourceSvg.downArrow)),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => resourcePreMadeMeals[subChildIndex].isShow.value
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStorage.preMadeMealLIst[mainIndex].getResourcesNutrition![subIndex]
                            .resourcePreMadeMeals[subChildIndex].foodName!,
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                      ),
                      Text(
                        "Per ${AppStorage.preMadeMealLIst[mainIndex].getResourcesNutrition![subIndex].resourcePreMadeMeals[subChildIndex].weight} g",
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                      ),
                    ],
                  ),
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
                                      "${resourcePreMadeMeals[subChildIndex].protein} g",
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
                                      "${resourcePreMadeMeals[subChildIndex].fat} g",
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
                                      "${resourcePreMadeMeals[subChildIndex].carbs} g",
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
                                      "${resourcePreMadeMeals[subChildIndex].calories} g",
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
