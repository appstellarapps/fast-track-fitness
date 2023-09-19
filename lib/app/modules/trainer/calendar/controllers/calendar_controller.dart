import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  var isDateTaped = false;
  var selectedFormattedDate = "".obs;
  var selectedStartDate = "".obs;
  var selectedEndDate = "".obs;
  var selectedDate = "".obs;
  var fromDateController = DateTime.now().obs;
  var toDateController = DateTime.now().obs;
  var isSDate;
  var isEDate;
  var selectedDateList = [];

  TextEditingController dateController = TextEditingController();

  final dateState = GlobalKey<CustomTextFormFieldState>();

  @override
  void onInit() {
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
