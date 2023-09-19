import 'package:fasttrackfitness/app/modules/trainee/workout_details/controllers/workout_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/custom_method.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../routes/app_pages.dart';

mixin WorkoutDetailsComponents {
  var controller = Get.put(WorkoutDetailsController());

  exerciseListView(mainIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Exercise ${mainIndex + 1}",
          style: CustomTextStyles.bold(fontSize: 16.0, fontColor: colorGreyText),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Stack(
              children: [
                mediaNetworkImage(
                    networkImage: controller.workoutExerciseList[mainIndex].imageUrl,
                    width: Get.width * 0.24,
                    height: Get.height * 0.12,
                    borderRadius: 20.0,
                    avatarRadius: 20.0),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.VIDEO_PLAYER, arguments: [
                        controller.workoutExerciseList[mainIndex].videoUrl,
                        controller.workoutExerciseList[mainIndex].title,
                        '',
                      ]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: SvgPicture.asset(
                        ImageResourceSvg.icPlayBlack,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.workoutExerciseList[mainIndex].title,
                    style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    controller.workoutExerciseList[mainIndex].description,
                    style: CustomTextStyles.normal(fontSize: 14.0, fontColor: colorGreyText),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      SvgPicture.asset(ImageResourceSvg.redClock),
                      const SizedBox(width: 10.0),
                      Text(
                        "Rest Time: ${CustomMethod.checkTime(controller.workoutExerciseList[mainIndex].restTimeMinutes)}",
                        style: CustomTextStyles.semiBold(fontSize: 11.0, fontColor: colorGreyText),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Current / Repeat Week',
          style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: colorGreyText),
        ),
        const SizedBox(height: 10),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, subIndex) {
            return setView(subIndex, mainIndex);
          },
          separatorBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
            );
          },
          itemCount: controller.workoutExerciseList[mainIndex].workoutExcerciseSetsDaily.length,
        ),
      ],
    );
  }

  setView(subIndex, mainIndex) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: colorGreyText),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: themeBlack),
            child: Text(
              "${subIndex + 1}",
              style: CustomTextStyles.normal(fontSize: 15.0, fontColor: themeWhite),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              Text(
                controller.workoutExerciseList[mainIndex].workoutExcerciseSetsDaily[subIndex].reps
                    .toString(),
                style: CustomTextStyles.medium(fontSize: 16.0, fontColor: themeBlack),
                textAlign: TextAlign.center,
              ),
              Text(
                "Reps",
                style: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            height: 40,
            color: colorGreyText,
            width: 1,
          ),
          Column(
            children: [
              Text(
                controller.workoutExerciseList[mainIndex].workoutExcerciseSetsDaily[subIndex].weight
                    .toString(),
                style: CustomTextStyles.medium(fontSize: 16.0, fontColor: themeBlack),
                textAlign: TextAlign.center,
              ),
              Text(
                "Kg",
                style: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            height: 40,
            color: colorGreyText,
            width: 1,
          ),
          Column(
            children: [
              Text(
                controller
                    .formatDuration(controller.workoutExerciseList[mainIndex]
                        .workoutExcerciseSetsDaily[subIndex].workoutSeconds)
                    .toString(),
                style: CustomTextStyles.medium(fontSize: 16.0, fontColor: themeBlack),
                textAlign: TextAlign.center,
              ),
              Text(
                "min : sec",
                style: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
