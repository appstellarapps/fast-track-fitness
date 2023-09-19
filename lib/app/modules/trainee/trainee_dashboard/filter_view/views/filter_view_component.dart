import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/trainee_dashboard/filter_view/controllers/filter_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/common_widget/custom_app_widget.dart';

mixin FilterViewComponents {
  var controller = Get.put(FilterViewController());

  floatButton() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffE5E5E5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: InkWell(
            onTap: () {
              trainingTypeId.clear();
              ratings.clear();
              trainingModeId.clear();
              shifting = "";
              filterRange.value = 50;
              filterTrainingTypesIds.clear();
              filterRatings.clear();
              filterTrainingModeIds.clear();
              shiftingFilter.clear();
              kidFriendlyFilter.clear();
              kidFriendly = "All";
              filterShifting.value = "";
              filtersList.clear();
              initialRange.value = 50.0;

              Get.back(
                  result: [50, trainingTypeId, ratings, trainingModeId, shifting, kidFriendly]);
            },
            child: Container(
              height: 46,
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xffE5E5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(10),
                ),
              ),
              child: SafeArea(
                child: Text("Reset All",
                    style: CustomTextStyles.semiBold(fontColor: themeGrey, fontSize: 16.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              trainingTypeId.clear();
              ratings.clear();
              trainingModeId.clear();
              shifting = "";
              filterRange.value = initialRange.value.toInt();
              filterTrainingTypesIds.clear();
              filterRatings.clear();
              filterTrainingModeIds.clear();
              filterShifting.value = "";
              if (trainingTypes.isNotEmpty) {
                for (int i = 0; i < trainingTypes.length; i++) {
                  if (i != 0 && trainingTypes[i].isSelected.value) {
                    trainingTypeId.add(trainingTypes[i].id);
                    filterTrainingTypesIds.add(trainingTypes[i].id);
                  }
                }
              }
              if (ratingFiltersList.isNotEmpty) {
                for (int i = 0; i < ratingFiltersList.length; i++) {
                  if (i != 0 && ratingFiltersList[i].isSelected.value) {
                    ratings.add(ratingFiltersList[i].title);
                    filterRatings.add(ratingFiltersList[i].title);
                  }
                }
              }
              if (trainingModes.isNotEmpty) {
                for (int i = 0; i < trainingModes.length; i++) {
                  if (i != 0 && trainingModes[i].isSelected.value) {
                    trainingModeId.add(trainingModes[i].id);
                    filterTrainingModeIds.add(trainingModes[i].id);
                  }
                }
              }

              if (shiftingFilter.isNotEmpty) {
                for (int i = 0; i < shiftingFilter.length; i++) {
                  if (shiftingFilter[i].isSelected.value) {
                    // filterShifting.value = shiftingFilter.value[i].title!;

                    shifting = shiftingFilter[i].id!;
                    filterShifting.value = shiftingFilter[i].id!;
                    if (i == 0) break;

                    // shifting.add(shiftingFilter[i].id!);
                    // filterShifting.add(shiftingFilter[i].id!);

                    /*if (shiftingFilter.value[i].title == "Morning Shift") {
                      shifting = "0";
                    } else {
                      shifting = "1";
                    }*/
                  }
                }
              }

              if (kidFriendlyFilter.isNotEmpty) {
                for (int i = 0; i < kidFriendlyFilter.length; i++) {
                  if (kidFriendlyFilter[i].isSelected.value) {
                    if (kidFriendlyFilter[i].title == "Yes") {
                      kidFriendly = '1';
                    } else {
                      kidFriendly = '0';
                    }
                  }
                }
              }

              Get.back(result: [
                initialRange.value.toInt(),
                trainingTypeId,
                ratings,
                trainingModeId,
                shifting,
                kidFriendly
              ]);
            },
            child: Container(
              alignment: Alignment.center,
              height: 46,
              decoration: const BoxDecoration(
                color: themeGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: SafeArea(
                child: Text(
                  "Apply",
                  style: CustomTextStyles.semiBold(
                    fontSize: 16.0,
                    fontColor: themeBlack,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  commonListItem({title, bool isSelected = false}) {
    return Row(
      children: [
        SvgPicture.asset(isSelected ? ImageResourceSvg.selectIc : ImageResourceSvg.unSelectIc),
        const SizedBox(width: 10.0),
        Expanded(
            child: Text(
          title,
          style: CustomTextStyles.semiBold(
            fontSize: 14.0,
            fontColor: themeBlack,
          ),
        ))
      ],
    );
  }

  trainingTypeList() {
    return Obx(
      () => trainingTypes.isEmpty
          ? noDataFound()
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 14.0, bottom: 14.0, left: 10.0, right: 10.0),
              itemBuilder: (context, index) {
                return Obx(() => InkWell(
                    onTap: () {
                      if (index == 0) {
                        trainingTypes[index].isSelected.value =
                            !trainingTypes[index].isSelected.value;
                        for (int i = 0; i < trainingTypes.length; i++) {
                          trainingTypes[i].isSelected.value = trainingTypes[index].isSelected.value;
                        }
                      } else {
                        trainingTypes[index].isSelected.value =
                            !trainingTypes[index].isSelected.value;

                        var isAllSelect = true;
                        for (int i = 0; i < trainingTypes.length; i++) {
                          if (i != 0 && !trainingTypes[i].isSelected.value) {
                            isAllSelect = false;
                            break;
                          }
                        }
                        trainingTypes[0].isSelected.value = isAllSelect;
                      }
                    },
                    child: commonListItem(
                        title: trainingTypes[index].title,
                        isSelected: trainingTypes[index].isSelected.value)));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 14.0);
              },
              itemCount: trainingTypes.length),
    );
  }

  ratingsList() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 14.0, bottom: 14.0, left: 10.0, right: 10.0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                ratingFiltersList[index].isSelected.value =
                    !ratingFiltersList[index].isSelected.value;
                for (int i = 0; i < ratingFiltersList.length; i++) {
                  ratingFiltersList[i].isSelected.value = ratingFiltersList[index].isSelected.value;
                }
              } else {
                ratingFiltersList[index].isSelected.value =
                    !ratingFiltersList[index].isSelected.value;

                var isAllSelect = true;
                for (int i = 0; i < ratingFiltersList.length; i++) {
                  if (i != 0 && !ratingFiltersList[i].isSelected.value) {
                    isAllSelect = false;
                    break;
                  }
                }
                ratingFiltersList[0].isSelected.value = isAllSelect;
              }
            },
            child: Obx(
              () => Row(
                children: [
                  SvgPicture.asset(ratingFiltersList[index].isSelected.value
                      ? ImageResourceSvg.selectIc
                      : ImageResourceSvg.unSelectIc),
                  const SizedBox(width: 10.0),
                  Text(
                    ratingFiltersList[index].title!,
                    style: CustomTextStyles.semiBold(
                      fontSize: 14.0,
                      fontColor: themeBlack,
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Visibility(
                      visible: index == 0 ? false : true,
                      child: commonRatingBar(
                        ignoreGestures: true,
                        initialRating:
                            double.parse(index != 0 ? ratingFiltersList[index].title : "0"),
                      ))
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14.0);
        },
        itemCount: ratingFiltersList.length);
  }

  timingList() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 14.0, bottom: 14.0, left: 10.0, right: 10.0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              /*for (var element in shiftingFilter.value) {
                if (element.isSelected.value) {
                  element.isSelected.value = false;
                }
              }
              shiftingFilter.value[index].isSelected.value = !shiftingFilter.value[index].isSelected.value;*/

              if (index == 0) {
                shiftingFilter[index].isSelected.value = !shiftingFilter[index].isSelected.value;
                for (int i = 0; i < shiftingFilter.length; i++) {
                  shiftingFilter[i].isSelected.value = shiftingFilter[index].isSelected.value;
                }
              } else {
                shiftingFilter[index].isSelected.value = !shiftingFilter[index].isSelected.value;

                var isAllSelect = true;
                for (int i = 0; i < shiftingFilter.length; i++) {
                  if (i != 0 && !shiftingFilter[i].isSelected.value) {
                    isAllSelect = false;
                    break;
                  }
                }
                shiftingFilter[0].isSelected.value = isAllSelect;
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => SvgPicture.asset(shiftingFilter[index].isSelected.value
                    ? ImageResourceSvg.selectIc
                    : ImageResourceSvg.unSelectIc)),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shiftingFilter[index].title!,
                        style: CustomTextStyles.semiBold(
                          fontSize: 14.0,
                          fontColor: themeBlack,
                        ),
                      ),
                      /*const SizedBox(height: 4.0),
                      Text(
                        shiftingFilter.value[index].timing!,
                        style: CustomTextStyles.normal(
                          fontSize: 12.0,
                          fontColor: themeBlack,
                        ),
                      )*/
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14.0);
        },
        itemCount: shiftingFilter.length);
  }

  trainingModeList() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 14.0, bottom: 14.0, left: 10.0, right: 10.0),
        itemBuilder: (context, index) {
          return Obx(() => InkWell(
              onTap: () {
                if (index == 0) {
                  trainingModes[index].isSelected.value = !trainingModes[index].isSelected.value;
                  for (int i = 0; i < trainingModes.length; i++) {
                    trainingModes[i].isSelected.value = trainingModes[index].isSelected.value;
                  }
                } else {
                  trainingModes[index].isSelected.value = !trainingModes[index].isSelected.value;

                  var isAllSelect = true;
                  for (int i = 0; i < trainingModes.length; i++) {
                    if (i != 0 && !trainingModes[i].isSelected.value) {
                      isAllSelect = false;
                      break;
                    }
                  }
                  trainingModes[0].isSelected.value = isAllSelect;
                }
              },
              child: commonListItem(
                  title: trainingModes[index].title,
                  isSelected: trainingModes[index].isSelected.value)));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14.0);
        },
        itemCount: trainingModes.length);
  }

  kidFriendlyList() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 14.0, bottom: 14.0, left: 10.0, right: 10.0),
        itemBuilder: (context, index) {
          return Obx(() => InkWell(
              onTap: () {
                for (int i = 0; i < kidFriendlyFilter.length; i++) {
                  kidFriendlyFilter[i].isSelected.value = false;
                }
                kidFriendlyFilter[index].isSelected.value = true;
              },
              child: commonListItem(
                  title: kidFriendlyFilter[index].title,
                  isSelected: kidFriendlyFilter[index].isSelected.value)));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14.0);
        },
        itemCount: kidFriendlyFilter.length);
  }
}
