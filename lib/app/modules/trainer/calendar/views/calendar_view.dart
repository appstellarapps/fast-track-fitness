import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/calendar_controller.dart';
import 'calendar_components.dart';

class CalendarView extends GetView<CalendarController> with CalendarComponents {
  CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: themeWhite,
          resizeToAvoidBottomInset: false,
          appBar: ScaffoldAppBar.appBar(title: "Select Date"),
          body: commonDateSelectBottomSheet(
              mode: DateRangePickerSelectionMode.range,
              enablePasDate: false,
              maxDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month + 1,
                  DateTime.now()
                      .day)) /*.then((val) {
            if (val != null) {
              dateSelect(val);
            }
          })*/
          ),
    );
  }
}
