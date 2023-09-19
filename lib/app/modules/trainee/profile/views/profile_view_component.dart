import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/modules/trainee/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/constants.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../routes/app_pages.dart';

mixin ProfileViewComponents {
  var controller = Get.put(ProfileController());

  appBar() {
    return Container(
      decoration: const BoxDecoration(
        color: themeBlack,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(ImageResourceSvg.backArrowIc)),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      children: [
                        Obx(
                          () => circleProfileNetworkImage(
                            borderRadius: 15.0,
                            width: 100,
                            height: 100,
                            networkImage: FTFGlobal.userProfilePic.value,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  Get.toNamed(Routes.EDIT_PROFILE);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(ImageResourceSvg.editIc),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  badgeView() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xffF0F0F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffF0F0F0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                SvgPicture.asset(ImageResourceSvg.badge1),
                const SizedBox(width: 5.0),
                Text(
                  "Badges",
                  style: CustomTextStyles.semiBold(
                      fontSize: 14.0, fontColor: themeBlack),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 7.0),
            child: SizedBox(
                height: controller
                        .userModel.value.result!.user.userBadges.isNotEmpty
                    ? 50
                    : 62,
                child: controller
                        .userModel.value.result!.user.userBadges.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller
                            .userModel.value.result!.user.userBadges.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              controller.userModel.value.result!.user
                                  .userBadges[index].badgeUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        })
                    : noDataFound()),
          )
        ],
      ),
    );
  }
}
