import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/data/schedule_model.dart';
import 'package:fasttrackfitness/app/modules/notification/controllers/notification_controller.dart';
import 'package:fasttrackfitness/app/modules/trainer/my_booking/controllers/my_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/get_appointmentdata_model.dart';
import '../../../../data/get_training_details.dart';
import '../../../../routes/app_pages.dart';
import '../../../trainee/my_sessions/controllers/my_sessions_controller.dart';

class ScheduleController extends GetxController {
  var appointmentCtr = TextEditingController();
  var bookingCtr = TextEditingController();
  var typeCrt = TextEditingController();
  var modeCrt = TextEditingController();
  var weightLossCrt = TextEditingController();
  var amountCrt = TextEditingController();
  var locationCtr = TextEditingController();
  var cancelCtr = TextEditingController();

  var appointmentFocus = FocusNode();
  var bookingFocus = FocusNode();
  var typeFocus = FocusNode();
  var modeFocus = FocusNode();
  var amountFocus = FocusNode();
  var locationFocus = FocusNode();

  var appointmentKey = GlobalKey<CustomTextFormFieldState>();
  var bookingKey = GlobalKey<CustomTextFormFieldState>();
  var typeKey = GlobalKey<CustomTextFormFieldState>();
  var modeKey = GlobalKey<CustomTextFormFieldState>();
  var amountKey = GlobalKey<CustomTextFormFieldState>();
  var locationKey = GlobalKey<CustomTextFormFieldState>();
  var cancelKey = GlobalKey<CustomTextFormFieldState>();

  var trainingTypes = <TrainingType>[].obs;
  var trainingModes = <TrainingMode>[].obs;
  var selectedTrainingTypeId = '';
  var selectedTrainingModeId = '';
  var selectedTrainingTypeIndex = 0.obs;
  var selectedTrainingModeIndex = 0.obs;
  var selectedDateRange = ''.obs;
  var morningWeekList = <WeekList>[].obs;
  var eveningWeekList = <WeekList>[].obs;
  var userLat = "".obs;
  var userLng = "".obs;
  var isScheduleLoading = true.obs;
  var isAppointmentLoading = true.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var isMorningSelected = false.obs;
  var isEveningSelected = false.obs;
  var status = ''.obs;

  var bookingId = Get.arguments[0];
  var action = 0.obs;
  var isCancel = false.obs;
  var isFrom =
      Get.arguments[1]; // 0 = Notification, 1 = MySession, 2 = My Booking 3=push notification
  var appointmentData = GetAppointmentDetailsModel();
  var isTrainer = AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER ? 1 : 0;
  var isLoading = true.obs;
  var count = 0.obs;
  var isValueChanged = false.obs;

  var isFromPushNotification = false;
  Rx<TimeOfDay> selectedMorningStartTime = TimeOfDay.now().obs;
  Rx<TimeOfDay> selectedMorningEndTime = TimeOfDay.now().obs;
  Rx<TimeOfDay> selectedEveningStartTime = TimeOfDay.now().obs;
  Rx<TimeOfDay> selectedEveningEndTime = TimeOfDay.now().obs;
  var morningStartTimeSelected = false.obs;
  var morningEndTimeSelected = false.obs;
  var eveningStartTimeSelected = false.obs;
  var eveningEndTimeSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    morningAndEveningWeek();
    apiLoader(asyncCall: () => getAppointmentDetail());
    if (isTrainer == 1) {
      apiLoader(asyncCall: () => getTrainerDetail());
    } else {
      isScheduleLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  checkAction() {
    if (isTrainer == 1) {
      if (status.value == "Pending") {
        isCancel.value = false;
        action.value = 0;
      } else if (status.value == "Scheduled") {
        isCancel.value = false;
        action.value = 1;
      } else if (status.value == "Accepted") {
        isCancel.value = true;
        action.value = 1;
      } else if (status.value == "Rebook") {
        isCancel.value = false;
        action.value = 2;
      } else {
        isCancel.value = false;
        action.value = 1;
      }
    } else {
      if (status.value == "Scheduled") {
        isCancel.value = false;
        action.value = 0;
      } else if (status.value == "Pending") {
        isCancel.value = true;
        action.value = 0;
      } else if (status.value == "Accepted") {
        isCancel.value = true;
        action.value = 1;
      } else if (status.value == "Rebook") {
        isCancel.value = false;
        action.value = 2;
      } else {
        isCancel.value = false;
        action.value = 1;
      }
    }
  }

  selectStartTime(isFromMorning) async {
    if (action.value == 0 ||
        (isTrainer == 1 && appointmentData.result!.booking.status == "Rebook")) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime:
            isFromMorning ? selectedMorningStartTime.value : selectedEveningStartTime.value,
      );

      if (pickedTime != null && pickedTime != selectedMorningStartTime.value) {
        if (isFromMorning) {
          if (pickedTime.period == DayPeriod.am) {
            if (getCompareTime(pickedTime, selectedMorningEndTime.value) ||
                !morningEndTimeSelected.value) {
              selectedMorningStartTime.value = pickedTime;
              isMorningSelected.value = true;
              morningStartTimeSelected.value = true;
            } else {
              showSnackBar(title: "Alert", message: "start time should be less than end time");
            }
          } else {
            showSnackBar(title: "Alert", message: "Please select AM time");
          }
        } else {
          if (pickedTime.period == DayPeriod.pm) {
            if (getCompareTime(pickedTime, selectedEveningEndTime.value) ||
                !eveningEndTimeSelected.value) {
              selectedEveningStartTime.value = pickedTime;
              isEveningSelected.value = true;
              eveningStartTimeSelected.value = true;
            } else {
              showSnackBar(title: "Alert", message: "start time should be less than end time");
            }
          } else {
            showSnackBar(title: "Alert", message: "Please select PM time");
          }
        }
      }
    }
  }

  getCompareTime(startTime, endTime) {
    bool result = false;
    int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
    int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;

    if (endTimeInt > startTimeInt) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  selectEndTime(isFromMorning) async {
    if (action.value == 0 ||
        (isTrainer == 1 && appointmentData.result!.booking.status == "Rebook")) {
      final TimeOfDay? pickedTime = await showTimePicker(
          context: Get.context!,
          initialTime: isFromMorning ? selectedMorningEndTime.value : selectedEveningEndTime.value);
      if (pickedTime != null && pickedTime != selectedMorningEndTime.value) {
        if (isFromMorning) {
          if (pickedTime.period == DayPeriod.am) {
            if (getCompareTime(selectedMorningStartTime.value, pickedTime) ||
                !morningStartTimeSelected.value) {
              selectedMorningEndTime.value = pickedTime;
              morningEndTimeSelected.value = true;
            } else {
              showSnackBar(title: "Alert", message: "End time should be greater than start time");
            }
          } else {
            showSnackBar(title: "Alert", message: "Please select AM time");
          }
        } else {
          if (pickedTime.period == DayPeriod.pm) {
            if (getCompareTime(selectedEveningStartTime.value, pickedTime) ||
                !eveningStartTimeSelected.value) {
              selectedEveningEndTime.value = pickedTime;
              eveningEndTimeSelected.value = true;
            } else {
              showSnackBar(title: "Alert", message: "End time should be greater than start time");
            }
          } else {
            showSnackBar(title: "Alert", message: "Please select PM time");
          }
        }
      }
    }
  }

  convertTimeOfDayToTimeString(TimeOfDay timeOfDay) {
    final DateTime now = DateTime.now();
    final DateTime dateTime =
        DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    final DateFormat format = DateFormat.jm();
    var time = format.format(dateTime).replaceAll("AM", "").replaceAll("PM", "").trim();
    return time.length == 4 ? "0$time" : time;
  }

  TimeOfDay convertTimeStringToTimeOfDay(String timeString) {
    final DateFormat format = DateFormat.Hm();
    final DateTime dateTime = format.parse(timeString);

    return TimeOfDay.fromDateTime(dateTime);
  }

  morningAndEveningWeek() {
    morningWeekList.add(WeekList(day: "M", value: "Mon"));
    morningWeekList.add(WeekList(day: "T", value: "Tue"));
    morningWeekList.add(WeekList(day: "W", value: "Wed"));
    morningWeekList.add(WeekList(day: "T", value: "Thu"));
    morningWeekList.add(WeekList(day: "F", value: "Fri"));
    morningWeekList.add(WeekList(day: "S", value: "Sat"));
    morningWeekList.add(WeekList(day: "S", value: "Sun"));

    eveningWeekList.add(WeekList(day: "M", value: "Mon"));
    eveningWeekList.add(WeekList(day: "T", value: "Tue"));
    eveningWeekList.add(WeekList(day: "W", value: "Wed"));
    eveningWeekList.add(WeekList(day: "T", value: "Thu"));
    eveningWeekList.add(WeekList(day: "F", value: "Fri"));
    eveningWeekList.add(WeekList(day: "S", value: "Sat"));
    eveningWeekList.add(WeekList(day: "S", value: "Sun"));
  }

  String formatDate(String date) {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return formattedDate;
  }

  String formatDateTwo(String date) {
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return formattedDate;
  }

  validate() {
    Get.closeAllSnackbars();
    var tempMorningWeekList = [];
    var tempEveningWeekList = [];

    for (var element in morningWeekList) {
      if (element.isSelected.value) {
        tempMorningWeekList.add(element.value);
      }
    }
    for (var element in eveningWeekList) {
      if (element.isSelected.value) {
        tempEveningWeekList.add(element.value);
      }
    }

    if (startDate.isEmpty || endDate.isEmpty) {
      showSnackBar(title: "Alert", message: "Please select start & end date");
    } else if (!isMorningSelected.value && !isEveningSelected.value) {
      showSnackBar(title: "Alert", message: "Please select shift");
    } else if (tempEveningWeekList.isEmpty && tempMorningWeekList.isEmpty) {
      showSnackBar(title: "Alert", message: "Please select day");
    } else if (amountCrt.text.isEmpty) {
      showSnackBar(title: "Alert", message: "Please enter amount");
    } else if (locationCtr.text.isEmpty) {
      showSnackBar(title: "Alert", message: "Please select location");
    } else {
      if ((isTrainer == 1 && appointmentData.result!.booking.status == "Rebook")) {
        apiLoader(asyncCall: () => rebookAppointment(tempMorningWeekList, tempEveningWeekList));
      } else if ((isTrainer == 0 && appointmentData.result!.booking.status == "Rebook")) {
        apiLoader(
            asyncCall: () => traineeRebookAppointment(appointmentData.result!.booking.trainerId));
      } else {
        apiLoader(
            asyncCall: () => scheduledTrainingAction(tempMorningWeekList, tempEveningWeekList));
      }
    }
  }

  void getTrainerDetail() {
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINING_DETAILS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        GetTraningDetailsModel getTraningDetailsModel =
            getTraningDetailsModelFromJson(responseBody);
        trainingTypes.addAll(getTraningDetailsModel.result!.trainingTypes);
        trainingModes.addAll(getTraningDetailsModel.result!.trainingModes);

        isScheduleLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isScheduleLoading.value = false;
      },
    );
  }

  void getAppointmentDetail() {
    WebServices.postRequest(
      uri: EndPoints.GET_SCHDULE_DATA,
      hasBearer: true,
      body: {'bookingId': bookingId},
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        isLoading.value = false;

        appointmentData = getAppointmentDetailsModelFromJson(responseBody);
        appointmentCtr.text = appointmentData.result!.booking.appoinmentNumber;
        bookingCtr.text = appointmentData.result!.booking.bookingNumber;

        status.value = appointmentData.result!.booking.status;
        checkAction();

        if (appointmentData.result!.booking.bookingTrainingType.isNotEmpty) {
          for (var i = 0; i < trainingTypes.length; i++) {
            if (trainingTypes[i].id ==
                appointmentData.result!.booking.bookingTrainingType[0]['trainertrainingTypeId']) {
              selectedTrainingTypeIndex.value = i;
              selectedTrainingTypeId = trainingTypes[i].id;
            }
          }
        }
        if (appointmentData.result!.booking.bookingTrainingMode != '') {
          for (var i = 0; i < trainingModes.length; i++) {
            if (trainingModes[i].trainingModesId ==
                appointmentData.result!.booking.bookingTrainingMode['trainingModesId']) {
              selectedTrainingModeIndex.value = i;
              selectedTrainingModeId = trainingModes[i].id;
            }
          }

          if ((isTrainer == 0 && action.value == 2) || action.value != 2) {
            startDate.value = appointmentData.result!.booking.trainingStartDate;
            endDate.value = appointmentData.result!.booking.trainingEndDate;
            selectedDateRange.value =
                "${CustomMethod.convertDateFormat(startDate.value, "yyyy-MM-dd", "dd-MMM")} to ${CustomMethod.convertDateFormat(endDate.value, "yyyy-MM-dd", "dd-MMM")}";
            for (var element in appointmentData.result!.booking.morningWeek) {
              for (var day in morningWeekList) {
                if (day.value == element) {
                  day.isSelected.value = true;
                }
              }
            }
            for (var element in appointmentData.result!.booking.eveningWeek) {
              for (var day in eveningWeekList) {
                if (day.value == element) {
                  day.isSelected.value = true;
                }
              }
            }
            // isMorningSelected.value = true;
            // isEveningSelected.value = true;
            if (appointmentData.result!.booking.morningStartTime.isNotEmpty) {
              selectedMorningStartTime.value =
                  convertTimeStringToTimeOfDay(appointmentData.result!.booking.morningStartTime);
              morningStartTimeSelected.value = true;
            }
            if (appointmentData.result!.booking.morningEndTime.isNotEmpty) {
              selectedMorningEndTime.value =
                  convertTimeStringToTimeOfDay(appointmentData.result!.booking.morningEndTime);
              morningEndTimeSelected.value = true;
            }
            if (appointmentData.result!.booking.eveningStartTime.isNotEmpty) {
              selectedEveningStartTime.value =
                  convertTimeStringToTimeOfDay(appointmentData.result!.booking.eveningStartTime);
              eveningStartTimeSelected.value = true;
            }
            if (appointmentData.result!.booking.eveningEndTime.isNotEmpty) {
              selectedEveningEndTime.value =
                  convertTimeStringToTimeOfDay(appointmentData.result!.booking.eveningEndTime);
              eveningEndTimeSelected.value = true;
            }

            isMorningSelected.value = true;
            isEveningSelected.value = true;
          }

          amountCrt.text = appointmentData.result!.booking.finalPrice.toString();
          locationCtr.text = appointmentData.result!.booking.address.toString();
        }
        isAppointmentLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isAppointmentLoading.value = false;
        isLoading.value = false;
      },
    );
  }

  void scheduledTrainingAction(tempMorningWeekList, tempEveningWeekList) {
    var body = {
      "bookingId": appointmentData.result!.booking.id,
      "trainingTypes":
          selectedTrainingTypeId.isEmpty ? [trainingTypes[0].id] : [selectedTrainingTypeId],
      "trainingModeId":
          selectedTrainingModeId.isEmpty ? trainingModes[0].id : selectedTrainingModeId,
      "trainingStartDate": startDate.value,
      "trainingEndDate": endDate.value,
      "morningStartTime": isMorningSelected.value
          ? convertTimeOfDayToTimeString(selectedMorningStartTime.value)
          : "",
      "morningEndTime":
          isMorningSelected.value ? convertTimeOfDayToTimeString(selectedMorningEndTime.value) : "",
      "morningWeek": tempMorningWeekList,
      "eveningStartTime": isEveningSelected.value
          ? convertTimeOfDayToTimeString(selectedEveningStartTime.value)
          : "",
      "eveningEndTime":
          isEveningSelected.value ? convertTimeOfDayToTimeString(selectedEveningEndTime.value) : "",
      "eveningWeek": tempEveningWeekList,
      "finalPrice": amountCrt.text.trim(),
      "address": locationCtr.text.trim()
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.CREATE_SCHEDULE_TRAINING,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        isLoading.value = false;

        var model = scheduleModelFromJson(responseBody);
        if (model.status == 1) {
          if (isFrom == "0") {
            var notificationController = Get.put(NotificationController());

            for (int i = 0; i < notificationController.notificationList.length; i++) {
              if (notificationController.notificationList[i].notificationType == 1 &&
                  appointmentData.result!.booking.id ==
                      notificationController.notificationList[i].bookingDetails!.id) {
                notificationController.notificationList[i].bookingDetails!.status.value =
                    "Scheduled";
                notificationController.notificationList[i].action!.value = "1";
                break;
              }
            }
          } else if (isFrom == "2") {
            var myBookingController = Get.put(MyBookingController());

            for (int i = 0; i < myBookingController.upComingBooking.length; i++) {
              if (appointmentData.result!.booking.id == myBookingController.upComingBooking[i].id) {
                myBookingController.upComingBooking[i].status = model.result.booking.status;

                // myBookingController.upComingBooking[i].bookingTrainingType[0].title = model.result.booking.bookingTrainingType[0].title;
                myBookingController.upComingBooking[i].bookingTrainingMode.title =
                    model.result.booking.bookingTrainingMode.title;

                // if(model.result.booking.morningWeek.isNotEmpty) {
                //   myBookingController.upComingBooking[i].morningWeek.first = model.result.booking.morningWeek.first;
                //   myBookingController.upComingBooking[i].morningWeek.last = model.result.booking.morningWeek.last;
                // }
                //
                // if(model.result.booking.eveningWeek.isNotEmpty) {
                //   myBookingController.upComingBooking[i].eveningWeek.first = model.result.booking.eveningWeek.first;
                //   myBookingController.upComingBooking[i].eveningWeek.last = model.result.booking.eveningWeek.last;
                // }

                myBookingController.upComingBooking[i].morningStartTime =
                    model.result.booking.morningStartTime;
                myBookingController.upComingBooking[i].morningEndTime =
                    model.result.booking.morningEndTime;
                myBookingController.upComingBooking[i].eveningStartTime =
                    model.result.booking.eveningStartTime;
                myBookingController.upComingBooking[i].eveningEndTime =
                    model.result.booking.eveningEndTime;

                myBookingController.upComingBooking[i].address = model.result.booking.address;
                myBookingController.upComingBooking[i].trainingStartDateFormat =
                    model.result.booking.trainingStartDateFormat;
                myBookingController.upComingBooking[i].finalPrice = model.result.booking.finalPrice;

                myBookingController.upComingBooking.refresh();
                break;
              }
            }
          }
          Get.back();
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void rebookAppointment(tempMorningWeekList, tempEveningWeekList) {
    var body = {
      "bookingId": appointmentData.result!.booking.id,
      "trainingTypes":
          selectedTrainingTypeId.isEmpty ? [trainingTypes[0].id] : [selectedTrainingTypeId],
      "trainingModeId":
          selectedTrainingModeId.isEmpty ? trainingModes[0].id : selectedTrainingModeId,
      "trainingStartDate": startDate.value,
      "trainingEndDate": endDate.value,
      "morningStartTime": isMorningSelected.value
          ? convertTimeOfDayToTimeString(selectedMorningStartTime.value)
          : "",
      "morningEndTime":
          isMorningSelected.value ? convertTimeOfDayToTimeString(selectedMorningEndTime.value) : "",
      "morningWeek": tempMorningWeekList,
      "eveningStartTime": isEveningSelected.value
          ? convertTimeOfDayToTimeString(selectedEveningStartTime.value)
          : "",
      "eveningEndTime":
          isEveningSelected.value ? convertTimeOfDayToTimeString(selectedEveningEndTime.value) : "",
      "eveningWeek": tempEveningWeekList,
      "finalPrice": amountCrt.text.trim(),
      "address": locationCtr.text.trim()
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.REBOOK_APPOINTMENT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        Get.offAllNamed(Routes.TRAINER_DASHBOARD);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
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
        isLoading.value = false;
        if (isFrom == "0") {
          var notificationController = Get.put(NotificationController());

          for (int i = 0; i < notificationController.notificationList.length; i++) {
            if (notificationController.notificationList[i].notificationType == 2 &&
                bookingId == notificationController.notificationList[i].bookingDetails!.id) {
              notificationController.notificationList[i].bookingDetails!.status.value =
                  action == "Accept" ? "Accepted" : "Rejected";
              notificationController.notificationList[i].action!.value = "1";
              break;
            }
          }
        } else if (isFrom == "1") {
          var mySessionController = Get.put(MySessionsController());

          for (int i = 0; i < mySessionController.traineeUpComingBookings.length; i++) {
            if (bookingId == mySessionController.traineeUpComingBookings[i].id) {
              mySessionController.traineeUpComingBookings.removeAt(i);
              mySessionController.traineeUpComingBookings.refresh();
              break;
            }
          }
        }
        Get.back();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void cancelBookingAppointmentAPI({bookingId, reason}) {
    var body = {"bookingId": bookingId, "cancelReason": reason};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.CANCEL_APPOITMENT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        Get.closeAllSnackbars();
        hideAppLoader();
        isLoading.value = false;

        Get.back();
        if (isFrom == "0") {
          var notificationController = Get.put(NotificationController());

          for (int i = 0; i < notificationController.notificationList.length; i++) {
            if (notificationController.notificationList[i].notificationType != 0 &&
                bookingId == notificationController.notificationList[i].bookingDetails!.id) {
              notificationController.notificationList[i].bookingDetails!.status.value = "Cancel";
              break;
            }
          }
        } else if (isFrom == "1") {
          var mySessionController = Get.put(MySessionsController());

          for (int i = 0; i < mySessionController.traineeOnGoingBookings.length; i++) {
            if (bookingId == mySessionController.traineeOnGoingBookings[i].id) {
              mySessionController.traineeOnGoingBookings.removeAt(i);
              mySessionController.traineeOnGoingBookings.refresh();
              break;
            }
          }
        } else if (isFrom == "2") {
          var myBookingController = Get.put(MyBookingController());

          for (int i = 0; i < myBookingController.onGoingBooking.length; i++) {
            if (bookingId == myBookingController.onGoingBooking[i].id) {
              myBookingController.onGoingBooking.removeAt(i);
              myBookingController.onGoingBooking.refresh();
              break;
            }
          }
        }
        Get.back();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}

class WeekList {
  WeekList({required this.day, required this.value});

  var day = 'M';
  var value = "Mon";
  var isSelected = false.obs;
}

void traineeRebookAppointment(trainerId) {
  WebServices.postRequest(
    body: {'trainerId': trainerId},
    uri: EndPoints.BOOK_APPOINMENT,
    hasBearer: true,
    onStatusSuccess: (responseBody) {
      hideAppLoader();
      Get.closeAllSnackbars();
      thankYouSheet();
    },
    onFailure: (error) {
      hideAppLoader(hideSnacks: false);
      Get.closeAllSnackbars();
      showSnackBar(title: "Error", message: "Something went wrong please try again");
    },
  );
}

thankYouSheet() {
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
                "Successful!",
                style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 30.0,
                bottom: 30.0,
              ),
              child: Text(
                "Trainer will contact you soon regarding \nyour booking request",
                style: CustomTextStyles.normal(
                  fontSize: 14.0,
                  fontColor: grey50,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: ButtonRegular(
                buttonText: "Ok",
                onPress: () {
                  if (Get.isBottomSheetOpen!) Get.back();
                  Get.back(result: true);
                },
              ),
            )
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: false);
}
