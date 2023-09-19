import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/data/all_exercise_model.dart';
import 'package:fasttrackfitness/app/data/pre_made_view_all.dart';
import 'package:fasttrackfitness/app/modules/trainee/all_exercise/controllers/all_exercise_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/custom_meal_model.dart';
import '../../../../routes/app_pages.dart';
import '../../resources/controllers/resources_controller.dart';

mixin AllExerciseViewComponents {
  var controller = Get.put(AllExerciseController());

  checkView() {
    if (controller.isLoading.value) {
      return const SizedBox();
    } else if (controller.isExercise == 0 && controller.allExerciseList.isNotEmpty) {
      return excerciseListView();
    } else if (controller.isExercise == 1 && controller.preMadeMealList.isNotEmpty) {
      return preMadeListView();
    } else {
      return customMealListView();
    }
  }

  excerciseListView() {
    return GridView.builder(
        controller: controller.scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, index) {
          if (index == controller.allExerciseList.length - 1 && controller.haseMore.value) {
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
          return subExerciseView(controller.allExerciseList[index], index);
        },
        itemCount: controller.allExerciseList.length);
  }

  preMadeListView() {
    return GridView.builder(
        controller: controller.scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.5),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
          return subPreMadeView(controller.preMadeMealList[index], index);
        },
        itemCount: controller.preMadeMealList.length);
  }

  subExerciseView(AllExercise subExercise, index) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.EXERCISE_DETAILS, arguments: [
          subExercise.id,
          controller.tag,
          controller.isExercise,
          controller.isFromResource
        ]);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mediaNetworkImage(
                    networkImage: subExercise.imageUrl,
                    width: Get.width / 2.5,
                    height: Get.height / 6.5,
                    borderRadius: 14.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        subExercise.title,
                        style: CustomTextStyles.bold(fontSize: 17.0, fontColor: themeBlack),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageResourceSvg.redClock,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            " ${CustomMethod.checkTime(subExercise.totalResourcesDuration)}" +
                                " | ${subExercise.exerciseCount}Exercises",
                            style: CustomTextStyles.normal(fontSize: 9.0, fontColor: colorGreyText),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            controller.isFromResource &&
                    AppStorage.getUserType() != EndPoints.USER_TYPE_TRAINER &&
                    AppStorage.isLogin()
                ? Positioned(
                    right: 0.0,
                    child: InkWell(
                      onTap: () {
                        var resCtr = Get.put(ResourcesController());
                        resCtr.resourceId = subExercise.id;
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
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  subPreMadeView(PreMadeMeals preMadeMeal, index) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.EXERCISE_DETAILS, arguments: [
                    preMadeMeal.id,
                    controller.tag,
                    controller.isExercise,
                    controller.isFromResource
                  ]);
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      mediaNetworkImage(
                          networkImage: preMadeMeal.imageUrl,
                          width: Get.width / 2.5,
                          height: Get.height * 0.2,
                          borderRadius: 14.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          preMadeMeal.title,
                          style: CustomTextStyles.bold(fontSize: 14.0, fontColor: themeBlack),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        controller.isFromResource &&
                AppStorage.getUserType() != EndPoints.USER_TYPE_TRAINER &&
                AppStorage.isLogin()
            ? Positioned(
                right: 0.0,
                child: InkWell(
                  onTap: () {
                    var resCtr = Get.put(ResourcesController());
                    resCtr.resourceId = preMadeMeal.id;
                    resCtr.getWorkOut("Nutritional");
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, top: 20),
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
              )
            : const SizedBox.shrink()
      ],
    );
  }

  customMealListView() {
    return GridView.builder(
        controller: controller.scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, index) {
          if (index == controller.customMealList.length - 1 && controller.haseMore.value) {
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
          return subCustomMealView(controller.customMealList[index], index);
        },
        itemCount: controller.customMealList.length);
  }

  subCustomMealView(CustomMeals customMealsData, index) {
    return Container(
      margin: const EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.EXERCISE_DETAILS, arguments: [
                customMealsData.id,
                controller.tag,
                controller.isExercise,
                controller.isFromResource,
                customMealsData,
                controller.mealIndex
              ]);
            },
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mediaNetworkImage(
                      networkImage: customMealsData.image,
                      width: Get.width / 2.5,
                      height: Get.height * 0.2,
                      borderRadius: 14.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      customMealsData.foodName!,
                      style: CustomTextStyles.bold(fontSize: 17.0, fontColor: themeBlack),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
