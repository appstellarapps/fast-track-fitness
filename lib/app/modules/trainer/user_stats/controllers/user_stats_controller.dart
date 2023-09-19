import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/custom_method.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/nutritional_stats_model.dart';
import '../../../../data/stats_distance_model.dart';

class UserStatsController extends GetxController {
  //TODO: Implement UserStatsController

  TextEditingController startDateCtr = TextEditingController();
  TextEditingController endDateCtr = TextEditingController();

  GlobalKey<CustomTextFormFieldState> startDateKey = GlobalKey<CustomTextFormFieldState>();
  GlobalKey<CustomTextFormFieldState> endDateKey = GlobalKey<CustomTextFormFieldState>();

  var selectedStateIndex = 0.obs;
  var workOutSelected = 0.obs;
  var isLoading = true.obs;
  var isTabLoading = true.obs;
  var selectedTypeIndex = 0.obs;

  var diaryExercisesItems = [].obs;
  var diaryNutritionalItems = [].obs;
  var typeList = ['Distance', 'Time'];
  var traineeId = Get.arguments[0];

  TooltipBehavior tooltip = TooltipBehavior(enable: true);
  StatsDistanceModel distanceModel = StatsDistanceModel();
  NutritionalStatsModel nutritionalStatsModel = NutritionalStatsModel();
  @override
  void onInit() {
    super.onInit();
    selectedStateIndex.value = Get.arguments[1];
    startDateCtr.text = CustomMethod.convertDateFormat(
        DateFormat('dd-MM-yyyy').format(DateTime.now()), 'dd-MM-yyyy', 'dd, MMM-yyyy');
    endDateCtr.text = CustomMethod.convertDateFormat(
        DateFormat('dd-MM-yyyy').format(DateTime.now()), 'dd-MM-yyyy', 'dd, MMM-yyyy');
    apiLoader(
        asyncCall: () =>
            selectedStateIndex.value == 0 ? getMyExerciseStats() : getMyNutritionalStats());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  selectDate(isStartDate) {
    return showDatePicker(
      context: Get.context!,
      initialDate:
          DateFormat("dd, MMM-yyyy").parse(isStartDate ? startDateCtr.text : endDateCtr.text),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      if (value != null) {
        final String formatted = formatter.format(value);
        if (isStartDate) {
          startDateCtr.text =
              CustomMethod.convertDateFormat(formatted, 'dd-MM-yyyy', 'dd, MMM-yyyy');
        } else {
          endDateCtr.text = CustomMethod.convertDateFormat(formatted, 'dd-MM-yyyy', 'dd, MMM-yyyy');
        }
      }
      isTabLoading.value = true;
      if (selectedStateIndex.value == 0) {
        apiLoader(asyncCall: () => getMyExerciseStats());
      } else {
        apiLoader(asyncCall: () => getMyNutritionalStats());
      }
    });
  }

  void getMyExerciseStats() {
    var body = {
      "traineeId": traineeId,
      "startDate": CustomMethod.convertDateFormat(
          startDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
      "endDate":
          CustomMethod.convertDateFormat(endDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
      "type": typeList[selectedTypeIndex.value]
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_STATS_DATA,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        distanceModel = statsDistanceModelFromJson(responseBody);
        isTabLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        // isTabLoading.value = false;
      },
    );
  }

  void getMyNutritionalStats() {
    var body = {
      "traineeId": traineeId,
      "startDate": CustomMethod.convertDateFormat(
          startDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
      "endDate":
          CustomMethod.convertDateFormat(endDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_NUTRITIONAL_STATS_DATA,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        nutritionalStatsModel = nutritionalStatsModelFromJson(responseBody);
        isTabLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        // isTabLoading.value = false;
      },
    );
  }
}
