import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/workout_details/views/workout_details_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/workout_details_controller.dart';

class WorkoutDetailsView extends GetView<WorkoutDetailsController> with WorkoutDetailsComponents {
  WorkoutDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppBar.appBar(title: DateFormat('dd MMM yyyy').format(controller.title)),
      body: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : controller.workoutExerciseList.isEmpty
                ? noDataFound()
                : Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          controller.workoutDetail.result!.workout.name,
                          style: CustomTextStyles.bold(fontSize: 20.0, fontColor: themeBlack),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, mainIndex) {
                              return exerciseListView(mainIndex);
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 25,
                              );
                            },
                            itemCount: controller.workoutExerciseList.length,
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
