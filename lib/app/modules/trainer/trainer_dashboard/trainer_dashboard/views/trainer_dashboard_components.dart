import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/helper/images_resources.dart';
import '../../../../../core/helper/text_style.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/trainer_dashboard_controller.dart';

mixin TrainerDashboardComponents {
  var controller = Get.put(TrainerDashboardController());
  var searchCommonBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xffE6E6E6),
      ));

  dashboardList() {
    return ListView.separated(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 120,
          bottom: 14.0,
        ),
        itemBuilder: (context, index) {
          return Obx(
            () => commonListItem(
              schedules: index == 0
                  ? controller.trainerDashboardModel.result!.booking.todayScheduledCount.value
                  : index == 1
                      ? controller.trainerDashboardModel.result!.exercise.todayScheduledCount.value
                      : controller
                          .trainerDashboardModel.result!.nutrition.todayScheduledCount.value,
              trainees: index == 0
                  ? controller.trainerDashboardModel.result!.booking.traineeCount
                  : controller.trainerDashboardModel.result!.nutrition.traineeCount,
              title: index == 0
                  ? "Bookings"
                  : index == 1
                      ? "Exercise Diary"
                      : "Nutritional Diary",
              bgImage: index == 0
                  ? ImageResourcePng.bookingBg
                  : index == 1
                      ? ImageResourcePng.exerciseBg
                      : ImageResourcePng.nutritionalBg,
              onPress: () {
                if (index == 0) {
                  Get.toNamed(Routes.MY_BOOKING);
                } else if (index == 1) {
                  Get.toNamed(Routes.EXERCISE_DIARY, arguments: 0);
                } else if (index == 2) {
                  Get.toNamed(Routes.EXERCISE_DIARY, arguments: 1);
                }
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10.0);
        },
        itemCount: 3);
  }

  commonListItem({
    schedules,
    trainees,
    title,
    bgImage,
    Function? onPress,
  }) {
    return InkWell(
      onTap: () {
        if (onPress != null) {
          onPress();
        }
      },
      child: Container(
        height: 140,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(ImageResourceSvg.calendarRound),
                    const SizedBox(width: 6.0),
                    Text(
                      "$schedules Scheduled Today",
                      style: CustomTextStyles.semiBold(
                        fontSize: 12.0,
                        fontColor: themeWhite,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    SvgPicture.asset(ImageResourceSvg.dashProfile),
                    const SizedBox(width: 6.0),
                    Text(
                      "$trainees Trainee",
                      style: CustomTextStyles.semiBold(
                        fontSize: 11.0,
                        fontColor: themeWhite,
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$title  ",
                  style: CustomTextStyles.bold(
                    fontSize: 16.0,
                    fontColor: themeWhite,
                  ),
                ),
                SvgPicture.asset(ImageResourceSvg.forward),
              ],
            )
          ],
        ),
      ),
    );
  }

  commonBottomContainer({icon, title, onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: themeWhite,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffE5E5E5).withOpacity(0.50),
                  spreadRadius: 1.0,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, -5.0),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              Text(
                " $title",
                style: CustomTextStyles.semiBold(
                  fontColor: themeBlack,
                  fontSize: 13.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
