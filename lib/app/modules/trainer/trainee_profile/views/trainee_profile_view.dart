import 'package:fasttrackfitness/app/core/helper/colors.dart';

import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/modules/trainer/trainee_profile/views/trainee_profile_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../controllers/trainee_profile_controller.dart';

class TraineeProfileView extends GetView<TraineeProfileController> with TraineeProfileComponents {
  TraineeProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: themeWhite,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              appBar(),
              Expanded(
                child: Obx(
                  () => ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      itemBuilder: (context, index) {
                        return listItem(controller.diaryExercisesItems[index], index);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10.0);
                      },
                      itemCount: controller.diaryExercisesItems.length),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    launchEmail(controller.userEmail, "", "");
                  },
                  child: SizedBox(
                      height: 35, width: 35, child: SvgPicture.asset(ImageResourceSvg.icAtTheRate)),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    launchCall(controller.phoneNo);
                  },
                  child: SizedBox(
                      height: 35, width: 35, child: SvgPicture.asset(ImageResourceSvg.call)),
                ),
              ],
            ),
          )),
    );
  }
}
