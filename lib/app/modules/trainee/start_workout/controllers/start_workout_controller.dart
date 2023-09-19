import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/get_start_work_out_model.dart';

class StartWorkoutController extends GetxController {
  //TODO: Implement StartWorkoutController

  var getStartWorkOutModel = GetStartWorkOutModel();

  var startWorkoutList = <Workout>[].obs;
  var isLoading = true.obs;
  var isDone = false.obs;
  var endItemList = [];

  @override
  void onInit() {
    super.onInit();
    apiLoader(asyncCall: () => getStartWorkout());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  int convertMinuteSecondsToSeconds(String minuteSeconds) {
    List<String> timeParts = minuteSeconds.split(':');
    int minutes = int.parse(timeParts[0]);
    int seconds = int.parse(timeParts[1]);
    return (minutes * 60 + seconds);
  }

  String formatSecondsToMinuteSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds';
  }

  void startTimer(mainIndex, subIndex, subChildIndex) {
    const oneSec = Duration(seconds: 1);
    startWorkoutList[mainIndex]
            .workoutExcerciseDaily[subIndex]
            .workoutExcerciseSetsDaily[subChildIndex]
            .localSecond
            .value =
        convertMinuteSecondsToSeconds(startWorkoutList[mainIndex]
            .workoutExcerciseDaily[subIndex]
            .workoutExcerciseSetsDaily[subChildIndex]
            .workoutTimeFormat
            .toString());

    startWorkoutList[mainIndex]
        .workoutExcerciseDaily[subIndex]
        .workoutExcerciseSetsDaily[subChildIndex]
        .timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        startWorkoutList[mainIndex]
            .workoutExcerciseDaily[subIndex]
            .workoutExcerciseSetsDaily[subChildIndex]
            .localSecond
            .value++;
      },
    );
  }

  getStartWorkout() {
    WebServices.postRequest(
      uri: EndPoints.GET_MYWORK_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        getStartWorkOutModel = getStartWorkOutModelFromJson(responseBody);
        startWorkoutList.addAll(getStartWorkOutModel.result!.workouts);

        for (var i = 0; i < startWorkoutList.length; i++) {
          for (var j = 0; j < startWorkoutList[i].workoutExcerciseDaily.length; j++) {
            for (var k = 0;
                k < startWorkoutList[i].workoutExcerciseDaily[j].workoutExcerciseSetsDaily.length;
                k++) {
              if (startWorkoutList[i]
                      .workoutExcerciseDaily[j]
                      .workoutExcerciseSetsDaily[k]
                      .workingFlag
                      .value ==
                  'Start') {
                DateTime date2 = DateFormat('yyyy-MM-dd HH:mm:ss').parseUtc(startWorkoutList[i]
                    .workoutExcerciseDaily[j]
                    .workoutExcerciseSetsDaily[k]
                    .startTime);
                Duration difference = DateTime.now().toUtc().difference(date2);

                // Duration difference = DateTime.now().toUtc().difference(DateTime.parseU(
                //    ));
                startWorkoutList[i]
                        .workoutExcerciseDaily[j]
                        .workoutExcerciseSetsDaily[k]
                        .localSecond
                        .value =
                    difference.inSeconds +
                        convertMinuteSecondsToSeconds(startWorkoutList[i]
                            .workoutExcerciseDaily[j]
                            .workoutExcerciseSetsDaily[k]
                            .workoutTimeFormat
                            .toString());

                print("this diffracen in second ${difference.inSeconds}");

                print("this is current date time ${DateTime.now().toUtc()}");
                print(
                    "this is start time ${startWorkoutList[i].workoutExcerciseDaily[j].workoutExcerciseSetsDaily[k].startTime}");
                const oneSec = Duration(seconds: 1);

                startWorkoutList[i].workoutExcerciseDaily[j].workoutExcerciseSetsDaily[k].timer =
                    Timer.periodic(
                  oneSec,
                  (Timer timer) {
                    startWorkoutList[i]
                        .workoutExcerciseDaily[j]
                        .workoutExcerciseSetsDaily[k]
                        .localSecond
                        .value++;
                    startWorkoutList[i]
                        .workoutExcerciseDaily[j]
                        .workoutExcerciseSetsDaily[k]
                        .isStarted
                        .value = true;
                    startWorkoutList[i]
                            .workoutExcerciseDaily[j]
                            .workoutExcerciseSetsDaily[k]
                            .workoutTimeFormat
                            .value =
                        formatSecondsToMinuteSeconds(startWorkoutList[i]
                            .workoutExcerciseDaily[j]
                            .workoutExcerciseSetsDaily[k]
                            .localSecond
                            .value);
                  },
                );
              }
            }
          }
        }

        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  actionWorkout(mainIndex, subIndex, subChildIndex) {
    RxList<WorkoutExcerciseSetsDaily> workOutSetDailyList =
        startWorkoutList[mainIndex].workoutExcerciseDaily[subIndex].workoutExcerciseSetsDaily.obs;
    var body = {
      "workoutId": startWorkoutList[mainIndex].id,
      "exerciseSetId": workOutSetDailyList[subChildIndex].id,
      "action": workOutSetDailyList[subChildIndex].workingFlag.value,
      "completedWorkoutIds": endItemList
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.START_EXCERCISE_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        var res = jsonDecode(responseBody);
        workOutSetDailyList[subChildIndex].workoutTimeFormat.value =
            res['result']['workoutTimeFormat'];
        workOutSetDailyList[subChildIndex].workingFlag.value = res['result']['workingFlag'];
        workOutSetDailyList[subChildIndex].isCompleted.value = res['result']['isCompleted'];
        workOutSetDailyList[subChildIndex].workoutTimeFormat.value =
            res['result']['workoutTimeFormat'];

        isLoading.value = false;
        isDone.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
        isDone.value = false;
      },
    );
  }
}
