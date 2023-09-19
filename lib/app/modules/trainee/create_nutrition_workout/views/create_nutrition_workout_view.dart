
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/keyboard_avoider.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/create_nutrition_workout_controller.dart';
import 'create_nutrition_components.dart';

class CreateNutritionWorkoutView extends GetView<CreateNutritionWorkoutController>
    with CreateNutritionComponents {
  CreateNutritionWorkoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helper().hideKeyBoard(),
      child: WillPopScope(
        onWillPop: () async {
          AppStorage.mainCustomMealList.clear();
          AppStorage.preMadeMealLIst.clear();

          return true;
        },
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: controller.isViewOnly
                ? const SizedBox.shrink()
                : Obx(
                    () => Padding(
                        padding: const EdgeInsets.only(left: 40, right: 10, bottom: 00),
                        child: checkView()),
                  ),
            resizeToAvoidBottomInset: false,
            backgroundColor: themeWhite,
            appBar: ScaffoldAppBar.appBar(
                title: controller.checkAppBarTitle(),
                onBackPressed: () {
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
                    bottom: controller.isViewOnly ? 0.0 : Get.height * 0.15),
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
                                enabledTextField: controller.isViewOnly ? false : true,
                                key: controller.workoutNameKey,
                                hintText: "Enter meal title",
                                errorMsg: "Please enter meal title",
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
                              CustomTextFormField(
                                maxLines: 5,
                                maxLength: 200,
                                enabledTextField: controller.isViewOnly ? false : true,
                                key: controller.desKey,
                                hintText: "Enter description",
                                errorMsg: "Please enter description",
                                controller: controller.descCrt,
                                hasBorder: false,
                                borderColor: borderColor,
                                fontColor: themeBlack,
                                validateTypes: ValidateTypes.noValidation,
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
                              AppStorage.mainCustomMealList.isNotEmpty
                                  ? customMealListView()
                                  : AppStorage.preMadeMealLIst.isNotEmpty
                                      ? preMadeMealListView()
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
