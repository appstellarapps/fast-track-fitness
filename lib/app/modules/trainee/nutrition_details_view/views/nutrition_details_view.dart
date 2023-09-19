import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/nutrition__details_view_controller.dart';
import 'nutrition_details_components.dart';

class NutritionDetailsViewView extends GetView<NutritionDetailsViewController>
    with NutritionDetailsComponents {
  NutritionDetailsViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeWhite,
        appBar: ScaffoldAppBar.appBar(title: "Nutrition Plane Details "),
        body: Obx(
          () => ListView.separated(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              controller: controller.scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == controller.workoutDetailsList.length - 1 &&
                    controller.haseMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
                    ),
                  );
                }
                return mealsListView(index);
              },
              separatorBuilder: (context, index) {
                return const SizedBox.shrink();
              },
              itemCount: controller.workoutDetailsList.length),
        ));
  }
}
