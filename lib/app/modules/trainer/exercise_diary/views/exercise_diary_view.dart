import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/modules/trainer/exercise_diary/views/exercise_diary_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/exercise_diary_controller.dart';

class ExerciseDiaryView extends GetView<ExerciseDiaryController> with ExerciseDiaryComponents {
  ExerciseDiaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: themeWhite,
        appBar: ScaffoldAppBar.appBar(
            title: controller.isFrom == 0 ? "Exercise Diary" : "Nutritional Diary",
            onBackPressed: () {
              Get.back();
            }),
        body: Obx(
          () => controller.isLoading.value
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller.searchController,
                        onChanged: (searchText) {
                          controller.isTyping.value = true;
                          if (searchText.isNotEmpty) {
                            controller.onSearchChanged(searchText);
                          } else {
                            Helper().hideKeyBoard();
                            // controller.isTyping.value = false;
                            controller.getExerciseDiaryListAPI();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Search by user name",
                          hintStyle: CustomTextStyles.normal(
                              fontSize: 16.0, fontColor: const Color(0xffCDCDCD)),
                          border: searchCommonBorderStyle,
                          enabledBorder: searchCommonBorderStyle,
                          disabledBorder: searchCommonBorderStyle,
                          focusedBorder: searchCommonBorderStyle,
                          focusedErrorBorder: searchCommonBorderStyle,
                          errorBorder: searchCommonBorderStyle,
                          filled: true,
                          fillColor: themeWhite,
                          contentPadding: const EdgeInsets.only(left: 10.0, right: 6.0),
                          suffixIcon: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 12.0),
                            child: // myIcon is a 48px-wide widget.
                                SvgPicture.asset(
                              ImageResourceSvg.search1,
                              color: themeGrey,
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(maxHeight: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => controller.isTyping.value
                            ? const Expanded(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(color: themeBlack)),
                              )
                            : controller.exerciseDiaryList.isEmpty
                                ? Expanded(child: noDataFound())
                                : Expanded(
                                    child: ListView.separated(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                        ),
                                        itemBuilder: (context, index) {
                                          if (index == controller.exerciseDiaryList.length - 1 &&
                                              controller.haseMore.value) {
                                            return const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(
                                                child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: CircularProgressIndicator()),
                                              ),
                                            );
                                          }
                                          return searchItem(
                                              controller.exerciseDiaryList[index], index);
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 10.0);
                                        },
                                        itemCount: controller.exerciseDiaryList.length),
                                  ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
