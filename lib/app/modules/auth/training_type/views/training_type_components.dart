import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../data/common/common_models.dart';
import '../../../../data/training_type_model.dart';
import '../../../trainer/create_profile/create_trainer_profile/controllers/create_trainer_profile_controller.dart';

mixin TrainingTypeComponents {
  trainingTypeItem(TrainingTypes trainingTyp) {
    return Obx(
      () => InkWell(
        onTap: () {
          trainingTyp.isSelected.value = !trainingTyp.isSelected.value;
          var trainerController = Get.put(CreateTrainerProfileController());
          if (trainingTyp.isSelected.value == true) {
            trainerController.trainingTypeList.add(EditTrainingTypeListModel(
                id: trainingTyp.id,
                title: trainingTyp.title,
                inputController: TextEditingController(),
                price: ""));
          } else {
            for (int i = 0; i < trainerController.trainingTypeList.length; i++) {
              if (trainerController.trainingTypeList[i].id == trainingTyp.id) {
                trainerController.trainingTypeList.removeAt(i);
              }
            }
          }
        },
        child: SizedBox(
          height: 30,
          child: Row(
            children: [
              SvgPicture.asset(
                trainingTyp.isSelected.value
                    ? ImageResourceSvg.icCheck
                    : ImageResourceSvg.icUncheck,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  " ${trainingTyp.title}",
                  style: CustomTextStyles.semiBold(
                    fontColor: trainingTyp.isSelected.value ? const Color(0xff818181) : themeBlack,
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  var searchCommonBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xffE6E6E6),
      ));
}
