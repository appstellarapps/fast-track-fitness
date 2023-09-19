import 'dart:convert';

import 'package:fasttrackfitness/app/data/my_stats_model.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../my_diary/controllers/my_diary_controller.dart';

class AddStatsController extends GetxController {
  var isLoading = true.obs;
  var statsList = <MyStatsResult>[].obs;
  List<Map> updateStatsList = [];

  @override
  void onInit() {
    super.onInit();
    apiLoader(asyncCall: () => getStats());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getStats() {
    WebServices.postRequest(
      uri: EndPoints.GET_STATS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        MyStatsModel myStatsModel = myStatsModelFromJson(responseBody);
        statsList.addAll(myStatsModel.result!);
        for (var a in statsList) {
          for (var b in a.excerciseTypeFields) {
            b.stateController.text = b.value.toString();
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

  void updateStats() {
    var body = {'exercises': updateStatsList};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.UPDATE_STATS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader(hideSnacks: false);
        var res = jsonDecode(responseBody);
        isLoading.value = false;
        updateStatsList.clear();
        var ctr = Get.put(MyDiaryController());
        ctr.getMyExerciseStats();
        Get.back();
        showSnackBar(title: "Success", message: res['message']);
      },
      onFailure: (error) {
        updateStatsList.clear();
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  addOrRemoveStats(index, subIndex, type) {
    if (statsList[index].excerciseTypeFields[subIndex].type == "Steps") {
      print("steps");
      statsList[index].excerciseTypeFields[subIndex].stateController.text = type == 0
          ? (int.parse(statsList[index].excerciseTypeFields[subIndex].stateController.text) + 1)
              .toString()
          : statsList[index].excerciseTypeFields[subIndex].stateController.text != "0"
              ? (int.parse(statsList[index].excerciseTypeFields[subIndex].stateController.text) - 1)
                  .toString()
              : "0";
    } else if (statsList[index].excerciseTypeFields[subIndex].type == "Hours") {
      print("Hours");
      var minute = convertMinuteSecondsToSeconds(
          statsList[index].excerciseTypeFields[subIndex].stateController.text.toString());
      if (type == 0) {
        minute++;
        statsList[index].excerciseTypeFields[subIndex].stateController.text = minutesToTime(minute);
      } else {
        if (minute != 0) {
          minute--;
          statsList[index].excerciseTypeFields[subIndex].stateController.text =
              minutesToTime(minute);
        }
      }
    } else {
      double km = double.parse(statsList[index].excerciseTypeFields[subIndex].stateController.text);
      if (type == 0) {
        km += 0.1;

        statsList[index].excerciseTypeFields[subIndex].stateController.text = km.toStringAsFixed(1);
      } else {
        if (km != 0) {
          km -= 0.1;
          statsList[index].excerciseTypeFields[subIndex].stateController.text =
              km.toStringAsFixed(1);
        }
      }
    }
  }

  int convertMinuteSecondsToSeconds(String minuteSeconds) {
    List<String> timeParts = minuteSeconds.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    return (hours * 60 + minutes);
  }

  String minutesToTime(int minutes) {
    int hours = minutes ~/ 60; // Get the whole number of hours
    int remainingMinutes = minutes % 60; // Get the remaining minutes

    String hoursString = hours.toString().padLeft(2, '0');
    String minutesString = remainingMinutes.toString().padLeft(2, '0');

    return '$hoursString:$minutesString';
  }

  int timeToMinutes(String time) {
    List<String> timeParts = time.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    return hours * 60 + minutes;
  }

  checkForUpdate() {
    var exerciseTypeId = '';
    for (var i = 0; i < statsList.length; i++) {
      var steps = 0;
      var kmsInMeters = 0.0;
      var hrsInMinutes = 0;
      exerciseTypeId = statsList[i].id;
      for (var j = 0; j < statsList[i].excerciseTypeFields.length; j++) {
        if (statsList[i].excerciseTypeFields[j].type == "Steps") {
          steps = int.parse(statsList[i].excerciseTypeFields[j].stateController.text.toString());
        } else if (statsList[i].excerciseTypeFields[j].type == "Hours") {
          hrsInMinutes =
              timeToMinutes(statsList[i].excerciseTypeFields[j].stateController.text.toString());
        } else {
          kmsInMeters = double.parse(statsList[i]
                  .excerciseTypeFields[j]
                  .stateController
                  .text
                  .toString()
                  .replaceAll(',', '')) *
              1000.0;
        }
      }
      if (steps != 0) {
        updateStatsList.add({
          'exerciseTypeId': exerciseTypeId,
          'steps': steps,
        });
      } else if (kmsInMeters != 0 || hrsInMinutes != 0) {
        updateStatsList.add({
          'exerciseTypeId': exerciseTypeId,
          "kmsInMeters": kmsInMeters,
          "hrsInMinutes": hrsInMinutes,
        });
      }
    }
    apiLoader(asyncCall: () => updateStats());
  }
}
