import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_button.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/tdee/controllers/tdee_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../core/helper/images_resources.dart';

class TDEE1 extends StatelessWidget {
  const TDEE1({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TdeeController());
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          controller.gender.value = 1;
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: controller.gender.value == 1
                                  ? const Color(0xff030303)
                                  : const Color(0xfff9f9f9)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                ImageResourceSvg.maleIC,
                                color: controller.gender.value == 1 ? themeWhite : themeBlack,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text("Male",
                                  style: CustomTextStyles.semiBold(
                                    fontSize: 16.0,
                                    fontColor:
                                        controller.gender.value == 1 ? themeWhite : themeBlack,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          controller.gender.value = 2;
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: controller.gender.value == 2
                                  ? const Color(0xff030303)
                                  : const Color(0xfff9f9f9)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageResourceSvg.femaleIC,
                                  color: controller.gender.value == 2 ? themeWhite : themeBlack),
                              const SizedBox(
                                height: 8,
                              ),
                              Text("Female",
                                  style: CustomTextStyles.semiBold(
                                    fontSize: 16.0,
                                    fontColor:
                                        controller.gender.value == 2 ? themeWhite : themeBlack,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: const Color(0xfff9f9f9)),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5, color: const Color(0xffe8e9ea)),
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Row(
                              children: [
                                Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.heightInCM.value = true;
                                      controller.heightMI.value = 91.0;
                                      controller.heightMX.value = 214.0;
                                      // controller.height.value = 130.0;
                                      controller.convertFeetToCm();
                                    },
                                    child: Container(
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.0),
                                        color: controller.heightInCM.value
                                            ? themeGreen
                                            : Colors.transparent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                                        child: Center(
                                          child: Text(
                                            "cm",
                                            style: CustomTextStyles.normal(
                                                fontSize: 11.0,
                                                fontColor: controller.heightInCM.value
                                                    ? themeWhite
                                                    : themeBlack),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.heightInCM.value = false;
                                      controller.heightMI.value = 3.0;
                                      controller.heightMX.value = 7.0;
                                      controller.convertCmToFeet();
                                    },
                                    child: Container(
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.0),
                                        color: !controller.heightInCM.value
                                            ? themeGreen
                                            : Colors.transparent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                                        child: Center(
                                          child: Text(
                                            "ft",
                                            style: CustomTextStyles.normal(
                                                fontSize: 11.0,
                                                fontColor: !controller.heightInCM.value
                                                    ? themeWhite
                                                    : themeBlack),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Height",
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeGrey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Text(
                      controller.height.value.toStringAsFixed(2),
                      style: CustomTextStyles.bold(fontSize: 30.0, fontColor: themeBlack),
                    ),
                  ),
                  Obx(
                    () => SfSlider(
                      min: controller.heightMI.value,
                      max: controller.heightMX.value,
                      value: controller.height.value,
                      interval: 1,
                      showTicks: false,
                      activeColor: themeBlack,
                      inactiveColor: themeLightWhite,
                      showLabels: false,
                      enableTooltip: false,
                      minorTicksPerInterval: 1,
                      onChanged: (value) {
                        controller.height.value = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8), color: const Color(0xfff9f9f9)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 70,
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5, color: const Color(0xffe8e9ea)),
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        controller.weightInKG.value = true;
                                        controller.convertLbToKg();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16.0),
                                          color: controller.weightInKG.value
                                              ? themeGreen
                                              : Colors.transparent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 1, bottom: 1),
                                          child: Center(
                                            child: Text(
                                              "kg",
                                              style: CustomTextStyles.normal(
                                                  fontSize: 11.0,
                                                  fontColor: controller.weightInKG.value
                                                      ? themeWhite
                                                      : themeBlack),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        controller.weightInKG.value = false;
                                        controller.convertKgToLb();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16.0),
                                          color: !controller.weightInKG.value
                                              ? themeGreen
                                              : Colors.transparent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 1, bottom: 1),
                                          child: Center(
                                            child: Text(
                                              "lb",
                                              style: CustomTextStyles.normal(
                                                  fontSize: 11.0,
                                                  fontColor: !controller.weightInKG.value
                                                      ? themeWhite
                                                      : themeBlack),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Text(
                            "Weight",
                            style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeGrey),
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Obx(
                            () => Text(
                              controller.weightOfHuman.value.toString(),
                              style: CustomTextStyles.bold(fontSize: 30.0, fontColor: themeBlack),
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (controller.weightInKG.value) {
                                    if (controller.weightOfHuman.value <= 25 ||
                                        controller.weightOfHuman.value > 200) {
                                    } else {
                                      controller.weightOfHuman.value--;
                                    }
                                  } else {
                                    if (controller.weightOfHuman.value <= 55 ||
                                        controller.weightOfHuman.value > 441) {
                                    } else {
                                      controller.weightOfHuman.value--;
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: themeLightWhite),
                                  child: SvgPicture.asset(ImageResourceSvg.icMinus),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.weightInKG.value) {
                                    if (controller.weightOfHuman.value < 25 ||
                                        controller.weightOfHuman.value >= 200) {
                                    } else {
                                      controller.weightOfHuman.value++;
                                    }
                                  } else {
                                    if (controller.weightOfHuman.value < 55 ||
                                        controller.weightOfHuman.value >= 441) {
                                    } else {
                                      controller.weightOfHuman.value++;
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: themeLightWhite),
                                  child: SvgPicture.asset(
                                    ImageResourceSvg.icPlus,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8), color: const Color(0xfff9f9f9)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Text(
                            "Age",
                            style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeGrey),
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Obx(
                            () => Text(
                              controller.age.value.toString(),
                              style: CustomTextStyles.bold(fontSize: 30.0, fontColor: themeBlack),
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (controller.age.value < 10 || controller.age.value > 100) {
                                  } else {
                                    controller.age.value--;
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: themeLightWhite),
                                  child: SvgPicture.asset(ImageResourceSvg.icMinus),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.age.value < 10 || controller.age.value > 100) {
                                  } else {
                                    controller.age.value++;
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: themeLightWhite),
                                  child: SvgPicture.asset(
                                    ImageResourceSvg.icPlus,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: ButtonRegular(
                  onPress: () {
                    controller.selectedStepsIndex.value = 2;
                  },
                  buttonText: "NEXT",
                ))
          ],
        ),
      ),
    );
  }
}
