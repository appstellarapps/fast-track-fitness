import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/tdee/controllers/tdee_controller.dart';
import 'package:fasttrackfitness/app/modules/tdee/views/tdee_1.dart';
import 'package:fasttrackfitness/app/modules/tdee/views/tdee_2.dart';
import 'package:fasttrackfitness/app/modules/tdee/views/tdee_3.dart';
import 'package:fasttrackfitness/app/modules/tdee/views/tdee_4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin TDEEComponents {
  var controller = Get.put(TdeeController());

  userSteps(index) {
    return Obx(() => InkWell(
          onTap: () {
            if (controller.completedStepsIndex.value >= index) {
              controller.selectedStepsIndex.value = index;
            } else {
              controller.selectedStepsIndex.value = index;
              controller.completedStepsIndex.value = index;
            }
            if(index ==4){
              controller.calculation();
            }
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: controller.selectedStepsIndex.value >= index
                    ? themeGreen
                    : themeGrey,
                shape: BoxShape.circle),
            child: Center(
                child: Text(
              index.toString(),
              style: CustomTextStyles.semiBold(
                  fontSize: 15.0, fontColor: themeWhite),
            )),
          ),
        ));
  }

  screenView() {
    switch (controller.selectedStepsIndex.value) {
      case 1:
        return TDEE1();
      case 2:
        return TDEE2();
      case 3:
        return TDEE3();
      case 4:
        return TDEE4();
      default:
        return TDEE1();
    }
  }
}
