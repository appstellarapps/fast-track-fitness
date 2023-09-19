import 'package:fasttrackfitness/app/modules/trainee/profile/views/profile_view_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController>
    with ProfileViewComponents {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeWhite,
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => controller.isLoading.value
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    appBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorGrey, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              color: colorGrey,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("Personal Details",
                                          style: CustomTextStyles.semiBold(
                                              fontSize: 16.0,
                                              fontColor: themeBlack)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20.0),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: SvgPicture.asset(
                                                ImageResourceSvg.profile)),
                                        const SizedBox(width: 15.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Your Name",
                                              style: CustomTextStyles.normal(
                                                fontSize: 13.0,
                                                fontColor: colorGreyText,
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                FTFGlobal.userName.value,
                                                style:
                                                    CustomTextStyles.semiBold(
                                                  fontSize: 14.0,
                                                  fontColor: themeBlack,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: SvgPicture.asset(
                                                ImageResourceSvg.mobileNoIc)),
                                        const SizedBox(width: 15.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Mobile",
                                              style: CustomTextStyles.normal(
                                                fontSize: 13.0,
                                                fontColor: colorGreyText,
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                FTFGlobal.mobileNo.value,
                                                style:
                                                    CustomTextStyles.semiBold(
                                                  fontSize: 14.0,
                                                  fontColor: themeBlack,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: SvgPicture.asset(
                                                ImageResourceSvg.profileEmail)),
                                        const SizedBox(width: 15.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Email ID",
                                              style: CustomTextStyles.normal(
                                                fontSize: 13.0,
                                                fontColor: colorGreyText,
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                FTFGlobal.email.value,
                                                style:
                                                    CustomTextStyles.semiBold(
                                                  fontSize: 14.0,
                                                  fontColor: themeBlack,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(() => controller.userModel.value.result != null
                        ? badgeView()
                        : const SizedBox.shrink())
                  ],
                ),
        ),
      ),
    );
  }
}
