import 'package:fasttrackfitness/app/core/helper/app_storage.dart';

import 'package:fasttrackfitness/app/core/helper/helper.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/data/training_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/keyboard_avoider.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/create_workout_controller.dart';
import 'create_workout_components.dart';

class CreateWorkoutView extends GetView<CreateWorkoutController> with CreateWorkoutComponents {
  CreateWorkoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helper().hideKeyBoard(),
      child: WillPopScope(
        onWillPop: () async {
          AppStorage.userSelectedExerciseList.clear();
          AppStorage.mainCustomMealList.clear();
          AppStorage.preMadeMealLIst.clear();

          return true;
        },
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: !controller.isOnlyView
                ? Obx(
                    () => Padding(
                        padding: const EdgeInsets.only(left: 40, right: 10, bottom: 00),
                        child: checkView()),
                  )
                : const SizedBox.shrink(),
            resizeToAvoidBottomInset: false,
            backgroundColor: themeWhite,
            appBar: ScaffoldAppBar.appBar(
                title: controller.checkAppBarTitle(),
                onBackPressed: () {
                  AppStorage.userSelectedExerciseList.clear();
                  AppStorage.mainCustomMealList.clear();
                  AppStorage.preMadeMealLIst.clear();

                  Get.back();
                }),
            body: Obx(
              () => Padding(
                padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 20.0,
                    bottom: controller.isOnlyView ? 0.0 : Get.height * 0.15),
                child: Column(
                  children: [
                    Expanded(
                      child: KeyboardAvoider(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextFormField(
                                maxLength: 50,
                                enabledTextField: controller.isOnlyView ? false : true,
                                key: controller.workoutNameKey,
                                hintText: "Enter workout title",
                                errorMsg: "Please enter workout title",
                                controller: controller.workoutNameCrt,
                                hasBorder: false,
                                borderColor: borderColor,
                                fontColor: themeBlack,
                                validateTypes: ValidateTypes.empty,
                                style: CustomTextStyles.semiBold(
                                  fontSize: 14.0,
                                  fontColor: themeBlack,
                                ),
                                hintStyle: CustomTextStyles.normal(
                                    fontSize: 12.0, fontColor: colorGreyText),
                                textInputAction: TextInputAction.done,
                                contentPadding: EdgeInsets.zero,
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Helper().hideKeyBoard();
                                        if (controller.date == "") {
                                          controller.selectDate(true);
                                        }
                                      },
                                      child: CustomTextFormField(
                                        enabledTextField: false,
                                        key: controller.startDateKey,
                                        hintText: "Start date",
                                        controller: controller.startDateCtr,
                                        hasBorder: false,
                                        borderColor: borderColor,
                                        fontColor: themeBlack,
                                        validateTypes: ValidateTypes.empty,
                                        style: CustomTextStyles.semiBold(
                                          fontSize: 14.0,
                                          fontColor: themeBlack,
                                        ),
                                        hintStyle: CustomTextStyles.normal(
                                            fontSize: 12.0, fontColor: colorGreyText),
                                        textInputAction: TextInputAction.next,
                                        contentPadding: EdgeInsets.zero,
                                        prefix: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: SvgPicture.asset(ImageResourceSvg.calendarIc),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Helper().hideKeyBoard();
                                        if (controller.date == "") {
                                          controller.selectDate(false);
                                        }
                                      },
                                      child: CustomTextFormField(
                                        enabledTextField: false,
                                        key: controller.endDateKey,
                                        hintText: "End date",
                                        controller: controller.endDateCtr,
                                        hasBorder: false,
                                        borderColor: borderColor,
                                        fontColor: themeBlack,
                                        validateTypes: ValidateTypes.empty,
                                        style: CustomTextStyles.semiBold(
                                          fontSize: 14.0,
                                          fontColor: themeBlack,
                                        ),
                                        hintStyle: CustomTextStyles.normal(
                                            fontSize: 12.0, fontColor: colorGreyText),
                                        textInputAction: TextInputAction.next,
                                        contentPadding: EdgeInsets.zero,
                                        prefix: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: SvgPicture.asset(ImageResourceSvg.calendarIc),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Obx(
                                () =>
                                    controller.trainingTypeList.isNotEmpty && !controller.isOnlyView
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                                color: colorGreyEditText,
                                                borderRadius: BorderRadius.circular(8.0)),
                                            width: Get.width,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<TrainingTypes>(
                                                value: controller.isTrainingTypeSelected.value
                                                    ? controller.trainingTypeList[
                                                        controller.selectedTypeIndex.value]
                                                    : null,
                                                hint: Text(
                                                  "Workout Type",
                                                  style: CustomTextStyles.semiBold(
                                                    fontSize: 14.0,
                                                    fontColor: colorGreyText,
                                                  ),
                                                ),
                                                onChanged: (TrainingTypes? newValue) {
                                                  if (!controller.isOnlyView) {
                                                    controller.isTrainingTypeSelected.value = true;
                                                    for (var i = 0;
                                                        i < controller.trainingTypeList.length;
                                                        i++) {
                                                      if (controller.trainingTypeList[i].id ==
                                                          newValue!.id) {
                                                        controller.selectedTypeIndex.value = i;
                                                      }
                                                    }
                                                  }
                                                },
                                                items: controller.trainingTypeList
                                                    .map((TrainingTypes object) {
                                                  return DropdownMenuItem<TrainingTypes>(
                                                    value: object,
                                                    child: Text(object.title),
                                                  );
                                                }).toList(),
                                                style: CustomTextStyles.semiBold(
                                                  fontSize: 14.0,
                                                  fontColor: themeBlack,
                                                ),
                                                // Customize the text color
                                                icon: SvgPicture.asset(ImageResourceSvg
                                                    .dropDownBlack), // Customize the dropdown icon
                                              ),
                                            ),
                                          )
                                        : controller.trainingTypeList.isNotEmpty
                                            ? Container(
                                                width: Get.width,
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 15.0),
                                                decoration: BoxDecoration(
                                                    color: colorGreyEditText,
                                                    borderRadius: BorderRadius.circular(8.0)),
                                                child: Text(
                                                  controller
                                                      .trainingTypeList[
                                                          controller.selectedTypeIndex.value]
                                                      .title,
                                                  style: CustomTextStyles.semiBold(
                                                      fontSize: 14.0, fontColor: colorGreyText),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                              ),
                              const SizedBox(height: 20.0),
                              CustomTextFormField(
                                maxLines: 5,
                                maxLength: 200,
                                enabledTextField: controller.isOnlyView ? false : true,
                                key: controller.desKey,
                                hintText: "Enter description",
                                errorMsg: "Please enter description",
                                controller: controller.descCrt,
                                hasBorder: false,
                                borderColor: borderColor,
                                fontColor: themeBlack,
                                validateTypes: ValidateTypes.empty,
                                style: CustomTextStyles.semiBold(
                                  fontSize: 14.0,
                                  fontColor: themeBlack,
                                ),
                                hintStyle: CustomTextStyles.normal(
                                    fontSize: 12.0, fontColor: colorGreyText),
                                textInputAction: TextInputAction.done,
                                contentPadding: const EdgeInsets.only(top: 10.0),
                              ),
                              const SizedBox(height: 30.0),
                              AppStorage.userSelectedExerciseList.isNotEmpty
                                  ? exerciseListView()
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 110),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
