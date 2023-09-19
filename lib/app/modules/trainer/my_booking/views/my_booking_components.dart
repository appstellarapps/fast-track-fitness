import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../data/get_my_booking.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/my_booking_controller.dart';

mixin MyBookingComponents {
  var controller = Get.put(MyBookingController());

  bottomItem(String name, index) {
    return Obx(
      () => InkWell(
        onTap: () {
          if (controller.selectedIndex != index) {
            controller.isLoading.value = true;
            controller.page = 1;
            controller.onGoingBooking.clear();
            controller.upComingBooking.clear();
            controller.historyBooking.clear();
            controller.appointmentBooking.clear();

            controller.haseMore.value = false;
            Get.closeAllSnackbars();
            controller.selectedIndex.value = index;
            apiLoader(asyncCall: () => controller.getTrainerBookings());
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: controller.selectedIndex.value == index ? themeGreen : themeWhite),
          child: Text(
            name,
            style: CustomTextStyles.semiBold(
              fontSize: 12.0,
              fontColor: controller.selectedIndex.value == index ? themeBlack : themeGrey,
            ),
          ),
        ),
      ),
    );
  }

  onGoingList() {
    return Obx(
      () => controller.onGoingBooking.isEmpty
          ? noDataFound()
          : ListView.separated(
              controller: controller.scrollController,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 80),
              itemBuilder: (context, index) {
                if (index == controller.onGoingBooking.length - 1 && controller.haseMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
                    ),
                  );
                }
                return commonItem(index, controller.onGoingBooking[index]);
              },
              separatorBuilder: (_, index) {
                return Container(
                  height: 20,
                );
              },
              itemCount: controller.onGoingBooking.length),
    );
  }

  pendingList() {
    return Obx(
      () => controller.upComingBooking.isEmpty
          ? noDataFound()
          : ListView.separated(
              controller: controller.scrollController,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 30.0),
              itemBuilder: (context, index) {
                if (index == controller.upComingBooking.length - 1 && controller.haseMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen)),
                    ),
                  );
                }
                return commonItem(index, controller.upComingBooking[index]);
              },
              separatorBuilder: (_, index) {
                return Container(
                  height: 20,
                );
              },
              itemCount: controller.upComingBooking.length),
    );
  }

  historyList() {
    return Obx(
      () => controller.historyBooking.isEmpty
          ? noDataFound()
          : ListView.separated(
              controller: controller.scrollController,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 30.0),
              itemBuilder: (context, index) {
                if (index == controller.historyBooking.length - 1 && controller.haseMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
                    ),
                  );
                }
                return commonItem(index, controller.historyBooking[index]);
              },
              separatorBuilder: (_, index) {
                return Container(
                  height: 20,
                );
              },
              itemCount: controller.historyBooking.length),
    );
  }

  appointment() {
    return controller.appointmentBooking.isEmpty
        ? noDataFound()
        : ListView.separated(
            controller: controller.scrollController,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 30.0),
            itemBuilder: (context, index) {
              if (index == controller.appointmentBooking.length - 1 && controller.haseMore.value) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color : themeGreen),)
                  ),
                );
              }
              return appointmentItem(controller.appointmentBooking[index], index);
            },
            separatorBuilder: (_, index) {
              return Container(
                height: 20,
              );
            },
            itemCount: controller.appointmentBooking.length);
  }

  commonItem(index, MyBooking bookingDetails) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SCHEDULE, arguments: [bookingDetails.id, "2"]);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: inputGrey),
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Appointment No",
                    style: CustomTextStyles.semiBold(
                      fontColor: themeGrey,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "Booking ID",
                    style: CustomTextStyles.semiBold(
                      fontColor: themeGrey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bookingDetails.appoinmentNumber,
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    bookingDetails.bookingNumber,
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: borderColor,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              circleProfileNetworkImage(
                                  networkImage: bookingDetails.trainee!.profileImage),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  bookingDetails.trainee!.fullName,
                                  style: CustomTextStyles.semiBold(
                                    fontSize: 16.0,
                                    fontColor: themeBlack,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  bookingDetails.trainee.email.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            launchEmail(bookingDetails.trainee!.email,
                                                "Schedule training", "");
                                          },
                                          child: SvgPicture.asset(ImageResourceSvg.tag))
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        launchCall(
                                            bookingDetails.trainee!.cCodePhoneNumber.toString());
                                      },
                                      child: SvgPicture.asset(ImageResourceSvg.call)),
                                ],
                              )
                            ],
                          ),
                          bookingDetails.bookingTrainingType.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    bookingDetails.bookingTrainingType.isEmpty
                                        ? const SizedBox.shrink()
                                        : Row(
                                            children: [
                                              SvgPicture.asset(
                                                ImageResourceSvg.icBecomeATrainer,
                                                height: 18,
                                                width: 18,
                                              ),
                                              const SizedBox(width: 10),
                                              Flexible(
                                                child: Text(
                                                  "${bookingDetails.bookingTrainingType.map((tType) => tType.title ?? "")} "
                                                  "| ${bookingDetails.bookingTrainingMode.title}",
                                                  style: CustomTextStyles.semiBold(
                                                    fontColor: const Color(0xff4C4C4C),
                                                    fontSize: 12.0,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                    const SizedBox(height: 10),
                                    bookingDetails.morningStartTime.isEmpty &&
                                            bookingDetails.eveningStartTime.isEmpty
                                        ? const SizedBox.shrink()
                                        : Row(
                                            children: [
                                              SvgPicture.asset(ImageResourceSvg.clock),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          bookingDetails.morningWeek.isNotEmpty
                                                              ? "${bookingDetails.morningWeek.first}-${bookingDetails.morningWeek.last}"
                                                                  .toUpperCase()
                                                              : "${bookingDetails.eveningWeek.first}-${bookingDetails.eveningWeek.last}"
                                                                  .toUpperCase(),
                                                          style: CustomTextStyles.normal(
                                                              fontSize: 12.0,
                                                              fontColor: const Color(0xff4C4C4C)),
                                                        ),
                                                        Text(
                                                          bookingDetails.morningStartTime.isNotEmpty
                                                              ? " (${bookingDetails.morningStartTime} AM - ${bookingDetails.morningEndTime} AM)"
                                                              : " (${bookingDetails.eveningStartTime} PM - ${bookingDetails.eveningEndTime} PM)",
                                                          style: CustomTextStyles.semiBold(
                                                              fontSize: 12.0,
                                                              fontColor: const Color(0xff4C4C4C)),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(ImageResourceSvg.location),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            bookingDetails.address,
                                            style: CustomTextStyles.semiBold(
                                              fontColor: themeBlack,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            bookingDetails.trainingStartDateFormat.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              SvgPicture.asset(ImageResourceSvg.myCalendar),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  "${bookingDetails.trainingStartDateFormat}",
                                  style: CustomTextStyles.semiBold(
                                      fontColor: themeBlack, fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 2.0),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              SvgPicture.asset(ImageResourceSvg.doller),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  "AU\$ ${bookingDetails.finalPrice}",
                                  style: CustomTextStyles.semiBold(
                                      fontColor: themeBlack, fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 20),
            bookingDetails.status == "Scheduled"
                ? pendingButton(bookingDetails)
                : myBookingButton(bookingDetails)
          ],
        ),
      ),
    );
  }

  appointmentItem(MyBooking appointments, index) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SCHEDULE, arguments: [appointments.id, "2"])
            ?.then((value) => controller.appointmentBooking.removeAt(index));
      },
      child: Column(
        children: [
          // Align(
          //     alignment: Alignment.bottomRight,
          //     child: Text(
          //       "09:35 pm",
          //       style: CustomTextStyles.normal(fontSize: dimen.textXXSmall, fontColor: themeGrey),
          //     )),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: inputGrey),
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Appointment No. ",
                            style: CustomTextStyles.semiBold(
                              fontColor: themeGrey,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            appointments.appoinmentNumber ?? "",
                            style: CustomTextStyles.semiBold(
                              fontColor: themeGrey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: themeWhite, width: 2.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xff50555C).withOpacity(0.2),
                                          offset: const Offset(0, 0.20),
                                          spreadRadius: 1.0,
                                          blurRadius: 10.0,
                                        )
                                      ]),
                                  child: circleProfileNetworkImage(
                                      networkImage: appointments.trainee!.profileImage),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        appointments.trainee!.fullName ?? "",
                                        style: CustomTextStyles.semiBold(
                                          fontColor: themeBlack,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(ImageResourceSvg.bookingPhone),
                                          const SizedBox(width: 10),
                                          Text(
                                            appointments.trainee!.cCodePhoneNumber.toString(),
                                            style: CustomTextStyles.semiBold(
                                              fontSize: 13.0,
                                              fontColor: themeBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Please coordinate for the generated enquiry",
                              style: CustomTextStyles.normal(
                                fontSize: 12.0,
                                fontColor: themeGrey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            appointments.bookingTrainingType.isEmpty
                                ? const SizedBox.shrink()
                                : Row(
                                    children: [
                                      Text(
                                        "Training Type: ",
                                        style: CustomTextStyles.semiBold(
                                          fontColor: themeGrey,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        appointments.bookingTrainingType.isEmpty
                                            ? " - "
                                            : appointments.bookingTrainingMode.title,
                                        style: CustomTextStyles.semiBold(
                                          fontSize: 14.0,
                                          fontColor: themeBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 5),
                            appointments.morningStartTime.isNotEmpty &&
                                    appointments.morningEndTime.isNotEmpty &&
                                    appointments.eveningStartTime.isNotEmpty &&
                                    appointments.eveningEndTime.isNotEmpty
                                ? Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Time: ",
                                          style: CustomTextStyles.semiBold(
                                            fontColor: themeGrey,
                                            fontSize: 14.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${appointments.morningStartTime ?? ""} AM - ${appointments.morningEndTime ?? ""} AM |"
                                          " ${appointments.eveningStartTime ?? ""} PM - ${appointments.eveningEndTime ?? ""} PM",
                                          style: CustomTextStyles.semiBold(
                                            fontColor: themeBlack,
                                            fontSize: 14.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                appointments.status == "Scheduled"
                    ? pendingButton(appointments)
                    : myBookingButton(appointments)
              ],
            ),
          ),
        ],
      ),
    );
  }

  myBookingButton(MyBooking appointments) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: appointments.status == "Accepted" || appointments.status == "Scheduled"
              ? themeBlack
              : appointments.status == "Rejected" || appointments.status == "Cancel"
                  ? themeGrey /*: appointments.status == "Rebook" ? themeBlack*/
                  : themeGreen),
      padding: const EdgeInsets.all(10),
      child: Center(
          child: Text(
        appointments.status == "Accepted" || appointments.status == "Scheduled"
            ? "Cancel"
            : appointments.status == "Rejected"
                ? 'Rejected'
                : appointments.status == "Cancel"
                    ? "Cancelled"
                    : appointments.status == "Rebook"
                        ? "Rebook"
                        : "Schedule Training",
        style: CustomTextStyles.semiBold(
          fontColor: appointments.status == "Accepted" || appointments.status == "Scheduled"
              ? themeWhite
              : appointments.status == "Rejected" || appointments.status == "Cancel"
                  ? themeWhite /*: appointments.status == "Rebook" ? themeWhite*/
                  : themeBlack,
          fontSize: 16.0,
        ),
      )),
    );
  }

  pendingButton(MyBooking appointments) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: themeGrey),
      padding: const EdgeInsets.all(10),
      child: Center(
          child: Text(
        "Pending",
        style: CustomTextStyles.semiBold(
          fontColor: themeBlack,
          fontSize: 16.0,
        ),
      )),
    );
  }
}
