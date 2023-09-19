import 'dart:convert';

import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../data/get_my_booking.dart';

class MyBookingController extends GetxController {
  ScrollController scrollController = ScrollController();

  var selectedIndex = 0.obs;
  var onGoingBooking = <MyBooking>[].obs;
  var upComingBooking = <MyBooking>[].obs;
  var historyBooking = <MyBooking>[].obs;
  var appointmentBooking = <MyBooking>[].obs;
  var isLoading = true.obs;
  var getMyBookingModel = MyBookingModel();
  var haseMore = false.obs;
  var page = 1;
  var perPage = 10;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);
    selectedIndex.value = Get.arguments ?? 0;
    apiLoader(asyncCall: () => getTrainerBookings());
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
    if (scrollController.position.maxScrollExtent - 500 == scrollController.position.pixels - 500) {
      if (haseMore.value) {
        page++;
        getTrainerBookings();
      }
    }
  }

  void getTrainerBookings() {
    var status = "Ongoing";
    if (selectedIndex.value == 0) {
      status = "Ongoing";
    }
    if (selectedIndex.value == 1) {
      status = "Pending";
    }
    if (selectedIndex.value == 2) {
      status = "History";
    }
    if (selectedIndex.value == 3) {
      status = "Appointment";
    }

    var body = {'tagName': status, "perPage": perPage, 'page': page};
    WebServices.postRequest(
      uri: EndPoints.GET_MY_BOOKING,
      hasBearer: true,
      body: body,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        getMyBookingModel = myBookingModelFromJson(responseBody);
        if (selectedIndex.value == 0) {
          onGoingBooking.addAll(getMyBookingModel.result!.booking);
          haseMore.value = getMyBookingModel.result!.hasMoreResults == 0 ? false : true;
          // onGoingBooking.refresh();
        }
        if (selectedIndex.value == 1) {
          upComingBooking.addAll(getMyBookingModel.result!.booking);
          haseMore.value = getMyBookingModel.result!.hasMoreResults == 0 ? false : true;
          // upComingBooking.refresh();
        }
        if (selectedIndex.value == 2) {
          historyBooking.addAll(getMyBookingModel.result!.booking);
          haseMore.value = getMyBookingModel.result!.hasMoreResults == 0 ? false : true;

          // historyBooking.refresh();
        }
        if (selectedIndex.value == 3) {
          appointmentBooking.addAll(getMyBookingModel.result!.booking);
          haseMore.value = getMyBookingModel.result!.hasMoreResults == 0 ? false : true;
          // appointmentBooking.refresh();
        }
        // var data = jsonDecode(responseBody);
        // if (data != null) {
        //   completedCount.value = data['result']['completedCount'].toString();
        //   cancelledCount.value = data['result']['cancelledCount'].toString();
        //   rejectedCount.value = data['result']['rejectedCount'].toString();
        // }
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void cancelSchedule(bookingId) {
    var body = {"bookingId": bookingId};
    WebServices.postRequest(
      uri: EndPoints.CANCEL_SCHEDULE_APPOITMENT,
      hasBearer: true,
      body: body,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        var res = jsonDecode(responseBody);
        if (res['status'] == 1) {
          if (selectedIndex.value == 0) {
            for (var element in onGoingBooking) {
              if (element.id == bookingId) {
                onGoingBooking.remove(element);
                onGoingBooking.refresh();
              }
            }
          }
          if (selectedIndex.value == 1) {
            for (var element in upComingBooking) {
              if (element.id == bookingId) {
                upComingBooking.remove(element);
                upComingBooking.refresh();
              }
            }
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }
}
