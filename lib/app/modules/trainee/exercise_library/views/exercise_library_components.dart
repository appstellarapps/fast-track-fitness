import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/exercise_library/controllers/exercise_library_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../data/exercise_library_model.dart';
import '../../../../routes/app_pages.dart';

mixin ExerciseLibraryComponents {
  var controller = Get.put(ExerciseLibraryController());
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
    } else if (controller.exerciseList.isNotEmpty) {
      return mainExerciseListView();
    } else {
      return Expanded(child: noDataFound());
    }
  }

  mainExerciseListView() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 100.0),
        controller: controller.scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == controller.exerciseList.length - 1 && controller.haseMore.value) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
              ),
            );
          }
          return mainExerciseView(index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox.shrink();
        },
        itemCount: controller.exerciseList.length,
      ),
    );
  }

  mainExerciseView(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.exerciseList[index].title,
                  style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: colorGreyText),
                ),
              ),
              controller.exerciseList[index].descendantsCount > 5
                  ? InkWell(
                      onTap: () {
                        Get.toNamed(Routes.ALL_EXERCISE, arguments: [controller.exerciseList[index].id, controller.tag, 0, false]);
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
        const SizedBox(height: 20),
        subExerciseListView(controller.exerciseList[index])
      ],
    );
  }

  subExerciseListView(Exercise subExercise) {
    return SizedBox(
      height: Get.height * 0.30,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return subExerciseView(subExercise, index);
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
          );
        },
        itemCount: subExercise.descendants.length,
      ),
    );
  }

  subExerciseView(Exercise subExercise, index) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.EXERCISE_DETAILS, arguments: [subExercise.descendants[index].id, controller.tag, 0, false]);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: inputGrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            exerciseNetworkImage(networkImage: subExercise.descendants[index].imageUrl, width: Get.width * 0.6, height: Get.height * 0.20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subExercise.descendants[index].title,
                    style: CustomTextStyles.bold(fontSize: 17.0, fontColor: themeBlack),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        ImageResourceSvg.redClock,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        " ${controller.checkTime(subExercise.descendants[index].totalResourcesDuration)}",
                        style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: colorGreyText),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        " | ${subExercise.descendants[index].exerciseCount} Exercises",
                        style: CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
