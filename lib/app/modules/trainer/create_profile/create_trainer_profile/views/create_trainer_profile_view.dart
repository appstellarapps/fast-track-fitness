
import 'package:fasttrackfitness/app/core/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_button.dart';
import '../controllers/create_trainer_profile_controller.dart';
import 'create_traniner_profile_components.dart';

class CreateTrainerProfileView extends GetView<CreateTrainerProfileController>
    with CreateTrainerProfileComponents {
  CreateTrainerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => willPop(),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => Helper().hideKeyBoard(),
            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  appBar(),
                  Obx(() => Expanded(
                      child: controller.profileType.value == "Professional"
                          ? professionalForm()
                          : personalForm()))
                  // formView(),
                ],
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
                child: ButtonRegular(
                    onPress: () {
                      Get.closeAllSnackbars();
                      if (controller.profileType.value == "Personal") {
                        if (controller.isPersonalDetailValid()) {
                          controller.profileType.value = "Professional";
                        }
                      } else {
                        if (controller.isProfessionalDetailValid()) {
                          if (controller.trainingTypeList.isEmpty) {
                            controller.profileType.value = "Professional";
                            showSnackBar(
                                title: "Error", message: "Please select your training type");
                          } else {
                            apiLoader(asyncCall: () => controller.editTrainingProfileAPI());
                          }
                        }
                      }
                    },
                    buttonText: "SUBMIT"),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            ),
          ),
        ));
  }
}
