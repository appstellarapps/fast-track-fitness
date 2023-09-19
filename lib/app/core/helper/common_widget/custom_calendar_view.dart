import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../colors.dart';
import '../text_style.dart';
import 'custom_app_widget.dart';

//@dart = 2.9
class CommonSelectDate extends StatefulWidget {
  CommonSelectDate({
    Key? key,
    required this.mode,
    this.initialSelectedDate,
    this.isStartDate = false,
    this.isFromDate = false,
    this.isToDate = false,
    this.isFromAddedExpenseList = false,
    this.isEndDate = false,
    this.maxDate,
    this.minDate,
    this.selectedDate,
    this.enablePasDate = false,
  }) : super(key: key);
  final DateRangePickerSelectionMode mode;
  final initialSelectedDate;
  bool isStartDate = false;
  bool isFromDate = false;
  bool isToDate = false;
  bool isFromAddedExpenseList = false;
  bool isEndDate = false;
  var minDate;
  var maxDate;
  var selectedDate;
  bool enablePasDate = false;
  static var selectedStartDate = "".obs;
  static var selectedFormattedDate = "".obs;
  var fromDateController = DateTime.now().obs;
  var toDateController = DateTime.now().obs;
  var selectedEndDate = "".obs;

  @override
  _CommonSelectDateState createState() => _CommonSelectDateState();
}

class _CommonSelectDateState extends State<CommonSelectDate> {
  static var isDateTaped = false;
  static var isSDate = false;
  static var isEDate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppBar.appBar(
        title: "Select Date",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SfDateRangePicker(
            showTodayButton: true,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              isDateTaped = true;

              if (args.value is PickerDateRange) {
                print(args.value);
                if (isSDate) {
                  CommonSelectDate.selectedStartDate.value = args.value.startDate.toString();
                } //yyyy-mm-dd 00:00:00
                if (isEDate) {
                  CommonSelectDate.selectedStartDate.value =
                      args.value.endDate ?? args.value.startDate.toString();
                }

                CommonSelectDate.selectedStartDate.value = args.value.startDate.toString() +
                    'to' +
                    (args.value.endDate ?? args.value.startDate).toString();

                CommonSelectDate.selectedFormattedDate.value =
                    '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} to ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
              } else if (args.value is DateTime) {
                if (widget.isFromDate) widget.fromDateController.value = args.value;
                if (widget.isToDate) widget.toDateController.value = args.value;

                CommonSelectDate.selectedFormattedDate.value =
                    DateFormat('dd/MM/yyyy').format(args.value).toString();
                widget.selectedDate.value = DateFormat('dd/MM/yyyy').format(args.value).toString();

                if (isSDate) CommonSelectDate.selectedStartDate.value = args.value.toString();
                if (isEDate) widget.selectedEndDate.value = args.value.toString();
              }
            },
            // _onSelectionChanged(isFrom: isFromDate, isTo: isToDate),
            selectionMode: widget.mode,
            selectionRadius: 4.0,

            selectionShape: DateRangePickerSelectionShape.rectangle,
            initialSelectedDate: widget.initialSelectedDate,
            todayHighlightColor: themeBlack,
            endRangeSelectionColor: themeBlack,
            startRangeSelectionColor: themeBlack,

            selectionColor: themeWhite,
            rangeSelectionColor: Colors.grey,
            selectionTextStyle: CustomTextStyles.medium(
              fontSize: 16.0,
              fontColor: themeWhite,
            ),

            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: CustomTextStyles.medium(fontColor: themeBlack, fontSize: 16.0),
              weekendTextStyle: CustomTextStyles.medium(fontColor: Colors.red, fontSize: 16.0),
            ),
            enablePastDates: widget.enablePasDate,
            minDate: widget.minDate,
            maxDate: widget.maxDate,
          ),
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
                    child: const Text("Cancel"),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    print(CommonSelectDate.selectedFormattedDate.value);
                    if (widget.isFromDate) {
                      if (widget.fromDateController.value == null) {
                        widget.fromDateController.value = widget.initialSelectedDate;
                      }
                    }
                    if (widget.isToDate) {
                      if (widget.toDateController.value == null) {
                        widget.toDateController.value = widget.initialSelectedDate;
                      }
                    }
                    if (!isDateTaped) {
                      if (widget.isFromDate) widget.fromDateController.value = DateTime.now();
                      if (widget.isToDate) widget.toDateController.value = DateTime.now();
                    }
                    Get.back(result: CommonSelectDate.selectedFormattedDate.value);
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
                    child: Text("Apply"),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
