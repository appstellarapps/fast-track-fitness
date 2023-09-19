import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/get_exercise_workout_model.dart';

class WorkoutCalendarController extends GetxController {
  var weekDayList = <WeekDay>[].obs;

  DateTime currentDate = DateTime.now();
  ScrollController scrollController = ScrollController();

  var isLoading = true.obs;
  var haseMore = false.obs;
  var page = 1;
  var workoutList = <Workout>[].obs;
  var previousIndex = 0;
  var selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var workOutSelected = 0.obs;
  var tag = Get.arguments[0];
  var id = Get.arguments[1];
  var selectedWeekIndex = 0;

  @override
  void onInit() {
    getWeekList();
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    apiLoader(asyncCall: () => getMyWorkout());
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
        getMyWorkout();
      }
    }
  }

  getWeekList() {
    var startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));
    var weekdays = List.generate(21, (index) => startOfWeek.add(Duration(days: index)));
    var formatter = DateFormat('EE');
    var formattedWeekdays = weekdays.map((date) => formatter.format(date)).toList();
    for (var i = 0; i < weekdays.length; i++) {
      weekDayList.add(
        WeekDay(
            day: formattedWeekdays[i],
            index: weekdays[i].day,
            isSelected: currentDate.day == weekdays[i].day ? true.obs : false.obs,
            month: weekdays[i].month,
            year: weekdays[i].year),
      );
      if (weekdays[i].day == currentDate.day) {
        previousIndex = weekDayList[i].index;
        selectedWeekIndex = i;
      }
    }
  }

  getMyWorkout() {
    var body = {
      'page': page,
      "traineeId": id != '' ? id : AppStorage.userData.result!.user.id,
      "tagName": "WorkoutCalender",
      "sortBy": "asc",
      "workoutDate": selectedDate
    };
    WebServices.postRequest(
      body: body,
      uri: tag == 0 ? EndPoints.GET_EXERCISE_WORKOUT : EndPoints.GET_NUTRITIONAL_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        GetExerciseModel getExerciseModel = getExerciseModelFromJson(responseBody);
        workoutList.addAll(getExerciseModel.result!.workouts);
        haseMore.value = getExerciseModel.result!.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  removeExerciseWorkout(index) {
    var body = {
      "tagName": workoutList[index].type,
      "workoutId": workoutList[index].id,
      "workoutDate": DateFormat('yyyy-MM-dd').format(workoutList[index].workoutDate),
      "traineeId": id != "" ? id : AppStorage.userData.result!.user.id,
    };
    WebServices.postRequest(
      body: body,
      uri: tag == 0 ? EndPoints.REMOVE_EXERCISE_WORKOUT : EndPoints.REMOVE_NUTRITIONAL_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        workoutList.removeAt(index);
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}

class WeekDay {
  WeekDay(
      {required this.day,
      required this.index,
      required this.isSelected,
      required this.month,
      required this.year});

  String day = '';
  int index = 0;
  int month;
  int year;
  var isSelected = false.obs;
}
