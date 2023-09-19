import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/custom_method.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/get_training_details.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/schedule_controller.dart';

mixin ScheduleComponents {
  var controller = Get.put(ScheduleController());

  scheduleView() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomTextFormField(
            enabledTextField: false,
            key: controller.appointmentKey,
            hintText: "",
            controller: controller.appointmentCtr,
            hasBorder: false,
            borderColor: borderColor,
            fontColor: themeBlack,
            validateTypes: ValidateTypes.empty,
            style: CustomTextStyles.semiBold(
              fontSize: 14.0,
              fontColor: themeBlack,
            ),
            textInputAction: TextInputAction.next,
            contentPadding: EdgeInsets.zero,
            prefix: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(ImageResourceSvg.appointmentFile),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Text(
                "Booking No",
                style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: CustomTextFormField(
                  enabledTextField: false,
                  key: controller.bookingKey,
                  hintText: "",
                  controller: controller.bookingCtr,
                  hasBorder: false,
                  borderColor: borderColor,
                  fontColor: themeBlack,
                  validateTypes: ValidateTypes.empty,
                  style: CustomTextStyles.semiBold(
                    fontSize: 14.0,
                    fontColor: themeBlack,
                  ),
                  textInputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Obx(
            () => controller.trainingTypes.isNotEmpty &&
                    controller.action.value == 0 &&
                    controller.isTrainer == 1
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: colorGreyEditText, borderRadius: BorderRadius.circular(8.0)),
                    width: Get.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<TrainingType>(
                        value: controller.trainingTypes[controller.selectedTrainingTypeIndex.value],
                        hint: Text(
                          "please select training type",
                          style: CustomTextStyles.semiBold(
                            fontSize: 14.0,
                            fontColor: colorGreyText,
                          ),
                        ),
                        onChanged: (TrainingType? newValue) {
                          if (controller.action.value == 0 && controller.isTrainer == 1) {
                            controller.selectedTrainingTypeId = newValue!.id.toString();
                            for (var i = 0; i < controller.trainingTypes.length; i++) {
                              if (controller.trainingTypes[i].id == newValue.id) {
                                controller.selectedTrainingTypeIndex.value = i;
                              }
                            }
                          }
                        },
                        items: controller.trainingTypes.map((TrainingType object) {
                          return DropdownMenuItem<TrainingType>(
                            value: object,
                            child: Text(object.title),
                          );
                        }).toList(),
                        style: CustomTextStyles.semiBold(
                          fontSize: 14.0,
                          fontColor: themeBlack,
                        ),
                        // Customize the text color
                        icon: SvgPicture.asset(
                            ImageResourceSvg.dropDownBlack), // Customize the dropdown icon
                      ),
                    ),
                  )
                : Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                    decoration: BoxDecoration(
                        color: colorGreyEditText, borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      controller.appointmentData.result!.booking.bookingTrainingType.isNotEmpty
                          ? controller.appointmentData.result!.booking.bookingTrainingType[0]
                              ['title']
                          : 'Type not selected yet',
                      style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: colorGreyText),
                    ),
                  ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Obx(
            () => controller.trainingModes.isNotEmpty &&
                    controller.action.value == 0 &&
                    controller.isTrainer == 1
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: colorGreyEditText, borderRadius: BorderRadius.circular(8.0)),
                    width: Get.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<TrainingMode>(
                        value: controller.trainingModes[controller.selectedTrainingModeIndex.value],
                        hint: Text(
                          "please select training mode",
                          style: CustomTextStyles.semiBold(
                            fontSize: 14.0,
                            fontColor: colorGreyText,
                          ),
                        ),
                        onChanged: (TrainingMode? newValue) {
                          if (controller.action.value == 0 && controller.isTrainer == 1) {
                            controller.selectedTrainingModeId = newValue!.id.toString();
                            for (var i = 0; i < controller.trainingModes.length; i++) {
                              if (controller.trainingModes[i].id == newValue.id) {
                                controller.selectedTrainingModeIndex.value = i;
                              }
                            }
                          }
                        },
                        items: controller.trainingModes.map((TrainingMode object) {
                          return DropdownMenuItem<TrainingMode>(
                            value: object,
                            child: Row(
                              children: [
                                Text(object.title),
                              ],
                            ),
                          );
                        }).toList(),
                        style: CustomTextStyles.semiBold(
                          fontSize: 14.0,
                          fontColor: themeBlack,
                        ),
                        // Customize the text color
                        icon: SvgPicture.asset(
                            ImageResourceSvg.dropDownBlack), // Customize the dropdown icon
                      ),
                    ),
                  )
                : Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                    decoration: BoxDecoration(
                        color: colorGreyEditText, borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      controller.appointmentData.result!.booking.bookingTrainingMode != ''
                          ? controller.appointmentData.result!.booking.bookingTrainingMode['title']
                          : "Mode not selected yet",
                      style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: colorGreyText),
                    ),
                  ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          selectDateRangeView(),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
              maxLength: 5,
              enabledTextField:
                  controller.action.value == 0 && controller.isTrainer == 1 ? true : false,
              key: controller.amountKey,
              hintText: "Enter amount",
              controller: controller.amountCrt,
              hasBorder: false,
              borderColor: borderColor,
              fontColor: themeBlack,
              validateTypes: ValidateTypes.empty,
              style: CustomTextStyles.semiBold(
                fontSize: 14.0,
                fontColor: themeBlack,
              ),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              contentPadding: EdgeInsets.zero,
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(ImageResourceSvg.dollarTwo),
              ),
              prefixText: "\$"),
          const SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              if (controller.action.value == 0 && controller.isTrainer == 1) {
                Get.toNamed(Routes.GET_LOCATION_MAP)!.then(
                  (value) {
                    if (value != null) {
                      controller.locationCtr.text = value[0];
                      controller.userLat.value = value[1].toString();
                      controller.userLng.value = value[2].toString();
                      controller.locationKey.currentState!.checkValidation();
                      Helper().hideKeyBoard();
                    }
                  },
                );
              }
            },
            child: CustomTextFormField(
              enabledTextField: false,
              enabled: false,
              key: controller.locationKey,
              hintText: "Select location",
              controller: controller.locationCtr,
              hasBorder: false,
              borderColor: borderColor,
              fontColor: themeBlack,
              validateTypes: ValidateTypes.empty,
              style: CustomTextStyles.semiBold(
                fontSize: 14.0,
                fontColor: themeBlack,
              ),
              textInputAction: TextInputAction.next,
              contentPadding: EdgeInsets.zero,
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(ImageResourceSvg.locationIc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  selectDateRangeView() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: inputGrey),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              if ((controller.action.value == 0 && controller.isTrainer == 1) ||
                  (controller.isTrainer == 1 &&
                      controller.appointmentData.result!.booking.status == "Rebook")) {
                var val = await Get.toNamed(Routes.CALENDAR);
                List<String> dates = val.split(' to ');
                controller.startDate.value = controller.formatDate(dates[0]);
                controller.endDate.value = controller.formatDate(dates[1]);
                controller.selectedDateRange.value =
                    "${CustomMethod.convertDateFormat(dates[0], "dd/MM/yyyy", "dd-MMM")} to ${CustomMethod.convertDateFormat(dates[1], "dd/MM/yyyy", "dd-MMM")}";
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(ImageResourceSvg.calendarIc),
                const SizedBox(width: 10),
                Obx(
                  () => Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.selectedDateRange.value.isEmpty
                                ? "Select date availability"
                                : controller.selectedDateRange.value,
                            style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                          ),
                        ),
                        SvgPicture.asset(ImageResourceSvg.dropDownBlack)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 2,
            color: colorGreyText,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                  onTap: () => controller.selectStartTime(true),
                  child: SvgPicture.asset(ImageResourceSvg.timingIc)),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => controller.selectStartTime(true),
                child: Text(
                  controller.morningStartTimeSelected.value
                      ? controller.convertTimeOfDayToTimeString(
                              controller.selectedMorningStartTime.value) +
                          " am - "
                      : "Start time - ",
                  style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.selectEndTime(true);
                },
                child: Text(
                  controller.morningEndTimeSelected.value
                      ? controller.convertTimeOfDayToTimeString(
                              controller.selectedMorningEndTime.value) +
                          " am"
                      : "End time",
                  style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                  onTap: () => controller.selectEndTime(true),
                  child: SvgPicture.asset(ImageResourceSvg.downArrow))
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: Get.width,
            height: 40,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: controller.morningWeekList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if ((controller.action.value == 0 && controller.isTrainer == 1) ||
                        (controller.isTrainer == 1 &&
                            controller.appointmentData.result!.booking.status == "Rebook")) {
                      controller.morningWeekList[index].isSelected.value =
                          !controller.morningWeekList[index].isSelected.value;
                    }
                  },
                  child: Obx(
                    () => Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: controller.morningWeekList[index].isSelected.value
                                  ? themeWhite
                                  : colorGreyText),
                          shape: BoxShape.circle,
                          color: controller.morningWeekList[index].isSelected.value
                              ? themeBlack
                              : themeWhite),
                      child: Center(
                        child: Text(
                          controller.morningWeekList[index].day,
                          style: CustomTextStyles.semiBold(
                              fontSize: 12.0,
                              fontColor: controller.morningWeekList[index].isSelected.value
                                  ? themeWhite
                                  : colorGreyText),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              InkWell(
                  onTap: () => controller.selectStartTime(false),
                  child: SvgPicture.asset(ImageResourceSvg.timingIc)),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => controller.selectStartTime(false),
                child: Text(
                  controller.eveningStartTimeSelected.value
                      ? controller.convertTimeOfDayToTimeString(
                              controller.selectedEveningStartTime.value) +
                          " pm - "
                      : "Start time - ",
                  style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                ),
              ),
              InkWell(
                onTap: () => controller.selectEndTime(false),
                child: Text(
                  controller.eveningEndTimeSelected.value
                      ? controller.convertTimeOfDayToTimeString(
                              controller.selectedEveningEndTime.value) +
                          " pm"
                      : "End time",
                  style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                  onTap: () => controller.selectEndTime(false),
                  child: SvgPicture.asset(ImageResourceSvg.downArrow))
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: Get.width,
            height: 40,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: controller.eveningWeekList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if ((controller.action.value == 0 && controller.isTrainer == 1) ||
                        (controller.isTrainer == 1 &&
                            controller.appointmentData.result!.booking.status == "Rebook")) {
                      controller.eveningWeekList[index].isSelected.value =
                          !controller.eveningWeekList[index].isSelected.value;
                    }
                  },
                  child: Obx(
                    () => Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: controller.eveningWeekList[index].isSelected.value
                                  ? themeWhite
                                  : colorGreyText),
                          shape: BoxShape.circle,
                          color: controller.eveningWeekList[index].isSelected.value
                              ? themeBlack
                              : themeWhite),
                      child: Center(
                        child: Text(
                          controller.eveningWeekList[index].day,
                          style: CustomTextStyles.semiBold(
                              fontSize: 12.0,
                              fontColor: controller.eveningWeekList[index].isSelected.value
                                  ? themeWhite
                                  : colorGreyText),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
            ),
          ),
        ],
      ),
    );
  }

  profileDetailsView() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 100),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: themeWhite, width: 4.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff50555C).withOpacity(0.2),
                        offset: const Offset(0, 0.20),
                        spreadRadius: 1.0,
                        blurRadius: 10.0,
                      )
                    ]),
                child: circleProfileNetworkImage(
                    borderRadius: 40.0,
                    networkImage: controller.isTrainer == 1
                        ? controller.appointmentData.result!.booking.trainee.profileImage
                        : controller.appointmentData.result!.booking.trainer.profileImage),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.isTrainer == 1
                          ? controller.appointmentData.result!.booking.trainee.fullName
                          : controller.appointmentData.result!.booking.trainer.fullName,
                      style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    const SizedBox(width: 10.0),
                    Text(
                      controller.isTrainer == 1
                          ? "Trainee"
                          : controller.appointmentData.result!.booking.trainer.specialistName
                              .toString(),
                      style: CustomTextStyles.semiBold(
                        fontSize: 14.0,
                        fontColor: themeBlack,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              SvgPicture.asset(ImageResourceSvg.profilePhoneTwo),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mobile",
                    style: CustomTextStyles.normal(fontSize: 13.0, fontColor: colorGreyText),
                  ),
                  Text(
                    controller.isTrainer == 1
                        ? controller.appointmentData.result!.booking.trainee.cCodePhoneNumber
                        : controller.appointmentData.result!.booking.trainer.cCodePhoneNumber,
                    style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              SvgPicture.asset(ImageResourceSvg.mail),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email ID",
                    style: CustomTextStyles.normal(fontSize: 13.0, fontColor: colorGreyText),
                  ),
                  Text(
                    controller.isTrainer == 1
                        ? controller.appointmentData.result!.booking.trainee.email
                        : controller.appointmentData.result!.booking.trainer.email,
                    style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  bottomButton() {
    return Obx(() => controller.isLoading.value
        ? const SizedBox.shrink()
        : controller.action.value == 0 && !controller.isCancel.value
            ? Container(
                decoration: const BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (controller.isTrainer == 1) {
                            Get.back();
                          } else {
                            controller.isLoading.value = true;
                            apiLoader(
                                asyncCall: () => controller.acceptRejectScheduleReqByTrainerAPI(
                                    bookingId: controller.bookingId, action: 'Reject'));
                          }
                        },
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Text(
                            controller.isTrainer == 1 ? "Cancel" : "Reject",
                            style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (controller.isTrainer == 1) {
                            controller.validate();
                          } else {
                            controller.isLoading.value = true;

                            apiLoader(
                                asyncCall: () => controller.acceptRejectScheduleReqByTrainerAPI(
                                    bookingId: controller.bookingId, action: 'Accept'));
                          }
                        },
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: themeGreen,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(controller.isTrainer == 1 ? "Confirm" : "Accept",
                              style:
                                  CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : controller.isCancel.value
                ? Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              confirmationBottomSheet();
                            },
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: themeBlack,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: CustomTextStyles.semiBold(
                                    fontColor: themeWhite, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : controller.action.value == 2
                    ? Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.validate();
                                },
                                child: Container(
                                  height: 45,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: themeGreen,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Rebook',
                                    style: CustomTextStyles.semiBold(
                                        fontColor: themeBlack, fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink());
  }

  confirmationBottomSheet({bookId, action}) {
    return Get.bottomSheet(
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20.0, top: 20.0),
              decoration: const BoxDecoration(
                  color: themeWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Booking Cancellation",
                    style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Share reason for cancellation",
                      style: CustomTextStyles.normal(fontColor: themeBlack, fontSize: 14.0),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Obx(
                    () => CustomTextFormField(
                      maxLines: 5,
                      maxLength: 100,
                      showCounterText: true,
                      counter: controller.count.value,
                      key: controller.cancelKey,
                      hintText: "Write a your review here",
                      controller: controller.cancelCtr,
                      hasBorder: false,
                      borderColor: borderColor,
                      fontColor: themeBlack,
                      validateTypes: ValidateTypes.empty,
                      style: CustomTextStyles.semiBold(
                        fontSize: 14.0,
                        fontColor: themeBlack,
                      ),
                      getOnChageCallBack: true,
                      onChanged: (val) {
                        controller.count.value = controller.cancelCtr.text.length;
                      },
                      textInputAction: TextInputAction.next,
                      contentPadding: const EdgeInsets.only(left: 5.0, top: 10.0),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  InkWell(
                    onTap: () {
                      if (controller.cancelCtr.text.length > 10) {
                        apiLoader(
                          asyncCall: () => controller.cancelBookingAppointmentAPI(
                            bookingId: controller.bookingId,
                            reason: controller.cancelCtr.text,
                          ),
                        );
                      } else {
                        showSnackBar(
                            title: "Alert", message: "Reason should be more than 10 character");
                      }
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: themeGreen,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Submit',
                        style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: themeWhite,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: colorGreyText)),
                      child: Text(
                        "Cancel",
                        style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: true)
        .whenComplete(() => controller.cancelCtr.clear());
  }
}
