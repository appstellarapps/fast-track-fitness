import 'package:fasttrackfitness/app/core/helper/colors.dart';

import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/auth/training_type/views/training_type_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../data/training_type_model.dart';
import '../controllers/training_type_controller.dart';

class TrainingTypeView extends GetView<TrainingTypeController> with TrainingTypeComponents {
  TrainingTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppBar.appBar(
        title: "Select Training Type",
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : Container(
                color: themeWhite,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        top: 20.0,
                      ),
                      child: TextField(
                        controller: controller.searchController,
                        onChanged: (searchText) {
                          controller.isTyping.value = true;
                          if (searchText.isEmpty) {
                            controller.getTrainingType();
                          } else {
                            controller.onSearchDebouncer
                                .debounce(() => controller.getTrainingType());
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Search by training type",
                          hintStyle: CustomTextStyles.normal(
                              fontSize: 16.0, fontColor: const Color(0xffCDCDCD)),
                          border: searchCommonBorderStyle,
                          enabledBorder: searchCommonBorderStyle,
                          disabledBorder: searchCommonBorderStyle,
                          focusedBorder: searchCommonBorderStyle,
                          focusedErrorBorder: searchCommonBorderStyle,
                          errorBorder: searchCommonBorderStyle,
                          contentPadding: const EdgeInsets.only(left: 6.0, right: 6.0),
                          suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 12.0),
                              child: // myIcon is a 48px-wide widget.
                                  SvgPicture.asset(
                                ImageResourceSvg.search1,
                              )),
                          suffixIconConstraints: const BoxConstraints(maxHeight: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => controller.isTyping.value
                            ? const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(color: themeBlack))
                            : controller.trainingTypes.isEmpty
                                ? noDataFound()
                                : ListView.separated(
                                    padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 20.0,
                                    ),
                                    itemBuilder: (context, index) {
                                      return trainingTypeItem(controller.trainingTypes[index]);
                                    },
                                    separatorBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        child: Divider(height: 2.0, color: grey50),
                                      );
                                    },
                                    itemCount: controller.trainingTypes.length,
                                  ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 14.0,
                        bottom: 14.0,
                      ),
                      child: ButtonRegular(
                        onPress: () {
                          List<TrainingTypes> selectedTrainingTypes = [];
                          bool hasSelected = false;
                          for (var element in controller.trainingTypes) {
                            if (element.isSelected.value) {
                              hasSelected = true;
                              selectedTrainingTypes.add(element);
                            }
                          }
                          if (hasSelected) {
                            Get.back(result: selectedTrainingTypes);
                          } else {
                            showSnackBar(
                                title: "Error", message: "Please select type at least one");
                          }
                        },
                        buttonText: "SUBMIT",
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
