import 'dart:async';
import 'dart:convert';

import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../data/my_session_model.dart';

class MySessionsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  var completedCount = "0".obs;
  var cancelledCount = "0".obs;
  var rejectedCount = "0".obs;
  var searchInput = "".obs;
  var selectedSession = 1.obs;
  var selectedHistorySession = 1.obs;
  var traineeOngoingBookingsListPage = 1;
  var traineeUpcomingBookingsListPage = 1;
  var traineeBookingHistoryListPage = 1;
  var isLoading = true.obs;
  var hasMore = 0.obs;
  var traineeOnGoingBookings = <Booking>[].obs;
  var traineeUpComingBookings = <Booking>[].obs;
  var historyBooking = <Booking>[].obs;

  Timer? timer;
  int start = 3;

  @override
  void onInit() {
    apiLoader(asyncCall: () => getTraineeBookedTraining());
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  scroll() {
    if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
      if (selectedSession.value == 1) {
        if (hasMore.value == 1) {
          traineeOngoingBookingsListPage++;
          getTraineeBookedTraining();
        }
      }

      if (selectedSession.value == 2) {
        if (hasMore.value == 1) {
          traineeUpcomingBookingsListPage++;
          getTraineeBookedTraining();
        }
      }
      if (selectedSession.value == 3) {
        if (hasMore.value == 1) {
          traineeBookingHistoryListPage++;
          getTraineeBookedTraining();
        }
      }
    }
  }

  tabItem(index, {tabText}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (selectedSession.value != index) {
            isLoading.value = true;
            selectedSession.value = index;
            traineeOnGoingBookings.clear();
            traineeUpComingBookings.clear();
            historyBooking.clear();
            traineeOngoingBookingsListPage = 1;
            traineeUpcomingBookingsListPage = 1;
            traineeBookingHistoryListPage = 1;
            apiLoader(asyncCall: () => getTraineeBookedTraining());
          }
        },
        child: Obx(
          () => Column(
            children: [
              Center(
                child: Text(
                  tabText,
                  style: CustomTextStyles.semiBold(
                    fontColor: selectedSession.value == index ? themeBlack : themeBlack50,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: selectedSession.value == index ? themeGreen : colorGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 2.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  historyTabItem(index, {tabText}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (selectedHistorySession.value != index) {
            selectedHistorySession.value = index;
            historyBooking.clear();
            traineeBookingHistoryListPage = 1;
            apiLoader(asyncCall: () => getTraineeBookedTraining());
          }
        },
        child: Obx(
          () => Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      color: selectedHistorySession.value == index ? themeGreen : colorGrey),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 13.0),
                    child: Text(
                      tabText,
                      style: CustomTextStyles.semiBold(
                        fontColor:
                            selectedHistorySession.value == index ? themeBlack : themeBlack50,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getTraineeBookedTraining() {
    if (traineeBookingHistoryListPage == 1) {
      historyBooking.clear();
    }
    if (traineeOngoingBookingsListPage == 1) {
      traineeOnGoingBookings.clear();
    }
    if (traineeUpcomingBookingsListPage == 1) {
      traineeUpComingBookings.clear();
    }
    var status = "Ongoing";
    if (selectedSession.value == 1) {
      status = "Ongoing";
    } else if (selectedSession.value == 2) {
      status = "Pending";
    } else if (selectedSession.value == 3) {
      status = "Completed";
      if (selectedHistorySession.value == 1) {
        status = "Completed";
      } else if (selectedHistorySession.value == 2) {
        status = "Cancelled";
      } else if (selectedHistorySession.value == 3) {
        status = "Rejected";
      }
    }

    var body = {
      "search": "",
      'tagName': status,
      "page": selectedSession.value == 1
          ? traineeOngoingBookingsListPage
          : selectedSession.value == 2
              ? traineeUpcomingBookingsListPage
              : traineeBookingHistoryListPage
    };
    WebServices.postRequest(
      uri: EndPoints.GET_MY_SESSION,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        var getTraineeOngoingBookingsModel = getTraineeBookingsModelFromJson(responseBody);
        hasMore.value = getTraineeOngoingBookingsModel.result!.hasMoreResults;

        if (selectedSession.value == 1) {
          traineeOnGoingBookings.addAll(getTraineeOngoingBookingsModel.result!.booking);
        }

        if (selectedSession.value == 2) {
          traineeUpComingBookings.addAll(getTraineeOngoingBookingsModel.result!.booking);
        }

        if (selectedSession.value == 3) {
          historyBooking.addAll(getTraineeOngoingBookingsModel.result!.booking);
        }
        var data = jsonDecode(responseBody);
        if (data != null) {
          completedCount.value = data['result']['completedCount'].toString();
          cancelledCount.value = data['result']['cancelledCount'].toString();
          rejectedCount.value = data['result']['rejectedCount'].toString();
        }

        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
