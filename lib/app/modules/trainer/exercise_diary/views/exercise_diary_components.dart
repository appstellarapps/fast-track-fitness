import 'package:fasttrackfitness/app/core/helper/colors.dart';

import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/modules/trainer/exercise_diary/controllers/exercise_diary_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../routes/app_pages.dart';

mixin ExerciseDiaryComponents {
  var controller = Get.put(ExerciseDiaryController());

  Widget searchItem(searchUser, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.TRAINEE_PROFILE, arguments: [
          controller.isFrom,
          searchUser.profileImage,
          searchUser.fullName,
          searchUser.fullNumber,
          searchUser.id,
          searchUser.email
        ]);
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: circleProfileNetworkImage(
                  networkImage: searchUser.profileImage,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchUser.fullName,
                      style: CustomTextStyles.semiBold(
                        fontSize: 16.0,
                        fontColor: themeBlack,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      searchUser.fullNumber,
                      style: CustomTextStyles.medium(
                        fontSize: 14.0,
                        fontColor: themeBlack,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                  onTap: () async {
                    launchCall(searchUser.fullNumber.toString());
                  },
                  child: SizedBox(
                      height: 35, width: 35, child: SvgPicture.asset(ImageResourceSvg.call)))
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 1,
            color: themeLightWhite,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  var searchCommonBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xffE6E6E6),
      ));
}
