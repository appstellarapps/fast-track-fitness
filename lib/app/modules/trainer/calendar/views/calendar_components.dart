import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainer/calendar/controllers/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

mixin CalendarComponents {
  var controller = Get.put(CalendarController());

  commonDateSelectBottomSheet(
      {DateRangePickerSelectionMode? mode,
      initialSelectedDate,
      isStartDate = false,
      isFromDate = false,
      isToDate = false,
      isFromAddedExpenseList = false,
      isEndDate = false,
      minDate,
      maxDate,
      selectedDate,
      PickerDateRange? initialSelectedDateRange,
      bool enablePasDate = false}) {
    controller.isDateTaped = false;
    initialSelectedDate ??= DateTime.now();
    controller.selectedFormattedDate.value =
        DateFormat('dd/MM/yyyy').format(initialSelectedDate).toString();

    controller.selectedDate.value = DateFormat('dd/MM/yyyy').format(initialSelectedDate).toString();
    if (isStartDate) controller.selectedStartDate.value = initialSelectedDate.toString();
    if (isEndDate) controller.selectedEndDate.value = initialSelectedDate.toString();

    controller.isSDate = isStartDate;
    controller.isEDate = isEndDate;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(38),
          topRight: Radius.circular(38),
        ),
        color: themeWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                controller.isDateTaped = true;
                if (args.value is PickerDateRange) {
                  if (controller.isSDate) {
                    controller.selectedStartDate.value =
                        args.value.startDate.toString(); //yyyy-mm-dd 00:00:00
                  }
                  if (controller.isEDate) {
                    controller.selectedEndDate.value = args.value.endDate.toString();
                  }

                  controller.selectedDate.value =
                      '${args.value.startDate}to${args.value.endDate ?? args.value.startDate}';

                  controller.selectedFormattedDate.value =
                      '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} to ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
                } else if (args.value is DateTime) {
                  if (isFromDate) controller.fromDateController.value = args.value;
                  if (isToDate) controller.toDateController.value = args.value;

                  controller.selectedFormattedDate.value =
                      DateFormat('dd/MM/yyyy').format(args.value).toString();
                  controller.selectedDate.value =
                      DateFormat('dd/MM/yyyy').format(args.value).toString();

                  if (controller.isSDate)
                    controller.selectedStartDate.value = args.value.toString();
                  if (controller.isEDate) controller.selectedEndDate.value = args.value.toString();
                }
              },
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionRadius: 10,
              selectionMode: mode!,
              initialSelectedDate: initialSelectedDate,
              initialSelectedRange: initialSelectedDateRange,
              todayHighlightColor: themeGrey,
              selectionColor: themeGrey,
              rangeSelectionColor: themeLightWhite,
              startRangeSelectionColor: themeBlack,
              endRangeSelectionColor: themeBlack,
              rangeTextStyle: const TextStyle(color: themeWhite),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: CustomTextStyles.medium(fontColor: themeBlack, fontSize: 16.0),
                weekendTextStyle: CustomTextStyles.medium(fontColor: Colors.red, fontSize: 16.0),
              ),
              enablePastDates: enablePasDate,
              minDate: minDate,
              maxDate: maxDate,
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Container(
            decoration: const BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (isFromDate) {
                      controller.fromDateController.value;
                    }
                    if (isToDate) {
                      controller.toDateController.value;
                    }
                    if (!controller.isDateTaped) {
                      if (isFromDate) controller.fromDateController.value = DateTime.now();
                      if (isToDate) controller.toDateController.value = DateTime.now();
                    }
                    //
                    //
                    // if (isFromAddedExpenseList)
                    //   Get.back();
                    // else
                    Get.back(result: controller.selectedFormattedDate.value);
                  },
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: themeGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text("Apply",
                        style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0)),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void dateSelect(val) {
    controller.selectedDateList.clear();

    var date = val.split("to");

    if (date[0].trim() == date[1].trim()) {
      controller.dateController.text = date[0];
      controller.selectedDateList
          .add({"date": controller.dateController.text, "leaveType": "Full Day"});
    } else {
      controller.dateController.text = val;
      var minRangeDate = DateTime.parse(controller.selectedDate.value.split('to')[0]);
      var maxRangeDate = DateTime.parse(controller.selectedDate.value.split('to')[1]);
      for (int i = 0; i <= maxRangeDate.difference(minRangeDate).inDays; i++) {
        var date = DateFormat("dd/MM/yyy").format(DateTime.parse(minRangeDate
            .add(
              Duration(
                days: i,
              ),
            )
            .toString()));
        var selectDate = DateTime.parse(minRangeDate
            .add(
              Duration(
                days: i,
              ),
            )
            .toString());
        var dayFind = DateFormat('EEEE').format(selectDate);

        controller.selectedDateList
            .add({"date": date.toString(), "leaveType": "Full Day", "day": dayFind});
      }
    }
    controller.dateState.currentState!.checkValidation();
  }
}
