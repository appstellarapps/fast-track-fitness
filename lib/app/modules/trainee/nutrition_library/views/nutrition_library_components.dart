import 'package:fasttrackfitness/app/modules/trainee/nutrition_library/controllers/nutrition_library_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/custom_meal_model.dart';
import '../../../../data/premade_meal_model.dart';
import '../../../../routes/app_pages.dart';

mixin NutritionLibraryComponents {
  var controller = Get.put(NutritionLibraryController());

  var searchCommonBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xffE6E6E6),
      ));

  checkView() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.isTyping.value) {
      return const Expanded(
        child: Align(alignment: Alignment.center, child: CircularProgressIndicator(color: themeBlack)),
      );
    } else if (controller.customMealList.isNotEmpty && controller.tag == 0) {
      return mainMealListView();
    } else if (controller.preMadeMealList.isNotEmpty && controller.tag == 1) {
      return preMadeMealListView();
    } else {
      return Expanded(child: noDataFound());
    }
  }

  mainMealListView() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 100.0),
        controller: controller.scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == controller.customMealList.length - 1 && controller.haseMore.value) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
              ),
            );
          }

          return mainMealView(index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox.shrink();
        },
        itemCount: controller.customMealList.length,
      ),
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
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
              ),
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

  mainMealView(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.customMealList[index].title!,
                  style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: colorGreyText),
                ),
              ),
              controller.customMealList[index].resourceCustomMealsCount! > 5
                  ? InkWell(
                      onTap: () {
                        Get.toNamed(Routes.ALL_EXERCISE, arguments: [controller.customMealList[index].id, controller.tag, 1, false, controller.isMeal]);
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
        subMealListView(controller.customMealList[index])
      ],
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
                        Get.toNamed(Routes.ALL_EXERCISE, arguments: [controller.preMadeMealList[index].id, controller.tag, 1, false]);
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
        preMadeSubMealListView(controller.preMadeMealList[index])
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

  preMadeSubMealListView(PreMadeMeal preMadeMeal) {
    return SizedBox(
      height: Get.height * 0.28,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return preMadeMealView(preMadeMeal, index);
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
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.EXERCISE_DETAILS, arguments: [customMeal.id, controller.tag, 1, false, customMeal.resourceCustomMeals![index], controller.isMeal]);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            exerciseNetworkImage(networkImage: customMeal.resourceCustomMeals![index].image, borderRadius: 20.0, avatarRadius: 20.0, width: Get.width * 0.6, height: Get.height * 0.20),
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
      ),
    );
  }

  preMadeMealView(PreMadeMeal preMadeMeal, index) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.EXERCISE_DETAILS, arguments: [preMadeMeal.descendants[index].id, controller.tag, 1, false, preMadeMeal.descendants![index], controller.isMeal]);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            exerciseNetworkImage(networkImage: preMadeMeal.descendants![index].imageUrl, borderRadius: 20.0, avatarRadius: 20.0, width: Get.width * 0.6, height: Get.height * 0.20),
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
    );
  }
}
