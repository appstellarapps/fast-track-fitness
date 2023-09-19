import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/get_nutritional_workout_details.dart';
import '../controllers/nutrition__details_view_controller.dart';

mixin NutritionDetailsComponents {
  var controller = Get.put(NutritionDetailsViewController());

  mealsListView(mainIndex) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      decoration:
          BoxDecoration(color: colorGreyEditText, borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.workoutDetailsList[mainIndex].name,
            style: CustomTextStyles.bold(fontSize: 16.0, fontColor: colorGreyText),
          ),
          const SizedBox(height: 10),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, subIndex) {
              return dietView(mainIndex, subIndex);
            },
            separatorBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
              );
            },
            itemCount: controller.workoutDetailsList[mainIndex].workoutNutritionalMealDaily.length,
          ),
        ],
      ),
    );
  }

  dietView(mainIndex, subIndex) {
    List<WorkoutNutritionalMealDaily> workoutNutritionalMealDaily =
        controller.workoutDetailsList[mainIndex].workoutNutritionalMealDaily;
    return Column(
      children: [
        InkWell(
          onTap: () {
            workoutNutritionalMealDaily[subIndex].isShow.value =
                !workoutNutritionalMealDaily[subIndex].isShow.value;
          },
          child: Row(
            children: [
              circleProfileNetworkImage(
                  networkImage: workoutNutritionalMealDaily[subIndex].image,
                  width: Get.width * 0.2,
                  height: Get.height * 0.10,
                  borderRadius: 20.0,
                  avatarRadius: 20.0),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  workoutNutritionalMealDaily[subIndex].foodName.toString(),
                  style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => SvgPicture.asset(workoutNutritionalMealDaily[subIndex].isShow.value
                    ? ImageResourceSvg.upArrow
                    : ImageResourceSvg.downArrow)),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => workoutNutritionalMealDaily[subIndex].isShow.value
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workoutNutritionalMealDaily[subIndex].foodName!,
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                      ),
                      Text(
                        "Per ${workoutNutritionalMealDaily[subIndex].weight != 0 ? workoutNutritionalMealDaily[subIndex].weight : workoutNutritionalMealDaily[subIndex].defultWeight} g",
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
                                      "${workoutNutritionalMealDaily[subIndex].protein != 0 ? workoutNutritionalMealDaily[subIndex].protein : workoutNutritionalMealDaily[subIndex].defultProtein} g",
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
                                      "${workoutNutritionalMealDaily[subIndex].fat != 0 ? workoutNutritionalMealDaily[subIndex].fat : workoutNutritionalMealDaily[subIndex].defultFat} g",
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
                                      "${workoutNutritionalMealDaily[subIndex].carbs != 0 ? workoutNutritionalMealDaily[subIndex].carbs : workoutNutritionalMealDaily[subIndex].defultCarbs} g",
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
                                      "${workoutNutritionalMealDaily[subIndex].calories != 0 ? workoutNutritionalMealDaily[subIndex].calories : workoutNutritionalMealDaily[subIndex].defultCalories} g",
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
