import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/tdee/views/tdee_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tdee_controller.dart';

class TdeeView extends GetView<TdeeController> with TDEEComponents {
  TdeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              ScaffoldAppBar.appBar(
                  titleWidget: Column(
                children: [
                  Text(
                    "TDEE",
                    style: CustomTextStyles.bold(
                      fontSize: 20.0,
                      fontColor: Colors.white,
                    ),
                  ),
                  Text(
                    "Total Daily Energy Expenditure",
                    style: CustomTextStyles.normal(fontSize: 13.0, fontColor: Colors.white),
                  ),
                ],
              )),
              const SizedBox(
                height: 30.0,
              ),
              Obx(() => Text(
                    controller.mainTitle[controller.selectedStepsIndex.value - 1].title!,
                    style: CustomTextStyles.semiBold(fontSize: 15.0, fontColor: Colors.black),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userSteps(1),
                  const SizedBox(
                    width: 10,
                  ),
                  userSteps(2),
                  const SizedBox(
                    width: 10,
                  ),
                  userSteps(3),
                  const SizedBox(
                    width: 10,
                  ),
                  userSteps(4),
                ],
              ),
              Container(
                  width: Get.width * 0.9,
                  height: 2,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: const Color(0xfff9f9f9))),
              Obx(() => screenView())
            ],
          )),
    );
  }
}
