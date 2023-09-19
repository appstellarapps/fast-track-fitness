import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/colors.dart';

import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/helper/image_custom_cropper.dart';
import '../controllers/edit_profile_controller.dart';

mixin EditProfileViewComponents {
  var controller = Get.put(EditProfileController());

  inputTitle(icon, title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: CustomTextStyles.semiBold(
              fontSize: 16.0,
              fontColor: grey50,
            ),
          ),
        ],
      ),
    );
  }

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
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: InkWell(
                          onTap: () {
                            imageUploadOptionSheet(onPressTitle1: () {
                              getImage(ImageSource.camera);
                            }, onPressTitle2: () {
                              getImage(ImageSource.gallery);
                            });
                          },
                          child: Stack(children: [
                            circleProfileNetworkImage(
                              borderRadius: 15.0,
                              width: 100,
                              height: 100,
                              networkImage: FTFGlobal.userProfilePic.value,
                              fit: BoxFit.cover,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                                decoration: const BoxDecoration(
                                  color: themeGreen,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(22),
                                    bottomRight: Radius.circular(22),
                                  ),
                                ),
                                child: Text(
                                  "Upload",
                                  style: CustomTextStyles.normal(
                                    fontSize: 12.0,
                                    fontColor: themeBlack,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ]),
                        )),
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ),
          const SizedBox(width: 35)
        ],
      ),
    );
  }

  getImage(ImageSource source) async {
    Helper().hideKeyBoard();
    if (Get.isBottomSheetOpen!) Get.back();

    File profileImage;
    final pickedFile = await CustomImageCropper().imagePicker(source);

    if (pickedFile != null && pickedFile.isNotEmpty) {
      profileImage = File(pickedFile);

      controller.selectedProfile.value = profileImage;
      apiLoader(
          asyncCall: () => controller.callUploadProfileFileAPI(controller.selectedProfile.value));
    }
  }
}
