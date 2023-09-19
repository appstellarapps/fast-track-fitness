import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';

import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

mixin GlobalSearchComponents {
  Widget searchItem(searchUser, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.TRAINER_PROFILE, arguments: searchUser.id);
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
                      searchUser.title,
                      style: CustomTextStyles.normal(
                        fontSize: 14.0,
                        fontColor: themeGrey,
                      ),
                    )
                  ],
                ),
              )
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
