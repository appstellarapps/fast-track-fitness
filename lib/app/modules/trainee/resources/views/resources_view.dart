import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/modules/trainee/resources/views/resources_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/resources_controller.dart';

class ResourcesView extends GetView<ResourcesController> with ResourcesComponents {
  ResourcesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResourcesView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
            tabs(),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Obx(
                  () => TextField(
                    controller: controller.searchCtr,
                    onChanged: (searchText) {
                      controller.isTyping.value = true;
                      controller.exerciseList.clear();
                      controller.preMadeMealList.clear();
                      if (searchText.isNotEmpty) {
                        controller.onSearchChanged(searchText);
                      } else {
                        Helper().hideKeyBoard();
                        controller.isTyping.value = false;
                        if (controller.selectTabIndex.value == 0) {
                          controller.getExerciseLibrary();
                        } else {
                          controller.getMealLibrary();
                        }
                      }
                    },
                    decoration: InputDecoration(
                      hintText: controller.selectTabIndex.value == 0
                          ? "Search Exercise"
                          : "Search Nutrition",
                      hintStyle: CustomTextStyles.normal(
                          fontSize: 14.0, fontColor: const Color(0xffCDCDCD)),
                      border: searchCommonBorderStyle,
                      enabledBorder: searchCommonBorderStyle,
                      disabledBorder: searchCommonBorderStyle,
                      focusedBorder: searchCommonBorderStyle,
                      focusedErrorBorder: searchCommonBorderStyle,
                      errorBorder: searchCommonBorderStyle,
                      contentPadding:
                          const EdgeInsets.only(left: 6.0, right: 6.0, top: 2.0, bottom: 2.0),
                      suffixIcon: Padding(
                        padding:
                            const EdgeInsetsDirectional.only(start: 14.0, top: 14.0, bottom: 12),
                        child: // myIcon is a 48px-wide widget.
                            SvgPicture.asset(
                          ImageResourceSvg.searchIc,
                          color: colorGreyText,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => controller.isTyping.value
                ? const Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(color: themeBlack)),
                  )
                : controller.isLoading.value
                    ? const SizedBox.shrink()
                    : controller.selectTabIndex.value == 0
                        ? controller.exerciseList.isEmpty
                            ? Expanded(child: noDataFound())
                            : mainExerciseListView()
                        : controller.preMadeMealList.isNotEmpty
                            ? preMadeMealListView()
                            : Expanded(child: noDataFound()))
          ],
        ),
      ),
    );
  }
}
