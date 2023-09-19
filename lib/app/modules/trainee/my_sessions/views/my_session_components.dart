import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/my_sessions/controllers/my_sessions_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../data/my_session_model.dart';
import '../../../../routes/app_pages.dart';

mixin MySessionComponents {
  var controller = Get.put(MySessionsController());

  historyTabView() {
    return Column(
      children: [
        historyTabs(),
        Expanded(child: controller.historyBooking.isEmpty ? noDataFound() : historyListView())
      ],
    );
  }

  onGoingListView() {
    return ListView.separated(
        shrinkWrap: true,
        controller: controller.scrollController,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 90),
        itemBuilder: (context, index) {
          if (index == controller.traineeOnGoingBookings.length - 1 &&
              controller.hasMore.value == 1) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
              ),
            );
          }
          return pendingView(controller.traineeOnGoingBookings[index], index, isFromOnGoing: true);
        },
        separatorBuilder: (_, index) {
          return Container(
            height: 20,
          );
        },
        itemCount: controller.traineeOnGoingBookings.length);
  }

  pendingListView() {
    return ListView.separated(
        controller: controller.scrollController,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 90),
        itemBuilder: (context, index) {
          if (index == controller.traineeUpComingBookings.length - 1 &&
              controller.hasMore.value == 1) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
              ),
            );
          }
          return pendingView(controller.traineeUpComingBookings[index], index);
        },
        separatorBuilder: (_, index) {
          return Container(
            height: 20,
          );
        },
        itemCount: controller.traineeUpComingBookings.length);
  }

  historyListView() {
    return ListView.separated(
        shrinkWrap: true,
        controller: controller.scrollController,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 90),
        itemBuilder: (context, index) {
          if (index == controller.historyBooking.length - 1 && controller.hasMore.value == 1) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
              ),
            );
          }
          return pendingView(controller.historyBooking[index], index);
        },
        separatorBuilder: (_, index) {
          return Container(
            height: 20,
          );
        },
        itemCount: controller.historyBooking.length);
  }

  sessionTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 98, left: 20.0, right: 20.0, bottom: 14.0),
      child: Row(
        children: [
          controller.tabItem(1, tabText: "Ongoing"),
          controller.tabItem(2, tabText: "Pending"),
          controller.tabItem(3, tabText: "History"),
        ],
      ),
    );
  }

  historyTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20.0, right: 20.0, bottom: 14.0),
      child: Row(
        children: [
          controller.historyTabItem(1, tabText: "Completed"),
          controller.historyTabItem(2, tabText: "Canceled"),
          controller.historyTabItem(3, tabText: "Rejected"),
        ],
      ),
    );
  }

  pendingView(Booking bookings, int index, {isFromOnGoing = false}) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SCHEDULE, arguments: [bookings.id, "1"]);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: colorGreyText, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
                top: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Appointment No",
                        style: CustomTextStyles.semiBold(
                          fontColor: themeBlack50,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        "Booking ID",
                        style: CustomTextStyles.semiBold(
                          fontColor: themeBlack50,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bookings.appoinmentNumber,
                        style: CustomTextStyles.semiBold(
                          fontColor: themeBlack,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        bookings.bookingNumber,
                        style: CustomTextStyles.semiBold(
                          fontColor: themeBlack,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 2,
              color: colorGreyText,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
                top: 10.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.TRAINER_PROFILE, arguments: bookings.trainer.id);
                        },
                        child: Container(
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
                              borderRadius: 40.0, networkImage: bookings.trainer!.profileImage),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookings.trainer.fullName.toString(),
                              style:
                                  CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              bookings.trainer.specialistName.toString(),
                              style: CustomTextStyles.semiBold(
                                  fontSize: 12.0, fontColor: colorGreyText),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  bookings.trainingStartDate.isEmpty
                      ? Text(
                          "Booking request sent. Trainer will call you soon...",
                          style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: themeYellow),
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 10),
                  bookings.bookingTrainingType.isNotEmpty
                      ? Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ImageResourceSvg.icBecomeATrainer,
                                  height: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  bookings.bookingTrainingType[0].title.toString(),
                                  style: CustomTextStyles.semiBold(
                                      fontSize: 14.0, fontColor: themeBlack),
                                )
                              ],
                            ),
                            const SizedBox(height: 13),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ImageResourceSvg.calendar,
                                  height: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  CustomMethod.convertDateFormat(
                                      bookings.trainingStartDate, 'yyyy-MM-dd', 'dd-MMM-yyyy'),
                                  style: CustomTextStyles.semiBold(
                                      fontSize: 14.0, fontColor: themeBlack),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ImageResourceSvg.clock,
                                  height: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  bookings.morningWeek.isNotEmpty
                                      ? "${bookings.morningWeek.first.toUpperCase()}-${bookings.morningWeek.last.toUpperCase()} "
                                      : bookings.eveningWeek.isNotEmpty
                                          ? "${bookings.eveningWeek.first.toUpperCase()}-${bookings.eveningWeek.last.toUpperCase()} "
                                          : "",
                                  style: CustomTextStyles.normal(
                                      fontSize: 12.0, fontColor: themeBlack),
                                ),
                                Expanded(
                                  child: Text(
                                    bookings.morningStartTime.isNotEmpty
                                        ? "(${"${bookings.morningStartTime} AM - ${bookings.morningEndTime}"} AM)"
                                        : bookings.eveningStartTime.isNotEmpty
                                            ? "(${"${bookings.morningStartTime} AM - ${bookings.morningEndTime}"} AM)"
                                            : "",
                                    style: CustomTextStyles.bold(
                                        fontSize: 12.0, fontColor: themeBlack),
                                  ),
                                ),
                                isFromOnGoing
                                    ? dayButton(bookings.remainigDays)
                                    : status(
                                        bookings.status == "Cancel" ? "Canceled" : bookings.status)
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  status(status) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: 35.0,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(
              color: status == "Canceled"
                  ? const Color(0xffDE0000)
                  : status == "Pending"
                      ? const Color(0xffFFC107)
                      : status == "Completed"
                          ? const Color(0xff1FDE00)
                          : status == "Rejected"
                              ? const Color(0xff9CAF28)
                              : themeBlack,
              width: 2),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            status,
            style: CustomTextStyles.semiBold(
              fontSize: 12.0,
              fontColor: status == "Canceled"
                  ? const Color(0xffDE0000)
                  : status == "Pending"
                      ? const Color(0xffFFC107)
                      : status == "Completed"
                          ? const Color(0xff1FDE00)
                          : status == "Rejected"
                              ? const Color(0xff9CAF28)
                              : themeBlack,
            ),
          ),
        ),
      ),
    );
  }

  dayButton(day) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: 35.0,
        width: 80,
        decoration: BoxDecoration(
          border:
              Border.all(color: (day != null) ? const Color(0xff0788FF) : colorGreyText, width: 2),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            day != null ? 'In ${day.toString()} Days ' : 'Expired',
            style: CustomTextStyles.semiBold(
              fontSize: 12.0,
              fontColor: (day != null) ? const Color(0xff0788FF) : colorGreyText,
            ),
          ),
        ),
      ),
    );
  }
}
