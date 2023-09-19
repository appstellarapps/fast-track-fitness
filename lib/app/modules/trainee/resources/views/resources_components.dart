import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/custom_meal_model.dart';
import '../../../../data/exercise_library_model.dart';
import '../../../../data/premade_meal_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/resources_controller.dart';

mixin ResourcesComponents {
  var controller = Get.put(ResourcesController());
  var searchCommonBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xffE6E6E6),
      ));

  tabs() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          tabViews(0, tabText: "Exercise"),
          tabViews(1, tabText: "Nutritional"),
        ],
      ),
    );
  }

  tabViews(index, {tabText}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (controller.selectTabIndex.value != index) {
            controller.selectTabIndex.value = index;
            controller.page = 1;
            controller.exerciseList.clear();
            controller.preMadeMealList.clear();
            controller.isLoading.value = true;
            controller.searchCtr.clear();

            if (index == 0) {
              apiLoader(asyncCall: () => controller.getExerciseLibrary());
            } else {
              apiLoader(asyncCall: () => controller.getMealLibrary());
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

  mainExerciseListView() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 100.0),
        controller: controller.scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == controller.exerciseList.length - 1 && controller.haseMore.value) {
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
          return mainExerciseView(index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox.shrink();
        },
        itemCount: controller.exerciseList.length,
      ),
    );
  }

  mainExerciseView(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.exerciseList[index].title,
                  style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: colorGreyText),
                ),
              ),
              controller.exerciseList[index].descendantsCount > 5
                  ? InkWell(
                      onTap: () {
                        if (AppStorage.userData.result!.user.isSubscribed == 1 ||
                            AppStorage.userData.result!.user.isResourceSubscribed == 1) {
                          Get.toNamed(Routes.ALL_EXERCISE,
                              arguments: [controller.exerciseList[index].id, 0, 0, true]);
                        }
                      },
                      child: Text(
                        "View All",
                        style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: themeBlack),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        subExerciseListView(index, controller.exerciseList[index])
      ],
    );
  }

  subExerciseListView(mainIndex, Exercise subExercise) {
    return SizedBox(
      height: Get.height * 0.30,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return subExerciseView(subExercise, mainIndex, index);
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
          );
        },
        itemCount: subExercise.descendants.length,
      ),
    );
  }

  subExerciseView(Exercise subExercise, mainIndex, index) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (AppStorage.userData.result!.user.isSubscribed == 1 ||
                AppStorage.userData.result!.user.isResourceSubscribed == 1) {
              Get.toNamed(Routes.EXERCISE_DETAILS,
                  arguments: [subExercise.descendants[index].id, 0, 0, true]);
            }
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                exerciseNetworkImage(
                    networkImage: subExercise.descendants[index].imageUrl,
                    width: Get.width * 0.6,
                    height: Get.height * 0.20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subExercise.descendants[index].title,
                        style: CustomTextStyles.bold(fontSize: 17.0, fontColor: themeBlack),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            ImageResourceSvg.redClock,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            " ${CustomMethod.checkTime(subExercise.descendants[index].totalResourcesDuration)}",
                            style:
                                CustomTextStyles.semiBold(fontSize: 12.0, fontColor: colorGreyText),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            " | ${subExercise.descendants[index].exerciseCount} Exercises",
                            style: CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        AppStorage.isLogin()
            ? Positioned(
                right: 0.0,
                child: InkWell(
                  onTap: () {
                    if (AppStorage.userData.result!.user.isSubscribed == 1 ||
                        AppStorage.userData.result!.user.isResourceSubscribed == 1) {
                      controller.getWorkOut("Exercise");
                      controller.resourceId =
                          controller.exerciseList[mainIndex].descendants[index].id;
                    }
                  },
                  child: Obx(
                    () => Container(
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.all(12.0),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            controller.exerciseList[mainIndex].descendants[index].isSelected.value
                                ? errorColor
                                : themeGreen,
                      ),
                      child: controller.exerciseList[mainIndex].descendants[index].isSelected.value
                          ? SvgPicture.asset(
                              ImageResourceSvg.delete,
                              color: themeWhite,
                            )
                          : SvgPicture.asset(ImageResourceSvg.plus),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  preMadeMealListView() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 100.0),
        controller: controller.scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == controller.preMadeMealList.length - 1 && controller.haseMore.value) {
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

          return preMadeMainMealView(index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox.shrink();
        },
        itemCount: controller.preMadeMealList.length,
      ),
    );
  }

  preMadeMainMealView(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.preMadeMealList[index].title,
                  style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: colorGreyText),
                ),
              ),
              controller.preMadeMealList[index].descendantsCount > 5
                  ? InkWell(
                      onTap: () {
                        Get.toNamed(Routes.ALL_EXERCISE,
                            arguments: [controller.preMadeMealList[index].id, 1, 1, true]);
                      },
                      child: Text(
                        "View All",
                        style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: themeBlack),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        preMadeSubMealListView(controller.preMadeMealList[index], index)
      ],
    );
  }

  subMealListView(CustomMeal customMeal) {
    return SizedBox(
      height: Get.height * 0.28,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return subMealView(customMeal, index);
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
          );
        },
        itemCount: customMeal.resourceCustomMeals!.length,
      ),
    );
  }

  preMadeSubMealListView(PreMadeMeal preMadeMeal, mainIndex) {
    return SizedBox(
      height: Get.height * 0.28,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return preMadeMealView(preMadeMeal, mainIndex, index);
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
          );
        },
        itemCount: preMadeMeal.descendants!.length,
      ),
    );
  }

  subMealView(CustomMeal customMeal, index) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          exerciseNetworkImage(
              networkImage: customMeal.resourceCustomMeals![index].image,
              borderRadius: 20.0,
              avatarRadius: 20.0,
              width: Get.width * 0.6,
              height: Get.height * 0.20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customMeal.resourceCustomMeals![index].foodName!,
                  style: CustomTextStyles.bold(fontSize: 17.0, fontColor: themeBlack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  preMadeMealView(PreMadeMeal preMadeMeal, mainIndex, index) {
    return InkWell(
      onTap: () {
        if (AppStorage.userData.result!.user.isSubscribed == 1 ||
            AppStorage.userData.result!.user.isResourceSubscribed == 1) {
          Get.toNamed(Routes.EXERCISE_DETAILS, arguments: [
            preMadeMeal.descendants[index].id,
            1,
            1,
            true,
          ]);
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                exerciseNetworkImage(
                    networkImage: preMadeMeal.descendants![index].imageUrl,
                    borderRadius: 20.0,
                    avatarRadius: 20.0,
                    width: Get.width * 0.6,
                    height: Get.height * 0.20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        preMadeMeal.descendants![index]!.title,
                        style: CustomTextStyles.bold(fontSize: 17.0, fontColor: themeBlack),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppStorage.isLogin()
              ? Positioned(
                  right: 0.0,
                  child: InkWell(
                    onTap: () {
                      if (AppStorage.userData.result!.user.isSubscribed == 1 ||
                          AppStorage.userData.result!.user.isResourceSubscribed == 1) {
                        controller.resourceId =
                            controller.preMadeMealList[mainIndex].descendants[index].id;
                        controller.getWorkOut("Nutritional");
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.all(12.0),
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeGreen,
                      ),
                      child: SvgPicture.asset(ImageResourceSvg.plus),
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
