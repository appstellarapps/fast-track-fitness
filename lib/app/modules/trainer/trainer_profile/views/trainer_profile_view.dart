import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/modules/trainer/trainer_profile/views/trainer_profile_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_button.dart';
import '../controllers/trainer_profile_controller.dart';

class TrainerProfileView extends GetView<TrainerProfileController> with TrainerProfileComponents {
  TrainerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeWhite,
        bottomSheet: Obx(
          () => controller.isLoading.value || !AppStorage.isLogin()
              ? const SizedBox.shrink()
              : AppStorage.userData.result!.user.id !=
                      controller.getMyTrainerProfileModel.result!.user.id
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        bottom: 28.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ButtonRegular(
                        buttonText: "Book Appointment",
                        onPress: () {
                          apiLoader(asyncCall: () => controller.bookAppointment());
                        },
                        isShadow: true,
                      ),
                    )
                  : const SizedBox.shrink(),
        ),
        body: SingleChildScrollView(
            child: Obx(() => controller.isLoading.value
                ? const SizedBox.shrink()
                : controller.isSelected.value == 0
                    ? normalTrainerProfile()
                    : professionalServiceView())),
      ),
    );
  }
}
