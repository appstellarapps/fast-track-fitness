import 'package:cached_network_image/cached_network_image.dart';
import 'package:fasttrackfitness/app/modules/trainer/user_stats/controllers/user_stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/nutritional_stats_model.dart';
import '../../../../data/stats_distance_model.dart';

mixin UserStatsComponents {
  var controller = Get.put(UserStatsController());

  myStateTab(index, {tabText}) {
    return Obx(() => Expanded(
          child: InkWell(
            onTap: () {
              controller.selectedStateIndex.value = index;
              if (index == 0) {
                controller.isTabLoading.value = true;
                controller.getMyExerciseStats();
              } else {
                controller.isTabLoading.value = true;
                controller.getMyNutritionalStats();
              }
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: index == controller.selectedStateIndex.value ? themeGreen : inputGrey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(index == 1 ? 0.0 : 20.0),
                          bottomRight: Radius.circular(index == 0 ? 0.0 : 20.0),
                          topRight: Radius.circular(index == 0 ? 0.0 : 20.0),
                          topLeft: Radius.circular(index == 1 ? 0.0 : 20.0))),
                  child: Center(
                    child: Text(
                      tabText,
                      style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  exerciseStateView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        commonDateSelectionView(),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: borderColor),
          ),
          child: Stack(
            children: [
              SfCartesianChart(
                plotAreaBorderWidth: 0.0,
                primaryXAxis: CategoryAxis(
                  axisLine: const AxisLine(width: 0),
                  isVisible: false,
                  majorGridLines: const MajorGridLines(width: 0), //
                ),
                primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(
                        width: 0), // Set axisLine width to 0 to remove the vertical line
                    majorTickLines: const MajorTickLines(width: 0)),
                tooltipBehavior: controller.tooltip,
                borderWidth: 0.0,
                borderColor: Colors.transparent,
                series: <ChartSeries<DistanceResult, String>>[
                  ColumnSeries<DistanceResult, String>(
                      name: controller.selectedTypeIndex.value == 0 ? "Distance" : "Duration",
                      dataSource: controller.distanceModel.result!,
                      xValueMapper: (DistanceResult data, _) =>
                          controller.selectedTypeIndex.value == 0 ? data.chartKms : data.chartHours,
                      yValueMapper: (DistanceResult data, _) => double.parse(data.percentage),
                      pointColorMapper: (DistanceResult data, _) {
                        return Color(
                            int.parse(data.bodyColour.substring(1, 7), radix: 16) + 0xFF000000);
                      },
                      width: controller.selectedTypeIndex.value == 0 ? 0.5 : 0.2)
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          controller.selectedTypeIndex.value == 0 ? "Total Distance %" : "Total Duration %",
          style: CustomTextStyles.semiBold(fontSize: 15.0, fontColor: themeBlack),
        ),
        const SizedBox(height: 20.0),
        totalDurationView(),
        const SizedBox(height: 20.0),
      ],
    );
  }

  commonDateSelectionView() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Helper().hideKeyBoard();
                  controller.selectDate(true);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "From",
                        style: CustomTextStyles.normal(fontSize: 12.0, fontColor: themeBlack),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      isDense: true,
                      enabledTextField: false,
                      key: controller.startDateKey,
                      hintText: "Start date",
                      controller: controller.startDateCtr,
                      hasBorder: true,
                      borderColor: const Color(0xffD0E8E0),
                      fontColor: themeBlack,
                      validateTypes: ValidateTypes.empty,
                      style: CustomTextStyles.semiBold(
                        fontSize: 14.0,
                        fontColor: themeBlack,
                      ),
                      hintStyle: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                      textInputAction: TextInputAction.next,
                      contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(ImageResourceSvg.blackCalendarIc),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                Helper().hideKeyBoard();
                controller.selectDate(false);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "To",
                      style: CustomTextStyles.normal(fontSize: 12.0, fontColor: themeBlack),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    isDense: true,
                    enabledTextField: false,
                    key: controller.endDateKey,
                    hintText: "End date",
                    controller: controller.endDateCtr,
                    hasBorder: true,
                    borderColor: const Color(0xffD0E8E0),
                    fontColor: themeBlack,
                    validateTypes: ValidateTypes.empty,
                    style: CustomTextStyles.semiBold(
                      fontSize: 14.0,
                      fontColor: themeBlack,
                    ),
                    hintStyle: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                    textInputAction: TextInputAction.next,
                    contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset(ImageResourceSvg.blackCalendarIc),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
        const SizedBox(height: 20),
        controller.selectedStateIndex.value == 0
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: colorGreyEditText, borderRadius: BorderRadius.circular(8.0)),
                width: Get.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.typeList[controller.selectedTypeIndex.value],
                    hint: Text(
                      "type",
                      style: CustomTextStyles.semiBold(
                        fontSize: 14.0,
                        fontColor: colorGreyText,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      for (var i = 0; i < controller.typeList.length; i++) {
                        if (controller.typeList[i] == newValue) {
                          if (controller.selectedTypeIndex.value != i) {
                            controller.isTabLoading.value = true;
                            apiLoader(asyncCall: () => controller.getMyExerciseStats());
                          }
                          controller.selectedTypeIndex.value = i;
                        }
                      }
                    },
                    items: controller.typeList.map((String object) {
                      return DropdownMenuItem<String>(
                        value: object,
                        child: Text(object),
                      );
                    }).toList(),
                    style: CustomTextStyles.semiBold(
                      fontSize: 14.0,
                      fontColor: themeBlack,
                    ),
                    // Customize the text color
                    icon: SvgPicture.asset(
                      ImageResourceSvg.downArrow,
                      color: colorGreyText,
                    ), // Customize the dropdown icon
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  nutritionalStateView() {
    return Column(
      children: [
        const SizedBox(height: 20),
        commonDateSelectionView(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: borderColor),
          ),
          child: SfCartesianChart(
            plotAreaBorderWidth: 0.0,
            primaryXAxis: CategoryAxis(
              labelStyle: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),

              axisLine: const AxisLine(width: 0),
              isVisible: true,
              majorGridLines: const MajorGridLines(width: 0), //
            ),
            primaryYAxis: NumericAxis(
                axisLine:
                    const AxisLine(width: 0), // Set axisLine width to 0 to remove the vertical line
                majorTickLines: const MajorTickLines(width: 0)),
            series: <ChartSeries<ChartDetail, String>>[
              ColumnSeries<ChartDetail, String>(
                dataSource: controller.nutritionalStatsModel.result!.chartDetails,
                xValueMapper: (ChartDetail data, _) => "${data.category}",
                yValueMapper: (ChartDetail data, _) => data.total,
                name: 'Total',
                pointColorMapper: (ChartDetail data, _) {
                  return Color(int.parse(data.totalColour.substring(1, 7), radix: 16) + 0xFF000000);
                },
              ),
              ColumnSeries<ChartDetail, String>(
                dataSource: controller.nutritionalStatsModel.result!.chartDetails,
                xValueMapper: (ChartDetail data, _) => data.category,
                yValueMapper: (ChartDetail data, _) => data.consumed,
                name: 'consumed',
                pointColorMapper: (ChartDetail data, _) {
                  return Color(
                      int.parse(data.consumedColour.substring(1, 7), radix: 16) + 0xFF000000);
                },
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          ),
        ),
        const SizedBox(height: 20),
        controller.nutritionalStatsModel.result!.totalCalories != 0
            ? Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  children: [
                    Text(
                      "Daily Calorie Counter",
                      style: CustomTextStyles.semiBold(fontSize: 15.0, fontColor: themeBlack),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      heightFactor: 0.85,
                      child: Stack(
                        children: [
                          gauges.SfRadialGauge(
                            axes: <gauges.RadialAxis>[
                              gauges.RadialAxis(
                                  canScaleToFit: false,
                                  showLabels: false,
                                  axisLineStyle: const gauges.AxisLineStyle(
                                      thickness: 0, cornerStyle: gauges.CornerStyle.bothCurve),
                                  majorTickStyle: const gauges.MajorTickStyle(length: 0),
                                  minorTickStyle: const gauges.MinorTickStyle(length: 0),
                                  pointers: <gauges.GaugePointer>[
                                    const gauges.RangePointer(
                                        value: 0, cornerStyle: gauges.CornerStyle.bothCurve),
                                    gauges.MarkerPointer(
                                      markerType: gauges.MarkerType.invertedTriangle,
                                      color: themeGreen,
                                      markerHeight: 20,
                                      value: ((controller
                                                  .nutritionalStatsModel.result!.consumedCalories
                                                  .toDouble() *
                                              100) /
                                          (controller.nutritionalStatsModel.result!.totalCalories)),
                                      markerWidth: 20,
                                      markerOffset: -10,
                                      enableDragging: true,
                                    ),
                                  ],
                                  ranges: <gauges.GaugeRange>[
                                    gauges.GaugeRange(
                                      startWidth: 30,
                                      endWidth: 30,
                                      startValue: 0,
                                      endValue: controller
                                          .nutritionalStatsModel.result!.totalCalories
                                          .toDouble(),
                                      gradient: const SweepGradient(colors: [
                                        Color(0xffE13333),
                                        Color(0xffE24533),
                                        Color(0xffE35833),
                                        Color(0xffE46B33),
                                        Color(0xffE78133),
                                        Color(0xffEA9933),
                                        Color(0xffF2CB33),
                                        Color(0xffF6E333),
                                        Color(0xffFBFB33),
                                        Color(0xffFBFB33),
                                        Color(0xffFBFB33),
                                        Color(0xffFBFB33),
                                        Color(0xffFBFB33),
                                        Color(0xffD6F833),
                                        Color(0xffA9F633),
                                        Color(0xff8BF533),
                                        Color(0xff62F433),
                                        Color(0xff33F333),
                                        Color(0xff33DB33),
                                        Color(0xff33CA33),
                                      ]),
                                    ),
                                  ])
                            ],
                          ),
                          Positioned(
                            top: 0.0,
                            bottom: 40.0,
                            right: 0.0,
                            left: 0.0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                controller.nutritionalStatsModel.result!.caloriesRemaining
                                    .toString(),
                                style:
                                    CustomTextStyles.medium(fontSize: 65.0, fontColor: themeGreen),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50.0,
                            bottom: 0.0,
                            right: 0.0,
                            left: 0.0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "calories remaining ",
                                style: CustomTextStyles.normal(
                                    fontSize: 18.0, fontColor: colorGreyText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              controller.nutritionalStatsModel.result!.totalCalories.toString(),
                              style: CustomTextStyles.medium(
                                  fontSize: 28.0, fontColor: const Color(0xff65696E)),
                            ),
                            Text(
                              'total cal.',
                              style: CustomTextStyles.normal(
                                  fontSize: 10.0, fontColor: const Color(0xff8A9099)),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 2,
                          color: const Color(0xffE8E9EB),
                        ),
                        Column(
                          children: [
                            Text(
                              controller.nutritionalStatsModel.result!.consumedCalories.toString(),
                              style: CustomTextStyles.medium(
                                  fontSize: 28.0, fontColor: const Color(0xff65696E)),
                            ),
                            Text(
                              'cals. consumed',
                              style: CustomTextStyles.normal(
                                  fontSize: 10.0, fontColor: const Color(0xff8A9099)),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 2,
                          color: const Color(0xffE8E9EB),
                        ),
                        Column(
                          children: [
                            Text(
                              controller.nutritionalStatsModel.result!.caloriesRemaining.toString(),
                              style: CustomTextStyles.medium(
                                  fontSize: 28.0, fontColor: const Color(0xff65696E)),
                            ),
                            Text(
                              'cals. remaining',
                              style: CustomTextStyles.normal(
                                  fontSize: 10.0, fontColor: const Color(0xff8A9099)),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  totalDurationView() {
    return SizedBox(
      height: Get.height * 0.18,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: Get.width * 0.35,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(int.parse(
                      controller.distanceModel.result![index].bodyColour.substring(1, 7),
                      radix: 16) +
                  0xFF000000),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                    imageUrl: controller.distanceModel.result![index].imageUrl,
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                    memCacheHeight: 100,
                    memCacheWidth: 100,
                    alignment: Alignment.center,
                    placeholder: (context, url) => Container(
                          color: Colors.transparent,
                          child: const CircularProgressIndicator(
                            color: themeGreen,
                          ),
                        ),
                    errorWidget: (context, url, error) => const Icon(Icons.error)),
                const SizedBox(height: 5),
                Text(
                  controller.distanceModel.result![index].displayName,
                  style: CustomTextStyles.semiBold(
                    fontSize: 16.0,
                    fontColor: Color(int.parse(
                            controller.distanceModel.result![index].nameColour.substring(1, 7),
                            radix: 16) +
                        0xFF000000),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  "${controller.distanceModel.result![index].percentage}%",
                  style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: controller.distanceModel.result!.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
          );
        },
      ),
    );
  }
}
