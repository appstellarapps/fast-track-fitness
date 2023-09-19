import 'package:fasttrackfitness/app/modules/trainee/nutrition_library/views/nutrition_library_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/nutrition_library_controller.dart';

class NutritionLibraryView extends GetView<NutritionLibraryController>
    with NutritionLibraryComponents {
  NutritionLibraryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helper().hideKeyBoard(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            // SessionImpl.userSelectedExerciseList.clear();
            return true;
          },
          child: Scaffold(
            bottomSheet: Obx(
              () => controller.isLoading.value
                  ? const SizedBox.shrink()
                  : AppStorage.mainCustomMealList.isNotEmpty ||
                          AppStorage.preMadeMealLIst.isNotEmpty
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20, top: 20),
                          child: ButtonRegular(
                            buttonText: "Done",
                            onPress: () {
                              Get.back();
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
            ),
            backgroundColor: themeWhite,
            appBar: ScaffoldAppBar.appBar(
              title: controller.tag == 0
                  ? "Select Custom Recipe"
                  : controller.tag == 1
                      ? "Select Pre Made Recipe"
                      : "",
              onBackPressed: () {
                // SessionImpl.userSelectedExerciseList.clear();
                Get.back();
              },
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: TextField(
                      controller: controller.searchCtr,
                      onChanged: (searchText) {
                        controller.isTyping.value = true;
                        controller.page = 0;
                        controller.customMealList.clear();
                        controller.preMadeMealList.clear();
                        if (searchText.isNotEmpty) {
                          controller.onSearchChanged(searchText);
                        } else {
                          Helper().hideKeyBoard();
                          controller.isTyping.value = false;
                          controller.getMealLibrary();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search by meal type",
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
                Obx(() => checkView())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
