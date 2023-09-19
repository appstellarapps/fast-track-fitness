import 'package:fasttrackfitness/app/modules/trainer/my_booking/views/my_booking_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/my_booking_controller.dart';

class MyBookingView extends GetView<MyBookingController> with MyBookingComponents {
  MyBookingView({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeWhite,
      appBar: ScaffoldAppBar.appBar(title: "My Bookings"),
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18)),
            color: themeWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
                //   offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 30, bottom: 40, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomItem("Ongoing", 0),
              bottomItem("Pending", 1),
              bottomItem("History", 2),
              bottomItem("Appointment", 3),
            ],
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : SafeArea(
                child: controller.selectedIndex.value == 0
                    ? onGoingList()
                    : controller.selectedIndex.value == 1
                        ? pendingList()
                        : controller.selectedIndex.value == 2
                            ? historyList()
                            : appointment()),
      ),
    );
  }
}
