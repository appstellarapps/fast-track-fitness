import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/my_booking_trainee/views/my_booking_trainee_view_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_print.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/keyboard_avoider.dart';
import '../controllers/my_booking_trainee_controller.dart';

class MyBookingTraineeView extends GetView<MyBookingTraineeController>
    with MyBookingTraineeViewComponents {
  const MyBookingTraineeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeWhite,
      resizeToAvoidBottomInset: false,
      appBar: ScaffoldAppBar.appBar(title: "Booking Details", actions: [
        MenuIcon(
          visibleWidget: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(ImageResourceSvg.icMore),
          ),
        )
      ]),
      body: Column(
        children: [
          Expanded(
            child: KeyboardAvoider(
              autoScroll: true,
              child: Column(children: [
                controller.remainingDays == ""
                    ? const SizedBox.shrink()
                    : Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffF5EDE0)),
                          padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                          child: Text(
                            controller.remainingDays == "1"
                                ? "${controller.remainingDays} day remained"
                                : "${controller.remainingDays} days remained",
                            style: CustomTextStyles.semiBold(
                              fontSize: 14.0,
                              fontColor: themeOrange,
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                  child: Obx(
                    () => Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: inputGrey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, right: 4.0),
                                child: SvgPicture.asset(ImageResourceSvg.appoinmentNoIc),
                              ),
                              Expanded(
                                child: Text(
                                  controller.appointmentNo.value,
                                  style: CustomTextStyles.semiBold(
                                    fontColor: themeBlack,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.commonFiledSpace,
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Booking No",
                                style: CustomTextStyles.semiBold(
                                  fontSize: 16.0,
                                  fontColor: themeBlack,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              flex: 2,
                              child: CustomTextFormField(
                                key: controller.keyBookingNo,
                                hintText: "",
                                isOptional: true,
                                controller: controller.bookingNoController,
                                hasBorder: false,
                                borderColor: borderColor,
                                fontColor: themeBlack,
                                focusNode: controller.focusBookingNo,
                                focusNext: controller.focusPrice,
                                validateTypes: ValidateTypes.empty,
                                style: CustomTextStyles.semiBold(
                                  fontSize: 14.0,
                                  fontColor: themeGrey,
                                ),
                                enabledTextField: false,
                                inputFormat: [FilteringTextInputFormatter.digitsOnly],
                                textInputAction: TextInputAction.next,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                        controller.commonFiledSpace,
                        Row(
                          children: [
                            SvgPicture.asset(ImageResourceSvg.trainingTypeIc),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                "Training Type",
                                style: CustomTextStyles.normal(
                                  fontSize: 17.0,
                                  fontColor: grey50,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        /*Obx(
                          () => controller.bookingTrainingType.isEmpty
                              ? const SizedBox.shrink()
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: inputGrey,
                                  ),
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(16.0),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      printLog(controller.bookingTrainingType[index].userTrainingType['title'] ?? "");
                                      return Text(
                                        controller.bookingTrainingType[index].userTrainingType['title'] ?? "",
                                        style: CustomTextStyles.semiBold(
                                          fontColor: themeBlack,
                                          fontSize: 14.0,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 10.0);
                                    },
                                    itemCount: controller.bookingTrainingType.length,
                                  ),
                                ),
                        ),*/
                        controller.commonFiledSpace,
                        Container(
                          decoration: BoxDecoration(
                            color: inputGrey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, right: 4.0),
                                child: SvgPicture.asset(ImageResourceSvg.trainingModeIc),
                              ),
                              Expanded(
                                child: Text(
                                  controller.selectedTrainingMode.value,
                                  style: CustomTextStyles.semiBold(
                                    fontSize: 16.0,
                                    fontColor: themeBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.commonFiledSpace,
                        Container(
                          width: Get.width,
                          // padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: inputGrey,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageResourceSvg.calendarIc),
                                      const SizedBox(width: 10.0),
                                      Text(
                                        controller.trainingStartDate.value == null &&
                                                controller.trainingEndDate.value == null
                                            ? "Please select date"
                                            : "${controller.trainingStartDate.value} to ${controller.trainingEndDate.value}",
                                        style: CustomTextStyles.semiBold(
                                          fontSize: 16.0,
                                          fontColor: themeBlack,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(height: 2.0, color: white50),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                child: Column(children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(ImageResourceSvg.timingIc),
                                      Text(
                                        controller.morningSTime.value == "" &&
                                                controller.morningETime == ""
                                            ? " Morning Shift "
                                            : " ${controller.morningSTime.value} - ${controller.morningETime.value}",
                                        style: CustomTextStyles.semiBold(
                                          fontSize: 16.0,
                                          fontColor: themeBlack,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: List.generate(
                                        controller.morningWeekList.length,
                                        (index) => Obx(() => commonDay(
                                            text: controller.morningWeekList[index].day,
                                            isSelected:
                                                controller.morningWeekList[index].isSelected.value,
                                            onTap: () {}))),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(ImageResourceSvg.timingIc),
                                      Text(
                                        controller.eveningSTime.value == "" &&
                                                controller.eveningETime == ""
                                            ? " Evening Shift"
                                            : " ${controller.eveningSTime.value} - ${controller.eveningETime.value}",
                                        style: CustomTextStyles.semiBold(
                                          fontSize: 16.0,
                                          fontColor: themeBlack,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: List.generate(
                                      controller.eveningWeekList.length,
                                      (index) => Obx(
                                        () => commonDay(
                                          text: controller.eveningWeekList[index].day,
                                          isSelected:
                                              controller.eveningWeekList[index].isSelected.value,
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              )
                            ],
                          ),
                        ),
                        controller.commonFiledSpace,
                        CustomTextFormField(
                          key: controller.keyCharge,
                          hintText: "Charge",
                          isOptional: true,
                          controller: controller.chargeController,
                          hasBorder: false,
                          borderColor: borderColor,
                          fontColor: themeBlack,
                          focusNode: controller.focusBookingNo,
                          focusNext: controller.focusPrice,
                          validateTypes: ValidateTypes.empty,
                          inputFormat: [FilteringTextInputFormatter.digitsOnly],
                          textInputAction: TextInputAction.next,
                          contentPadding: const EdgeInsets.only(left: 10.0),
                          maxLength: 4,
                          prefix: SvgPicture.asset(ImageResourceSvg.chargeIc),
                        ),
                        controller.commonFiledSpace,
                        InkWell(
                          onTap: () {},
                          child: CustomTextFormField(
                            key: controller.keyLocation,
                            hintText: "Location",
                            controller: controller.locationController,
                            hasBorder: false,
                            isOptional: true,
                            enabledTextField: false,
                            enabled: false,
                            borderColor: borderColor,
                            fontColor: themeBlack,
                            focusNode: controller.focusLocation,
                            validateTypes: ValidateTypes.empty,
                            inputFormat: [FilteringTextInputFormatter.digitsOnly],
                            textInputAction: TextInputAction.done,
                            contentPadding: const EdgeInsets.only(left: 10.0),
                            maxLength: 4,
                            prefix: SvgPicture.asset(ImageResourceSvg.locationIc),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 2.5, color: const Color(0xffE6E6E6)),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                  child: Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            circleProfileNetworkImage(
                                height: 50,
                                width: 50,
                                networkImage: controller.userProfilePic.value),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                controller.userName.value,
                                style: CustomTextStyles.semiBold(
                                  fontColor: themeBlack,
                                  fontSize: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                        controller.commonFiledSpace,
                        commonFields(
                            title: "Mobile",
                            icon: ImageResourceSvg.mobileNoIc,
                            subTitle: controller.userMobile.value),
                        const SizedBox(height: 12.0),
                        Container(height: 1.0, color: white50),
                        controller.commonFiledSpace,
                        commonFields(
                            title: "Email",
                            icon: ImageResourceSvg.emailIc,
                            subTitle: controller.userEmail.value),
                        const SizedBox(height: 12.0),
                        Container(height: 1.0, color: white50),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
          Obx(
            () => controller.bookingStatus.value == "Scheduled" &&
                    AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
                ? Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffE5E5E5),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            apiLoader(
                                asyncCall: () => controller.acceptRejectScheduleReqByTrainerAPI(
                                    bookingId: controller.bookingId.value, action: "Reject"));
                          },
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.only(top: 0, bottom: 0),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: borderColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: SafeArea(
                              child: Text("Reject",
                                  style: CustomTextStyles.semiBold(
                                      fontColor: themeBlack, fontSize: 16.0)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            apiLoader(
                                asyncCall: () => controller.acceptRejectScheduleReqByTrainerAPI(
                                    bookingId: controller.bookingId.value, action: "Accept"));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 46,
                            decoration: const BoxDecoration(
                              color: themeGreen,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: SafeArea(
                              child: Text("Accept",
                                  style: CustomTextStyles.semiBold(
                                    fontSize: 16.0,
                                    fontColor: themeBlack,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )
                : controller.bookingStatus.value == "Accepted"
                    ? InkWell(
                        onTap: () {
                          apiLoader(asyncCall: () => controller.cancelScheduleAPI());
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            color: themeBlack,
                          ),
                          child: Text(
                            "Cancel",
                            style: CustomTextStyles.semiBold(
                              fontSize: 16.0,
                              fontColor: themeWhite,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : controller.bookingStatus.value == "Scheduled"
                        ? Container(
                            width: Get.width,
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                              color: Color(0xffE0E0E0),
                            ),
                            child: Text(
                              "Pending",
                              style:
                                  CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : controller.bookingStatus.value == "Rebook" ||
                                controller.bookingStatus.value == "Reject" ||
                                controller.bookingStatus.value == "Cancel"
                            ? InkWell(
                                onTap: () {
                                  printLog("DSadsa");
                                  printLog(controller.bookingStatus.value);
                                  if (controller.bookingStatus.value == "Cancel") {
                                    apiLoader(asyncCall: () => controller.cancelScheduleAPI());
                                  }
                                  if (controller.bookingStatus.value == "Rebook" ||
                                      controller.bookingStatus.value == "Reject" ||
                                      controller.bookingStatus.value == "Cancel") {
                                    // reBookAppointmentAPI();
                                  }
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: themeBlack),
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                      child: Text(
                                    "Rebook",
                                    style: CustomTextStyles.semiBold(
                                        fontSize: 16.0, fontColor: themeWhite),
                                  )),
                                ),
                              )
                            : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
