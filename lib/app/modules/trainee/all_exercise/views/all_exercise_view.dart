import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/modules/trainee/all_exercise/views/all_exercise_view_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/all_exercise_controller.dart';

class AllExerciseView extends GetView<AllExerciseController> with AllExerciseViewComponents {
  AllExerciseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeWhite,
        appBar: ScaffoldAppBar.appBar(
          title: controller.isExercise == 0 ? "Exercise" : "Meal",
        ),
        body: Obx(() => Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  controller.mainCategoryTitle.value,
                  style: CustomTextStyles.bold(
                      fontSize: 18.0, fontColor: themeBlack),
                ),
              ),
              Expanded(child: checkView()),
            ],
          ),
        ))
      ),
    );
  }
}
