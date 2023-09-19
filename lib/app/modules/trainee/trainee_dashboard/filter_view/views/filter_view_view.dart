import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../core/helper/images_resources.dart';
import '../../../../../core/helper/text_style.dart';
import '../controllers/filter_view_controller.dart';
import 'filter_view_component.dart';

class FilterViewView extends GetView<FilterViewController> with FilterViewComponents {
  FilterViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeBlack,
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: Container(
        color: themeWhite,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 18.0,
              bottom: 18.0,
            ),
            decoration: const BoxDecoration(
              color: themeBlack,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14.0),
                bottomRight: Radius.circular(14.0),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Text(
                          "Filter",
                          style: CustomTextStyles.semiBold(
                            fontSize: 18.0,
                            fontColor: themeWhite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          ImageResourceSvg.closeIcWithCircle,
                          color: themeWhite,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 22.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Set Range",
                        style: CustomTextStyles.semiBold(
                          fontColor: themeWhite,
                          fontSize: 16.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: themeWhite),
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                        child: Obx(
                          () => Text(
                            "${initialRange.value.toInt()} km",
                            style: CustomTextStyles.normal(
                              fontSize: 14.0,
                              fontColor: themeWhite,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 22.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "50 km",
                        style: CustomTextStyles.normal(fontSize: 14.0, fontColor: themeWhite),
                      ),
                      Obx(
                        () => Expanded(
                          child: SizedBox(
                            height: 10.0,
                            child: SfSlider(
                              min: 50.0,
                              max: 160,
                              labelPlacement: LabelPlacement.onTicks,
                              interval: 1.0,
                              showTicks: false,
                              showDividers: false,
                              showLabels: false,
                              enableTooltip: false,
                              thumbIcon: SvgPicture.asset(ImageResourceSvg.sliderThumbIc),
                              minorTicksPerInterval: 1,
                              activeColor: white50,
                              inactiveColor: white50,
                              value: initialRange.value,
                              onChanged: (value) {
                                // print(value.toString());
                                initialRange.value = double.parse(value.toString());
                              },
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "160 km",
                        style: CustomTextStyles.normal(fontSize: 14.0, fontColor: themeWhite),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 18.0,
                  bottom: 60,
                ),
                itemBuilder: (context, index) {
                  return Obx(
                    () => Container(
                        decoration: BoxDecoration(
                            color: inputGrey, borderRadius: BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(children: [
                          InkWell(
                            onTap: () {
                              filtersList[index].isExpand.value =
                                  !filtersList[index].isExpand.value;
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      filtersList[index].title!,
                                      style: CustomTextStyles.semiBold(
                                          fontSize: 16.0, fontColor: themeBlack),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    filtersList[index].isExpand.value
                                        ? ImageResourceSvg.upArrowIc
                                        : ImageResourceSvg.downArrowIc,
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (filtersList[index].isExpand.value) ...[
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Divider(height: 1.0, color: borderColor),
                            ),
                            if (index == 0) ...[trainingTypeList()],
                            if (index == 1) ...[ratingsList()],
                            if (index == 2) ...[timingList()],
                            if (index == 3) ...[trainingModeList()],
                            if (index == 4) ...[kidFriendlyList()],
                          ]
                        ])),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: filtersList.length,
              ),
            ),
          )
        ]),
      ),
      floatingActionButton: floatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
