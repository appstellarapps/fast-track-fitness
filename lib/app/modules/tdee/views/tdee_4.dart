import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/tdee/controllers/tdee_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../core/helper/common_widget/custom_button.dart';

class TDEE4 extends StatelessWidget {
  const TDEE4({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TdeeController());
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Obx(
                () => Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Recommended ',
                      style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack),
                      children: <TextSpan>[
                        TextSpan(
                            text: controller.TCI.value.toStringAsFixed(0),
                            style:
                                CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeGreen)),
                        TextSpan(
                            text: ' calories per day',
                            style:
                                CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              AspectRatio(
                  aspectRatio: 2,
                  child: Obx(
                    () => Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  controller.touchedIndex.value = -1;
                                  return;
                                }
                                controller.touchedIndex.value =
                                    pieTouchResponse.touchedSection!.touchedSectionIndex;
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 50,
                            sections: showingSections(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.TCI.value.toStringAsFixed(0),
                              style:
                                  CustomTextStyles.semiBold(fontSize: 20.0, fontColor: themeBlack),
                            ),
                            Text(
                              "Calories",
                              style:
                                  CustomTextStyles.semiBold(fontSize: 15.0, fontColor: themeBlack),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xffFF5674)),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Protein",
                              style: CustomTextStyles.normal(fontSize: 14.0, fontColor: themeGrey),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Obx(() => Text(
                                  "${controller.protein.value.toStringAsFixed(0)}g",
                                  style: CustomTextStyles.medium(
                                      fontSize: 20.0, fontColor: themeBlack),
                                )),
                            Obx(() => Text(
                                  "${controller.proteinPer.value.toStringAsFixed(0)}%",
                                  style: CustomTextStyles.medium(
                                      fontSize: 15.0, fontColor: themeBlack),
                                )),
                          ],
                        ),
                        Container(
                            width: 1.5, decoration: const BoxDecoration(color: Color(0xffe8e9ea))),
                        Column(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xff69F2E6)),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Carbs",
                              style: CustomTextStyles.normal(fontSize: 14.0, fontColor: themeGrey),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Obx(() => Text(
                                  "${controller.carbs.value.toStringAsFixed(0)}g",
                                  style: CustomTextStyles.medium(
                                      fontSize: 20.0, fontColor: themeBlack),
                                )),
                            Obx(() => Text(
                                  "${controller.carbsPer.value.toStringAsFixed(0)}%",
                                  style: CustomTextStyles.medium(
                                      fontSize: 15.0, fontColor: themeBlack),
                                )),
                          ],
                        ),
                        Container(
                            width: 1.5, decoration: const BoxDecoration(color: Color(0xffe8e9ea))),
                        Column(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xffFAF119)),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Fat",
                              style: CustomTextStyles.normal(fontSize: 14.0, fontColor: themeGrey),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Obx(
                              () => Text(
                                "${controller.fat.value.toStringAsFixed(0)}g",
                                style:
                                    CustomTextStyles.medium(fontSize: 20.0, fontColor: themeBlack),
                              ),
                            ),
                            Obx(
                              () => Text(
                                "${controller.fatPer.value.toStringAsFixed(0)}%",
                                style:
                                    CustomTextStyles.medium(fontSize: 15.0, fontColor: themeBlack),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  controller.isModifyOpen.value = !controller.isModifyOpen.value;
                },
                child: Obx(
                  () => Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: Get.width * 0.9,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12.0),
                            topRight: const Radius.circular(12.0),
                            bottomLeft: Radius.circular(controller.isModifyOpen.value ? 0 : 12.0),
                            bottomRight: Radius.circular(controller.isModifyOpen.value ? 0 : 12.0)),
                        color: const Color(0xfff6f6f6)),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Center(
                            child: Text(
                          "Modify Ratios",
                          style: CustomTextStyles.bold(fontSize: 16.0, fontColor: themeBlack),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Obx(() => Icon(
                                controller.isModifyOpen.value
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.isModifyOpen.value
                    ? Container(
                        width: Get.width * 0.9,
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(12.0),
                                bottomRight: const Radius.circular(12.0),
                                topLeft: Radius.circular(controller.isModifyOpen.value ? 0 : 12.0),
                                topRight:
                                    Radius.circular(controller.isModifyOpen.value ? 0 : 12.0)),
                            color: const Color(0xfff6f6f6)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0xff0D88F9)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Text("Calories",
                                            style: CustomTextStyles.medium(
                                                fontSize: 14.0, fontColor: themeGrey)),
                                      ),
                                      Flexible(
                                        child: Obx(
                                          () => SfSlider(
                                            min: 0,
                                            max: 4000,
                                            value: controller.TCI.value,
                                            interval: 1,
                                            showTicks: false,
                                            activeColor: const Color(0xff0D88F9),
                                            inactiveColor: themeLightWhite,
                                            showLabels: false,
                                            enableTooltip: false,
                                            minorTicksPerInterval: 1,
                                            thumbIcon: Container(
                                              decoration: const BoxDecoration(
                                                color: themeWhite,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.pause_outlined,
                                                color: Color(0xff0D88F9),
                                                size: 15,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              controller.TCI.value = value;
                                              controller.protein.value =
                                                  ((controller.proteinPer.value / 100) *
                                                          controller.TCI.value) /
                                                      4;
                                              controller.carbs.value =
                                                  ((controller.carbsPer.value / 100) *
                                                          controller.TCI.value) /
                                                      4;
                                              controller.fat.value =
                                                  ((controller.fatPer.value / 100) *
                                                          controller.TCI.value) /
                                                      9;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(() => Text(
                                        "${controller.TCI.value.toStringAsFixed(0)} calories",
                                        style: CustomTextStyles.medium(
                                            fontSize: 10.0, fontColor: themeBlack),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0xffFF5674)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Text("Protein",
                                            style: CustomTextStyles.medium(
                                                fontSize: 14.0, fontColor: themeGrey)),
                                      ),
                                      Obx(
                                        () => Flexible(
                                          child: SfSlider(
                                            min: 0,
                                            max: 100,
                                            value: controller.proteinPer.value,
                                            interval: 1,
                                            showTicks: false,
                                            activeColor: const Color(0xffFF5674),
                                            inactiveColor: themeLightWhite,
                                            showLabels: false,
                                            enableTooltip: false,
                                            minorTicksPerInterval: 1,
                                            thumbIcon: Container(
                                              decoration: const BoxDecoration(
                                                color: themeWhite,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.pause_outlined,
                                                color: Color(0xffFF5674),
                                                size: 15,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              print(value);
                                              controller.proteinPer.value = value;
                                              var v = (100 - value) / 3;
                                              controller.carbsPer.value = v + v;
                                              controller.fatPer.value = v;
                                              controller.protein.value =
                                                  ((controller.proteinPer.value / 100) *
                                                          controller.TCI.value) /
                                                      4;
                                              controller.carbs.value =
                                                  ((controller.carbsPer.value / 100) *
                                                          controller.TCI.value) /
                                                      4;
                                              controller.fat.value =
                                                  ((controller.fatPer.value / 100) *
                                                          controller.TCI.value) /
                                                      9;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(() => Text(
                                        "${controller.protein.value.toStringAsFixed(0)}g  ${controller.proteinPer.value.toStringAsFixed(0)}%",
                                        style: CustomTextStyles.medium(
                                            fontSize: 10.0, fontColor: themeBlack),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0xff69F2E6)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Text("Carbs",
                                            style: CustomTextStyles.medium(
                                                fontSize: 14.0, fontColor: themeGrey)),
                                      ),
                                      Obx(
                                        () => Flexible(
                                          child: SfSlider(
                                            min: 0,
                                            max: 100,
                                            value: controller.carbsPer.value,
                                            interval: 1,
                                            showTicks: false,
                                            activeColor: const Color(0xff69F2E6),
                                            inactiveColor: themeLightWhite,
                                            showLabels: false,
                                            enableTooltip: false,
                                            minorTicksPerInterval: 1,
                                            thumbIcon: Container(
                                              decoration: const BoxDecoration(
                                                color: themeWhite,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.pause_outlined,
                                                color: Color(0xff69F2E6),
                                                size: 15,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              print(value);
                                              controller.carbsPer.value = value;
                                              var v = (100 - value) / 3;
                                              controller.proteinPer.value = v + v;
                                              controller.fatPer.value = v;
                                              controller.protein.value =
                                                  ((controller.proteinPer.value / 100) *
                                                          controller.TCI.value) /
                                                      4;
                                              controller.carbs.value =
                                                  ((controller.carbsPer.value / 100) *
                                                          controller.TCI.value) /
                                                      4;
                                              controller.fat.value =
                                                  ((controller.fatPer.value / 100) *
                                                          controller.TCI.value) /
                                                      9;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${controller.carbs.value.toStringAsFixed(0)}g  ${controller.carbsPer.value.toStringAsFixed(0)}%",
                                    style: CustomTextStyles.medium(
                                        fontSize: 10.0, fontColor: themeBlack),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0xffFAF119)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Text("Fat",
                                            style: CustomTextStyles.medium(
                                                fontSize: 14.0, fontColor: themeGrey)),
                                      ),
                                      Obx(
                                        () => Flexible(
                                          child: SfSlider(
                                            min: 0,
                                            max: 100,
                                            value: controller.fatPer.value,
                                            interval: 1,
                                            showTicks: false,
                                            activeColor: const Color(0xffFAF119),
                                            inactiveColor: themeLightWhite,
                                            showLabels: false,
                                            enableTooltip: false,
                                            minorTicksPerInterval: 1,
                                            thumbIcon: Container(
                                              decoration: const BoxDecoration(
                                                color: themeWhite,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.pause_outlined,
                                                color: Color(0xffFAF119),
                                                size: 15,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              print(value);

                                              controller.fatPer.value = value;
                                              controller.proteinPer.value = (100 - value) / 2;
                                              controller.carbsPer.value = (100 - value) / 2;
                                              controller.protein.value =
                                                  ((controller.proteinPer.value / 100) *
                                                          controller.TCI.value) /
                                                      4;
                                              controller.carbs.value =
                                                  ((controller.carbsPer.value / 100) *
                                                          controller.TCI.value) /
                                                      4;
                                              controller.fat.value =
                                                  ((controller.fatPer.value / 100) *
                                                          controller.TCI.value) /
                                                      9;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${controller.fat.value.toStringAsFixed(0)}g  ${controller.fatPer.value.toStringAsFixed(0)}%",
                                    style: CustomTextStyles.medium(
                                        fontSize: 10.0, fontColor: themeBlack),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                controller.carbsPer.value = 40;
                                controller.proteinPer.value = 40;
                                controller.fatPer.value = 20;
                                controller.calculation();
                              },
                              child: Container(
                                width: Get.width * 0.5,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xffbbbbbb)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.refresh),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Reset to recommended",
                                      style: CustomTextStyles.bold(
                                          fontSize: 12.0, fontColor: themeBlack),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: ButtonRegular(
                    onPress: () {
                      apiLoader(asyncCall: () => controller.sendData());
                    },
                    buttonText: "SAVE",
                  )),
              const SizedBox(
                height: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    var controller = Get.put(TdeeController());
    return List.generate(3, (i) {
      final isTouched = i == controller.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffFF5674),
            value: controller.proteinPer.value,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.transparent,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffFAF119),
            value: controller.fatPer.value,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.transparent,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff69F2E6),
            value: controller.carbsPer.value,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.transparent,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
