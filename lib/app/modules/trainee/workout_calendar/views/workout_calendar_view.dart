import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/modules/trainee/workout_calendar/views/workout_calendar_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_print.dart';
import '../../../../core/helper/images_resources.dart';
import '../controllers/workout_calendar_controller.dart';

class WorkoutCalendarView extends GetView<WorkoutCalendarController>
    with MyWorkoutCalendarComponents {
  WorkoutCalendarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: themeGreen,
          onPressed: () {
            printLog(controller.tag.toString());
            if (controller.tag == 1) {
              createMealDialog();
            } else {
              createWorkoutDialog();
            }
          },
          child: SvgPicture.asset(ImageResourceSvg.plus)),
      backgroundColor: themeWhite,
      appBar: ScaffoldAppBar.appBar(
          title: controller.tag == 0 ? "My Workout Calendar" : "My Meal Calendar"),
      body: Column(
        children: [
          weekdayListView(),
          Obx(
            () => Expanded(
              child: controller.isLoading.value
                  ? const SizedBox.shrink()
                  : controller.workoutList.isEmpty
                      ? noDataFound()
                      : ListView.separated(
                          controller: controller.scrollController,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == controller.workoutList.length - 1 &&
                                controller.haseMore.value) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: themeGreen,
                                      )),
                                ),
                              );
                            }
                            return planeView(controller.workoutList[index], index);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox.shrink();
                          },
                          itemCount: controller.workoutList.length,
                        ),
            ),
          )
        ],
      ),
    );
  }
}
