import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/data/notification_model.dart';
import 'package:fasttrackfitness/app/modules/notification/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/helper/colors.dart';
import '../../../core/helper/common_widget/custom_button.dart';
import '../../../routes/app_pages.dart';

mixin NotificationComponents {
  var controller = Get.put(NotificationController());

  notificationItem(NotificationsData notifications) {
    return Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: Text(
          notifications.notificationTime.toString(),
          style: CustomTextStyles.normal(fontSize: 11.0, fontColor: themeBlack50),
        ),
      ),
      const SizedBox(height: 4.0),
      notifications.notificationType == 0
          ? type00NotificationContainer(trainerNotifications: notifications)
          : notifications.notificationType == 1
              ? type01NotificationContainer(trainerNotifiation: notifications)
              : type02NotificationContainer(notificationsData: notifications)
    ]);
  }

  type00NotificationContainer({NotificationsData? trainerNotifications}) {
    return Container(
      width: Get.width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(6.0), color: inputGrey, boxShadow: [
        BoxShadow(color: const Color(0xffFFFFFF).withOpacity(0.20), offset: const Offset(0, 15.0))
      ]),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trainerNotifications!.staticTitle.toString(),
            style: CustomTextStyles.semiBold(
              fontSize: 16.0,
              fontColor: themeBlack,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            trainerNotifications.staticMessage.toString(),
            style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: themeBlack50),
          )
        ],
      ),
    );
  }

  type01NotificationContainer({required NotificationsData trainerNotifiation}) {
    return InkWell(
      onTap: () async {
        var val = await Get.toNamed(Routes.SCHEDULE,
            arguments: [trainerNotifiation.bookingDetails!.id, "0"]);
        if (val != null) {}
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: inputGrey,
          ),
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Appointment No.${trainerNotifiation.bookingDetails!.appoinmentNumber}",
                      style: CustomTextStyles.medium(
                        fontSize: 14.0,
                        fontColor: themeBlack50,
                      ),
                    ),
                    const SizedBox(height: 10.0),
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
                              networkImage: trainerNotifiation.senderUser!.profileImage),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trainerNotifiation.senderUser!.fullName.toString(),
                                style: CustomTextStyles.semiBold(
                                    fontSize: 16.0, fontColor: themeBlack),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageResourceSvg.bookingPhone,
                                    color: themeBlack50,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    trainerNotifiation.senderUser!.cCodePhoneNumber.toString(),
                                    style: CustomTextStyles.semiBold(
                                      fontSize: 14.0,
                                      fontColor: themeBlack,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      trainerNotifiation.staticMessage.toString(),
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack50,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              trainerNotifiation.action!.value == "1"
                  ? trainerNotifiation.bookingDetails!.status.value == "Scheduled"
                      ? Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            color: trainerNotifiation.action!.value == "1"
                                ? const Color(0xffE0E0E0)
                                : themeGreen,
                          ),
                          child: Text(
                            "Pending",
                            style: CustomTextStyles.semiBold(
                              fontSize: 16.0,
                              fontColor: themeBlack,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : trainerNotifiation.bookingDetails!.status.value == "Accepted"
                          ? Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  color: themeBlack),
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                  child: Text(
                                "Cancel",
                                style: CustomTextStyles.semiBold(
                                    fontSize: 16.0, fontColor: themeWhite),
                              )),
                            )
                          : const SizedBox.shrink()
                  : InkWell(
                      onTap: trainerNotifiation.action!.value == "1"
                          ? null
                          : () {
                              Get.toNamed(
                                Routes.SCHEDULE,
                                arguments: [trainerNotifiation.bookingDetails!.id, "0"],
                              );
                            },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          color: trainerNotifiation.action!.value == "1"
                              ? const Color(0xffE0E0E0)
                              : themeGreen,
                        ),
                        child: Text(
                          trainerNotifiation.action!.value == "1" ? "" : "Schedule Training",
                          style: CustomTextStyles.semiBold(
                            fontSize: 16.0,
                            fontColor: themeBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  type02NotificationContainer({NotificationsData? notificationsData}) {
    print("object---------->${notificationsData!.bookingDetails!.status.value}");

    return InkWell(
        onTap: () async {
          var val = await Get.toNamed(Routes.SCHEDULE,
              arguments: [notificationsData!.bookingDetails!.id, "0"]);
          if (val != null) {
            notificationsData.action!.value = val;
          }
        },
        child: Obx(
          () => controller.isLoading.value
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: inputGrey,
                  ),
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appointment No. ${notificationsData!.bookingDetails!.appoinmentNumber}",
                              style: CustomTextStyles.medium(
                                fontSize: 14.0,
                                fontColor: themeBlack50,
                              ),
                            ),
                            const SizedBox(height: 10.0),
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
                                      networkImage: notificationsData.senderUser!.profileImage),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notificationsData.senderUser!.fullName.toString(),
                                        style: CustomTextStyles.semiBold(
                                            fontSize: 16.0, fontColor: themeBlack),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        notificationsData.staticMessage!,
                                        style: CustomTextStyles.semiBold(
                                          fontColor: themeBlack50,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            commonText(
                                "Training Type",
                                notificationsData.bookingDetails!.bookingTrainingType == null
                                    ? const SizedBox.shrink()
                                    : notificationsData.bookingDetails!.bookingTrainingType
                                        .map((tType) => tType.userTrainingType.title)
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', '')),
                            const SizedBox(height: 4.0),
                            commonText(
                                "Time",
                                notificationsData.bookingDetails!.morningStartTime.isNotEmpty &&
                                        notificationsData
                                            .bookingDetails!.eveningStartTime.isNotEmpty
                                    ? "${notificationsData.bookingDetails!.morningStartTime} am - ${notificationsData.bookingDetails!.morningEndTime}am "
                                        "| ${notificationsData.bookingDetails!.eveningStartTime} pm "
                                        "- ${notificationsData.bookingDetails!.eveningEndTime} pm"
                                    : notificationsData.bookingDetails!.morningStartTime.isNotEmpty
                                        ? "${notificationsData.bookingDetails!.morningStartTime} am - ${notificationsData.bookingDetails!.morningEndTime}am "
                                        : notificationsData
                                                .bookingDetails!.eveningStartTime.isNotEmpty
                                            ? "| ${notificationsData.bookingDetails!.eveningStartTime} pm "
                                                "- ${notificationsData.bookingDetails!.eveningEndTime} pm"
                                            : ""),
                            const SizedBox(height: 14.0),
                          ],
                        ),
                      ),
                      notificationsData.bookingDetails!.status.value == "Accepted"
                          ? Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  color: themeBlack),
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                  child: Text(
                                "Cancel",
                                style: CustomTextStyles.semiBold(
                                    fontSize: 16.0, fontColor: themeWhite),
                              )),
                            )
                          : notificationsData.bookingDetails!.status.value == "Cancel" ||
                                  notificationsData.bookingDetails!.status.value == "Rejected" ||
                                  notificationsData.action!.value == '2'
                              ? const SizedBox.shrink()
                              : notificationsData.bookingDetails!.status.value == "Rebook"
                                  ? Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          color: themeGreen),
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                          child: Text(
                                        "Rebook",
                                        style: CustomTextStyles.semiBold(
                                            fontSize: 16.0, fontColor: themeBlack),
                                      )),
                                    )
                                  : notificationsData.action!.value == "1"
                                      ? Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10)),
                                              color: themeBlack),
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              "Cancel",
                                              style: CustomTextStyles.semiBold(
                                                  fontSize: 16.0, fontColor: themeWhite),
                                            ),
                                          ),
                                        )
                                      : Container(
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
                                                  confirmationBottomSheet(
                                                      bookId: notificationsData.bookingId,
                                                      action: "Reject",
                                                      title: "Booking Rejection",
                                                      type: 0);
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
                                                  child: Text("Reject",
                                                      style: CustomTextStyles.semiBold(
                                                          fontColor: themeBlack, fontSize: 16.0)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  confirmationBottomSheet(
                                                      bookId: notificationsData.bookingId,
                                                      action: "Accept",
                                                      title: "Booking Confirmation",
                                                      type: 1);
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
                                                  child: Text(
                                                    "Accept",
                                                    style: CustomTextStyles.semiBold(
                                                      fontSize: 16.0,
                                                      fontColor: themeBlack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                    ],
                  ),
                ),
        ));
  }

  confirmationBottomSheet({bookId, action, title, type}) {
    return Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  title,
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40.0,
                ),
                child: ButtonRegular(
                  verticalPadding: 14.0,
                  buttonText: "Confirm",
                  onPress: () {
                    if (Get.isBottomSheetOpen!) Get.back();
                    apiLoader(
                        asyncCall: () => controller.acceptRejectScheduleReqByTrainerAPI(
                            bookingId: bookId, action: action));
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: colorGreyText),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Cancel",
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }

  commonText(title, subTitle) {
    return RichText(
      text: TextSpan(
        text: title + " : ",
        style: CustomTextStyles.semiBold(
          fontSize: 14.0,
          fontColor: themeBlack50,
        ),
        children: <TextSpan>[
          TextSpan(
            text: subTitle,
            style: CustomTextStyles.semiBold(
              fontSize: 14.0,
              fontColor: themeBlack,
            ),
          ),
        ],
      ),
    );
  }
}
