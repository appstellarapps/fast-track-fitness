import 'dart:convert';

import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';

import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';

class MyBookingTraineeController extends GetxController {
  final focusBookingNo = FocusNode(), focusPrice = FocusNode(), focusLocation = FocusNode();

  TextEditingController bookingNoController = TextEditingController(),
      chargeController = TextEditingController(),
      locationController = TextEditingController();

  final GlobalKey<CustomTextFormFieldState> keyBookingNo = GlobalKey<CustomTextFormFieldState>(),
      keyLocation = GlobalKey<CustomTextFormFieldState>(),
      keyCharge = GlobalKey<CustomTextFormFieldState>();

  List<WeekList> morningWeekList = [];
  List<WeekList> eveningWeekList = [];
  var remainingDays = "";
  var userLat = "".obs;
  var userLng = "".obs;
  var appointmentNo = "".obs;

  var commonFiledSpace = const SizedBox(height: 20.0);
  var bookingNo = "".obs;
  var trainingStartDate = "".obs;
  var trainingEndDate = "".obs;
  var selectedTrainingMode = "".obs;
  var selectedTrainingModeId = "".obs;

  // RxList<BookingTrainingType> bookingTrainingType = <BookingTrainingType>[].obs;
  var selectedMorningWeek = [].obs;
  var selectedEveningWeek = [].obs;
  var morningSTime = "".obs;
  var morningETime = "".obs;
  var eveningSTime = "".obs;
  var eveningETime = "".obs;
  var userProfilePic = "".obs;
  var userName = "".obs;
  var trainerUserId = "".obs;
  var traineeUserId = "".obs;
  var userMobile = "".obs;
  var userEmail = "".obs;
  var bookingId = "".obs;
  var bookingStatus = "".obs;

  var selTrainingTypeIds = [];

  /*void getScheduleDetails({bookingsId}) {
    Helper().hideKeyBoard();
    var body = {"bookingId": bookingsId};
    WebServices.postRequest(
      uri: EndPoints.GET_SCHEDULE_DETAILS,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();

        LogicalComponents.getScheduleDetails = getScheduleDetailsFromJson(responseBody);
        if (LogicalComponents.getScheduleDetails.status == 1) {
          Booking bookingData = LogicalComponents.getScheduleDetails.result!.booking!;
          if (bookingData != null) {
            bookingId.value = bookingData.id;
            bookingNo.value = bookingData.bookingNumber ?? " - ";
            bookingTrainingType.value = bookingData.bookingTrainingType!;
            selectedTrainingMode.value = bookingData.bookingTrainingMode['title'];
            selectedTrainingModeId.value = bookingData.bookingTrainingMode['id'];
            trainingStartDate.value = bookingData.trainingStartDate;
            trainingEndDate.value = bookingData.trainingEndDate ?? " - ";
            morningSTime.value = bookingData.morningStartTime ?? " - ";
            morningETime.value = bookingData.morningEndTime ?? " - ";
            eveningSTime.value = bookingData.eveningStartTime;
            eveningETime.value = bookingData.eveningEndTime;
            bookingStatus.value = bookingData.status;
            selectedMorningWeek.value = bookingData.morningWeek!;
            appointmentNo.value = bookingData.appoinmentNumber.toString();
            if (SessionImpl.getUserType() == EndPoints.USER_TYPE_TRAINER) {
              if (bookingData.trainee != null) {
                traineeUserId.value = bookingData.trainee.id;
                userName.value = "${bookingData.trainee.firstName} ${bookingData.trainee.lastName}";
                userProfilePic.value = bookingData.trainee.profilePic.toString();
                userMobile.value = "${bookingData.trainee.countryCode} ${bookingData.trainee.phoneNumber}";
                userEmail.value = bookingData.trainee.email.toString();
              }
            }
            if (SessionImpl.getUserType() == EndPoints.USER_TYPE_TRAINEE) {
              if (bookingData.trainer != null) {
                trainerUserId.value = bookingData.trainer.id;
                userName.value = "${bookingData.trainer.firstName} ${bookingData.trainer.lastName}";
                userProfilePic.value = bookingData.trainer.profilePic.toString();
                userMobile.value = "${bookingData.trainer.countryCode} ${bookingData.trainer.phoneNumber}";
                userEmail.value = bookingData.trainer.email.toString();
              }
            }

            if (selectedMorningWeek != null && selectedEveningWeek.isNotEmpty) {
              for (var element in morningWeekList) {
                if (selectedMorningWeek.contains(element.value)) {
                  element.isSelected.value = true;
                }
              }
            }
            selectedEveningWeek.value = bookingData.eveningWeek!;
            if (selectedEveningWeek != null && selectedEveningWeek.isNotEmpty) {
              for (var element in eveningWeekList) {
                if (selectedEveningWeek.contains(element.value)) {
                  element.isSelected.value = true;
                }
              }
            }
            chargeController.text = bookingData.finalPrice.toString();
            bookingNoController.text = bookingData.bookingNumber == null ? "" : bookingData.bookingNumber.toString();

            locationController.text = bookingData.address;
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }*/

  void reBookAppointmentAPI() {
    selTrainingTypeIds = [];

    /*for (var element in bookingTrainingType) {
      selTrainingTypeIds.add(element.id);
    }*/
    var body = {
      "traineeId": AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
          ? AppStorage.getUserId()
          : traineeUserId.value,
      "trainerId": AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER
          ? AppStorage.getUserId()
          : trainerUserId.value,
      "trainingModeId": selectedTrainingModeId.value,
      "trainingTypes": selTrainingTypeIds,
      "bookBy": AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER ? "Trainer" : "Trainee",
      "type": "rebook"
    };
    WebServices.postRequest(
      uri: EndPoints.BOOK_APPOINMENT,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        var res = jsonDecode(responseBody);
        if (res['status'] == 1) {
          Get.back();
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void cancelScheduleAPI() {
    var body = {
      "bookingId": bookingId.value,
    };
    WebServices.postRequest(
      uri: EndPoints.CANCEL_SCHEDULE_APPOITMENT,
      hasBearer: true,
      body: body,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        var res = jsonDecode(responseBody);
        if (res['status'] == 1) {
          Get.back(result: res['result']);
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: true);
      },
    );
  }

  void acceptRejectScheduleReqByTrainerAPI({bookingId, action}) {
    var body = {"bookingId": bookingId, "action": action};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.ACC_REJ_SCHEDULE_REQ,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        Get.closeAllSnackbars();
        hideAppLoader();
        var res = jsonDecode(responseBody);
        Get.back(result: res['result']['booking']);
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  @override
  void onInit() {
    morningWeekList.add(WeekList(day: "M", value: "Mon"));
    morningWeekList.add(WeekList(day: "T", value: "Tue"));
    morningWeekList.add(WeekList(day: "W", value: "Wed"));
    morningWeekList.add(WeekList(day: "T", value: "Thu"));
    morningWeekList.add(WeekList(day: "F", value: "Fri"));
    morningWeekList.add(WeekList(day: "S", value: "Sat"));
    morningWeekList.add(WeekList(day: "S", value: "Sun"));
    eveningWeekList.addAll(morningWeekList);

    /*if (Get.arguments != null) {
      var data = Get.arguments;
      apiLoader(asyncCall: () => getScheduleDetails(bookingsId: data));
    }*/

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
}

class WeekList {
  WeekList({this.day, this.value});

  var day;
  var value;
  var isSelected = false.obs;
}
