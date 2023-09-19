import 'package:fasttrackfitness/app/core/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/keyboard_avoider.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/start_tracking_calories_controller.dart';

mixin StartTrackingCaloriesComponents {
  var controller = Get.put(StartTrackingCaloriesController());

  var searchCommonBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: themeBlack,
    ),
  );

  startNutritionalWorkoutList(context) {
    return Column(
      children: [
        Expanded(
          child: KeyboardAvoider(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 20.0),
              controller: controller.scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == controller.workoutList.length - 1 && controller.haseMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
                    ),
                  );
                }
                return nutritionalWorkOutView(index);
              },
              separatorBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                );
              },
              itemCount: controller.workoutList.length,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: ButtonRegular(
            buttonText: "Save",
            onPress: () {
              Helper().hideKeyBoard();
              controller.saveNutritionalWork();
            },
          ),
        ),
      ],
    );
  }

  nutritionalWorkOutView(mainIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.workoutList[mainIndex].name,
          style: CustomTextStyles.bold(fontSize: 20.0, fontColor: themeBlack),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, subIndex) {
            return mealDietView(mainIndex, subIndex);
          },
          separatorBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
            );
          },
          itemCount: controller.workoutList[mainIndex].workoutNutritionalDaily.length,
        ),
      ],
    );
  }

  mealDietView(mainIndex, subIndex) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration:
          BoxDecoration(color: colorGreyEditText, borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex].name.toString(),
            style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
          ),
          const SizedBox(height: 10),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return preDietView(mainIndex, subIndex, i);
            },
            separatorBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              );
            },
            itemCount: controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                .workoutNutritionalMealDaily!.length,
          )
        ],
      ),
    );
  }

  preDietView(mainIndex, subIndex, subChildIndex) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            if (controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                .workoutNutritionalMealDaily[subChildIndex].isSelected.value) {
              if (controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                      .workoutNutritionalMealDaily[subChildIndex].controller.text !=
                  '0') {
                controller.getMealCalculation(
                    mainIndex,
                    subIndex,
                    subChildIndex,
                    controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                        .workoutNutritionalMealDaily[subChildIndex].controller.value.text);
                controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                    .workoutNutritionalMealDaily[subChildIndex].isSelected.value = false;
              }
            }
            controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                    .workoutNutritionalMealDaily[subChildIndex].isShow.value =
                !controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                    .workoutNutritionalMealDaily[subChildIndex].isShow.value;
          },
          child: Row(
            children: [
              mediaNetworkImage(
                  networkImage: controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                      .workoutNutritionalMealDaily[subChildIndex].image,
                  width: Get.width * 0.2,
                  height: Get.height * 0.10,
                  borderRadius: 20.0,
                  avatarRadius: 20.0),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                      .workoutNutritionalMealDaily[subChildIndex].foodName
                      .toString(),
                  style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => SvgPicture.asset(controller
                        .workoutList[mainIndex]
                        .workoutNutritionalDaily[subIndex]
                        .workoutNutritionalMealDaily[subChildIndex]
                        .isShow
                        .value
                    ? ImageResourceSvg.upArrow
                    : ImageResourceSvg.downArrow)),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                .workoutNutritionalMealDaily[subChildIndex].isShow.value
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                                .workoutNutritionalMealDaily[subChildIndex].foodName,
                            style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                          ),
                          Text(
                            'Enter the amount of diet you had',
                            style: CustomTextStyles.normal(fontSize: 10.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          focusNode: controller
                              .workoutList[mainIndex]
                              .workoutNutritionalDaily[subIndex]
                              .workoutNutritionalMealDaily[subChildIndex]
                              .focusNode
                              .value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 4,
                          controller: controller
                              .workoutList[mainIndex]
                              .workoutNutritionalDaily[subIndex]
                              .workoutNutritionalMealDaily[subChildIndex]
                              .controller,
                          key: controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                              .workoutNutritionalMealDaily[subChildIndex].key,
                          onFieldSubmitted: (val) {
                            if (val.isNotEmpty) {
                              controller.getMealCalculation(
                                  mainIndex, subIndex, subChildIndex, val);
                            }
                          },
                          onEditingComplete: () {
                            controller
                                .workoutList[mainIndex]
                                .workoutNutritionalDaily[subIndex]
                                .workoutNutritionalMealDaily[subChildIndex]
                                .isSelected
                                .value = false;
                          },
                          onTap: () {
                            controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex]
                                .workoutNutritionalMealDaily[subChildIndex].isSelected.value = true;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                            counterText: "",
                            hintText: "",
                            border: searchCommonBorderStyle,
                            focusedBorder: searchCommonBorderStyle,
                            isDense: true,
                            hintStyle:
                                CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                            suffixText: "g",
                            suffixStyle: CustomTextStyles.semiBold(
                              fontSize: 14.0,
                              fontColor: colorGreyText,
                            ),
                          ),
                        ),
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
                                      "${controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex].workoutNutritionalMealDaily[subChildIndex].protein} g",
                                      style: CustomTextStyles.normal(
                                          fontSize: 12.0, fontColor: themeBlack),
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
                                      "${controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex].workoutNutritionalMealDaily[subChildIndex].fat} g",
                                      style: CustomTextStyles.normal(
                                          fontSize: 12.0, fontColor: themeBlack),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding: const EdgeInsets.only(right: 5, left: 5, top: 3),
                                  color: colorGreyEditText,
                                  child: Text(' Fat  ',
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
                                      "${controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex].workoutNutritionalMealDaily[subChildIndex].carbs} g",
                                      style: CustomTextStyles.normal(
                                          fontSize: 12.0, fontColor: themeBlack),
                                      overflow: TextOverflow.ellipsis,
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
                                      "${controller.workoutList[mainIndex].workoutNutritionalDaily[subIndex].workoutNutritionalMealDaily[subChildIndex].calories} g",
                                      style: CustomTextStyles.normal(
                                          fontSize: 12.0, fontColor: themeBlack),
                                      overflow: TextOverflow.ellipsis,
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
