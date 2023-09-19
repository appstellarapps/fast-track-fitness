import 'package:fasttrackfitness/app/modules/trainer/schedule/views/schedule_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/keyboard_avoider.dart';
import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> with ScheduleComponents {
  ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => Helper().hideKeyBoard(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomSheet: bottomButton(),
          backgroundColor: themeWhite,
          appBar: ScaffoldAppBar.appBar(
              title: controller.isTrainer == 1 ? "Schedule" : "Booking Details"),
          body: KeyboardAvoider(
            child: SingleChildScrollView(
              child: Obx(
                () => controller.isAppointmentLoading.value ||
                        controller.isScheduleLoading.value ||
                        controller.isLoading.value
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          scheduleView(),
                          Container(
                            height: 5,
                            color: colorGreyText,
                          ),
                          profileDetailsView()
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
