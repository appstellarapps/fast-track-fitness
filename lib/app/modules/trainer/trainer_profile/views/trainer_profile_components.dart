import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/custom_method.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/pdf_viewer.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/trainer_profile_controller.dart';

mixin TrainerProfileComponents {
  var controller = Get.put(TrainerProfileController());

  profileTopView() {
    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                width: Get.width,
                height: 280,
                decoration: const BoxDecoration(
                  color: themeBlack,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Stack(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(ImageResourceSvg.back)),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          circleProfileNetworkImage(
                              networkImage: controller.getMyTrainerProfileModel
                                  .result!.user.profileImage,
                              height: 100,
                              width: 100,
                              borderRadius: 20.0),
                          const SizedBox(height: 20.0),
                          Text(
                            controller
                                .getMyTrainerProfileModel.result!.user.fullName,
                            style: CustomTextStyles.semiBold(
                                fontSize: 20.0, fontColor: themeWhite),
                          ),
                          Text(
                            controller.getMyTrainerProfileModel.result!.user
                                .userSpecialist.title,
                            style: CustomTextStyles.normal(
                                fontSize: 12.0, fontColor: themeWhite),
                          ),
                          const SizedBox(height: 40.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 210),
              child: Container(
                margin: const EdgeInsets.only(
                    bottom: 20.0, right: 20.0, left: 20.0),
                width: Get.width,
                decoration: BoxDecoration(
                  color: themeWhite,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 180, 178, 178),
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        10.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Obx(
                          () =>
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffE6E6E6),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller.isSelected.value = 0;
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: controller.isSelected.value == 0
                                            ? themeGreen
                                            : const Color(0xffE6E6E6),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Trainer Profile",
                                          style: CustomTextStyles.semiBold(
                                              fontSize: 14.0,
                                              fontColor: themeBlack),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller.isSelected.value = 1;
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: controller.isSelected.value == 1
                                            ? themeGreen
                                            : const Color(0xffE6E6E6),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Professional Services",
                                          textAlign: TextAlign.center,
                                          style: CustomTextStyles.semiBold(
                                              fontSize: 14.0,
                                              fontColor: themeBlack),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    ),
                    Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(top: 8.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          color: themeWhite,
                        ),
                        child: controller.isSelected.value == 0
                            ? trainerTopView()
                            : trainerProfessionalView()),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  contactDetailsView() {
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
                SvgPicture.asset(ImageResourceSvg.profilePhone),
                const SizedBox(width: 5.0),
                Text(
                  "Contact Details",
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(ImageResourceSvg.profilePhoneTwo),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mobile",
                          style: CustomTextStyles.normal(
                              fontSize: 12.0, fontColor: themeGrey),
                        ),
                        Text(
                          controller
                              .getMyTrainerProfileModel.result!.user.phoneNumber
                              .toString(),
                          style: CustomTextStyles.semiBold(
                              fontSize: 12.0, fontColor: themeBlack),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(ImageResourceSvg.profileEmail),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email ID",
                          style: CustomTextStyles.normal(
                              fontSize: 12.0, fontColor: themeGrey),
                        ),
                        Text(
                          controller.getMyTrainerProfileModel.result!.user.email
                              .toString(),
                          style: CustomTextStyles.semiBold(
                              fontSize: 12.0, fontColor: themeBlack),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(ImageResourceSvg.profileLocation),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style: CustomTextStyles.normal(
                                fontSize: 12.0, fontColor: themeGrey),
                          ),
                          Text(
                            controller
                                .getMyTrainerProfileModel.result!.user.address
                                .toString(),
                            style: CustomTextStyles.semiBold(
                                fontSize: 12.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  professionQualification() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xffF0F0F0)),
      ),
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
                SvgPicture.asset(ImageResourceSvg.qualification),
                const SizedBox(width: 5.0),
                Text(
                  "Professional Qualifications",
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 20.0),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SvgPicture.asset(ImageResourceSvg.certificate),
                //     const SizedBox(
                //       width: 20.0,
                //     ),
                //     Expanded(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             controller
                //                 .getMyTrainerProfileModel.result!.user.qualificationFileDescription,
                //             style: CustomTextStyles.normal(
                //                 fontSize: 12.0, fontColor: themeGrey),
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                // const SizedBox(height: 10.0),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: controller.getMyTrainerProfileModel.result!.user
                      .userQualificationFiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PdfViewer(
                                    controller
                                        .getMyTrainerProfileModel
                                        .result!
                                        .user
                                        .userQualificationFiles[index]
                                        .qulificationfileUrl,
                                    controller
                                        .getMyTrainerProfileModel
                                        .result!
                                        .user
                                        .userQualificationFiles[index]
                                        .qualificationFile),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageResourceSvg.certificate),
                          Expanded(
                            child: Text(
                              '  • ${controller.getMyTrainerProfileModel.result!
                                  .user.userQualificationFiles[index].title}',
                              style: CustomTextStyles.semiBold(
                                  fontSize: 14.0, fontColor: themeBlack),
                            ),
                          ),
                          controller.getMyTrainerProfileModel.result!.user
                              .userQualificationFiles[index].status ==
                              "Approved"
                              ? SvgPicture.asset(ImageResourceSvg.selected)
                              : controller
                              .getMyTrainerProfileModel
                              .result!
                              .user
                              .userQualificationFiles[index]
                              .status ==
                              "Pending"
                              ? SvgPicture.asset(
                            ImageResourceSvg.pending,
                          )
                              : SvgPicture.asset(ImageResourceSvg.rejected)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 5);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  certificationInsuranceView() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xffF0F0F0)),
      ),
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
                SvgPicture.asset(ImageResourceSvg.qualification),
                const SizedBox(width: 5.0),
                Text(
                  "Certificate of Insurance (COI)",
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 20.0),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SvgPicture.asset(ImageResourceSvg.certificate),
                //     const SizedBox(
                //       width: 20.0,
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Certificate III Sport Sciences",
                //           style: CustomTextStyles.normal(
                //               fontSize: 12.0, fontColor: themeGrey),
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                // const SizedBox(height: 10.0),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: controller.getMyTrainerProfileModel.result!.user
                      .userInsuranceFiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PdfViewer(
                                    controller
                                        .getMyTrainerProfileModel
                                        .result!
                                        .user
                                        .userInsuranceFiles[index]
                                        .qulificationfileUrl,
                                    controller
                                        .getMyTrainerProfileModel
                                        .result!
                                        .user
                                        .userInsuranceFiles[index]
                                        .qualificationFile),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageResourceSvg.certificate),
                          Expanded(
                            child: Text(
                              '  • ${controller.getMyTrainerProfileModel.result!
                                  .user.userInsuranceFiles[index].title}',
                              style: CustomTextStyles.semiBold(
                                  fontSize: 14.0, fontColor: themeBlack),
                            ),
                          ),
                          controller.getMyTrainerProfileModel.result!.user
                              .userInsuranceFiles[index].status ==
                              "Approved"
                              ? SvgPicture.asset(ImageResourceSvg.selected)
                              : controller.getMyTrainerProfileModel.result!.user
                              .userInsuranceFiles[index].status ==
                              "Pending"
                              ? SvgPicture.asset(
                            ImageResourceSvg.pending,
                          )
                              : SvgPicture.asset(ImageResourceSvg.rejected)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 5);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  trainerAvailability() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xffF0F0F0)),
      ),
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
                SvgPicture.asset(ImageResourceSvg.availability),
                const SizedBox(width: 5.0),
                Text(
                  "Trainer Availability",
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(ImageResourceSvg.clock1),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${controller.getMyTrainerProfileModel.result!.user
                              .userShiftTimming
                              .morningStartTime} am - ${controller
                              .getMyTrainerProfileModel.result!.user
                              .userShiftTimming.morningEndTime} am",
                          style: CustomTextStyles.semiBold(
                              fontSize: 12.0, fontColor: themeBlack),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.getMyTrainerProfileModel.result!.user
                        .userShiftTimming.morningWeek.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: themeBlack),
                        child: Center(
                          child: Text(
                            controller.getMyTrainerProfileModel.result!.user
                                .userShiftTimming.morningWeek[index],
                            style: CustomTextStyles.semiBold(
                                fontSize: 12.0, fontColor: themeWhite),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 10);
                    },
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(ImageResourceSvg.clock1),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${controller.getMyTrainerProfileModel.result!.user
                              .userShiftTimming.eveningStartTime} pm - "
                              "${controller.getMyTrainerProfileModel.result!
                              .user.userShiftTimming.eveningEndTime} pm",
                          style: CustomTextStyles.semiBold(
                              fontSize: 12.0, fontColor: themeBlack),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.getMyTrainerProfileModel.result!.user
                        .userShiftTimming.eveningWeek.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: themeBlack),
                        child: Center(
                          child: Text(
                            controller.getMyTrainerProfileModel.result!.user
                                .userShiftTimming.eveningWeek[index],
                            style: CustomTextStyles.semiBold(
                                fontSize: 12.0, fontColor: themeWhite),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 10);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  trainerTopView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                controller.getMyTrainerProfileModel.result!.user.age.toString(),
                style: CustomTextStyles.semiBold(
                    fontSize: 15.0, fontColor: themeBlack),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "Age",
                style: CustomTextStyles.normal(
                    fontSize: 12.0, fontColor: themeGrey),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                controller.getMyTrainerProfileModel.result!.user.gender,
                style: CustomTextStyles.semiBold(
                    fontSize: 15.0, fontColor: themeBlack),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "Gender",
                style: CustomTextStyles.normal(
                    fontSize: 12.0, fontColor: themeGrey),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "${controller.getMyTrainerProfileModel.result!.user
                    .expInYear} yrs",
                style: CustomTextStyles.semiBold(
                    fontSize: 15.0, fontColor: themeBlack),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "Exp.",
                style: CustomTextStyles.normal(
                    fontSize: 12.0, fontColor: themeGrey),
              ),
            ],
          )
        ],
      ),
    );
  }

  trainerProfessionalView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        overlayContainerItem(
            "Ratings",
            controller.getMyTrainerProfileModel.result!.user.averageRatting ==
                "null"
                ? "0.0"
                : controller
                .getMyTrainerProfileModel.result!.user.averageRatting,
            hasIconWithText: true,
            icon: ImageResourceSvg.starIc),
        overlayContainerItem("Verified", "",
            hasIcon: true, icon: ImageResourceSvg.approvedIc),
        // overlayContainerItem("Badge", "", hasIcon: true, icon: ImageResourceSvg.badgeIc),
      ],
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
                height: controller.getMyTrainerProfileModel.result!.user
                    .userBadges.isNotEmpty
                    ? 50
                    : 62,
                child: controller.getMyTrainerProfileModel.result!.user
                    .userBadges.isNotEmpty
                    ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.getMyTrainerProfileModel.result!
                        .user.userBadges.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 60,
                        width: 55,
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            Image.network(
                              controller.getMyTrainerProfileModel.result!
                                  .user.userBadges[index].badgeUrl,
                              fit: BoxFit.cover,
                            ),
                            controller.getMyTrainerProfileModel.result!.user
                                .userBadges[index].type == "Review" &&
                                controller
                                .getMyTrainerProfileModel
                                .result!
                                .user
                                .userBadges[index]
                                .badgeCount != 0
                                ? Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      color: themeGrey,
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                  child: Text(
                                    controller
                                        .getMyTrainerProfileModel
                                        .result!
                                        .user
                                        .userBadges[index]
                                        .badgeCount
                                        .toString(),
                                    style: CustomTextStyles.semiBold(
                                      fontSize: 10.0,
                                      fontColor: themeWhite,
                                    ),
                                  ),
                                ))
                                : const SizedBox.shrink()
                          ],
                        ),
                      );
                    })
                    : noDataFound()),
          )
        ],
      ),
    );
  }

  trainingTypeView() {
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
                SvgPicture.asset(ImageResourceSvg.weight),
                const SizedBox(width: 5.0),
                Text(
                  "Training Type",
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
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.getMyTrainerProfileModel.result!.user
                  .userTrainingTypes.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        "• ${controller.getMyTrainerProfileModel.result!.user
                            .userTrainingTypes[index].trainingType.title}",
                        style: CustomTextStyles.semiBold(
                            fontSize: 13.0, fontColor: themeBlack),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "AU\$",
                            style: CustomTextStyles.semiBold(
                                fontSize: 13.0, fontColor: grey50),
                          ),
                          TextSpan(
                            text: controller.getMyTrainerProfileModel.result!
                                .user.userTrainingTypes[index].price
                                .toString(),
                            style: CustomTextStyles.bold(
                                fontSize: 13.0, fontColor: themeBlack),
                          ),
                          TextSpan(
                            text:
                            " / ${controller.getMyTrainerProfileModel.result!
                                .user.userTrainingTypes[index].priceOption}",
                            style: CustomTextStyles.semiBold(
                                fontSize: 13.0, fontColor: grey50),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const Divider(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  trainingModeView() {
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
                SvgPicture.asset(ImageResourceSvg.gps),
                const SizedBox(width: 5.0),
                Text(
                  "Training Mode",
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
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 0,
                  childAspectRatio: 8.0),
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.getMyTrainerProfileModel.result!.user
                  .userTrainingModes.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  "• ${controller.getMyTrainerProfileModel.result!.user
                      .userTrainingModes[index].trainingMode.title}",
                  style: CustomTextStyles.semiBold(
                      fontSize: 14.0, fontColor: themeBlack),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  galleryView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              SvgPicture.asset(ImageResourceSvg.gallery),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  "Gallery",
                  style: CustomTextStyles.semiBold(
                      fontSize: 15.0, fontColor: themeBlack),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.MEDIA, arguments: [
                    "media",
                    controller.getMyTrainerProfileModel.result!.user.id,
                    controller.getMyTrainerProfileModel.result!.user
                        .usertrainerMedia.length,
                    controller.getMyTrainerProfileModel.result!.user
                        .userAchievementFiles.length
                  ]);
                },
                child: controller.getMyTrainerProfileModel.result!.user
                    .usertrainerMediaCount >
                    5
                    ? Text(
                  "View all >",
                  style: CustomTextStyles.semiBold(
                      fontSize: 14.0, fontColor: themeBlack),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        controller.getMyTrainerProfileModel.result!.user.usertrainerMedia
            .isNotEmpty
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 140.0,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    if (controller.getMyTrainerProfileModel.result!.user
                        .usertrainerMedia[index].mediaFileType ==
                        "Video") {
                      Get.toNamed(Routes.VIDEO_PLAYER, arguments: [
                        controller.getMyTrainerProfileModel.result!.user
                            .usertrainerMedia[index].mediaFileUrl,
                        controller.getMyTrainerProfileModel.result!.user
                            .usertrainerMedia[index].title,
                        controller.getMyTrainerProfileModel.result!.user
                            .usertrainerMedia[index].createdDateFormat
                      ]);
                    } else {
                      await CustomMethod.showFullImages(controller
                          .getMyTrainerProfileModel
                          .result!
                          .user
                          .usertrainerMedia[index]
                          .mediaFileUrl);
                    }
                  },
                  child: SizedBox(
                    width: 180.0,
                    height: 140.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          mediaNetworkImage(
                              networkImage: controller
                                  .getMyTrainerProfileModel
                                  .result!
                                  .user
                                  .usertrainerMedia[index]
                                  .thumbnailFileUrl
                                  .isNotEmpty
                                  ? controller
                                  .getMyTrainerProfileModel
                                  .result!
                                  .user
                                  .usertrainerMedia[index]
                                  .thumbnailFileUrl
                                  : controller
                                  .getMyTrainerProfileModel
                                  .result!
                                  .user
                                  .usertrainerMedia[index]
                                  .mediaFileUrl,
                              borderRadius: 10.0,
                              width: 180,
                              height: 140),
                          controller
                              .getMyTrainerProfileModel
                              .result!
                              .user
                              .usertrainerMedia[index]
                              .mediaFileType ==
                              "Video"
                              ? Positioned(
                              child: SvgPicture.asset(
                                  ImageResourceSvg.icPlay))
                              : const SizedBox.shrink(),
                          Positioned(
                            bottom: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 160,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                color: themeBlack,
                              ),
                              child: Text(
                                controller
                                    .getMyTrainerProfileModel
                                    .result!
                                    .user
                                    .usertrainerMedia[index]
                                    .title,
                                style: CustomTextStyles.semiBold(
                                    fontSize: 14.0,
                                    fontColor: themeWhite),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: controller.getMyTrainerProfileModel.result!.user
                  .usertrainerMedia.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        )
            : noDataFound()
      ],
    );
  }

  achievementCaseStudy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              SvgPicture.asset(ImageResourceSvg.award),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  "Achievements / Case Studies",
                  style: CustomTextStyles.semiBold(
                      fontSize: 15.0, fontColor: themeBlack),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.MEDIA, arguments: [
                    "achievement",
                    controller.getMyTrainerProfileModel.result!.user.id,
                    controller.getMyTrainerProfileModel.result!.user
                        .usertrainerMedia.length,
                    controller.getMyTrainerProfileModel.result!.user
                        .userAchievementFiles.length
                  ]);
                },
                child: controller.getMyTrainerProfileModel.result!.user
                    .userAchievementFilesCount >
                    5
                    ? Text(
                  "View all >",
                  style: CustomTextStyles.semiBold(
                      fontSize: 14.0, fontColor: themeBlack),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        controller.getMyTrainerProfileModel.result!.user.userAchievementFiles
            .isNotEmpty
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 140.0,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    if (controller
                        .getMyTrainerProfileModel
                        .result!
                        .user
                        .userAchievementFiles[index]
                        .achievementType ==
                        "Video") {
                      Get.toNamed(Routes.VIDEO_PLAYER, arguments: [
                        controller
                            .getMyTrainerProfileModel
                            .result!
                            .user
                            .userAchievementFiles[index]
                            .achievementFileUrl,
                        controller.getMyTrainerProfileModel.result!.user
                            .userAchievementFiles[index].title,
                        controller.getMyTrainerProfileModel.result!.user
                            .userAchievementFiles[index].createdDateFormat
                      ]);
                    } else {
                      await CustomMethod.showFullImages(controller
                          .getMyTrainerProfileModel
                          .result!
                          .user
                          .userAchievementFiles[index]
                          .achievementFileUrl);
                    }
                  },
                  child: SizedBox(
                    width: 180.0,
                    height: 140.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          mediaNetworkImage(
                              networkImage: controller
                                  .getMyTrainerProfileModel
                                  .result!
                                  .user
                                  .userAchievementFiles[index]
                                  .thumbnailFileUrl
                                  .isNotEmpty
                                  ? controller
                                  .getMyTrainerProfileModel
                                  .result!
                                  .user
                                  .userAchievementFiles[index]
                                  .thumbnailFileUrl
                                  : controller
                                  .getMyTrainerProfileModel
                                  .result!
                                  .user
                                  .userAchievementFiles[index]
                                  .achievementFileUrl,
                              borderRadius: 10.0,
                              width: 180,
                              height: 140),
                          controller
                              .getMyTrainerProfileModel
                              .result!
                              .user
                              .userAchievementFiles[index]
                              .achievementType ==
                              "Video"
                              ? Positioned(
                              child: SvgPicture.asset(
                                  ImageResourceSvg.icPlay))
                              : const SizedBox.shrink(),
                          Positioned(
                            bottom: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 160,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                color: themeBlack,
                              ),
                              child: Text(
                                controller
                                    .getMyTrainerProfileModel
                                    .result!
                                    .user
                                    .userAchievementFiles[index]
                                    .title,
                                style: CustomTextStyles.semiBold(
                                    fontSize: 14.0,
                                    fontColor: themeWhite),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: controller.getMyTrainerProfileModel.result!.user
                  .userAchievementFiles.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        )
            : noDataFound()
      ],
    );
  }

  reviewView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              SvgPicture.asset(ImageResourceSvg.massage),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  "Reviews",
                  style: CustomTextStyles.semiBold(
                      fontSize: 15.0, fontColor: themeBlack),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.REVIEW_LIST, arguments: [
                    controller.getMyTrainerProfileModel.result!.user.id
                  ]);
                },
                child: Text(
                  "View all >",
                  style: CustomTextStyles.semiBold(
                      fontSize: 14.0, fontColor: themeBlack),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
            height: 130,
            child: controller.getMyTrainerProfileModel.result!.user
                .trainerReview.isNotEmpty
                ? ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                scrollDirection: Axis.horizontal,
                itemCount: controller.getMyTrainerProfileModel.result!.user
                    .trainerReview.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    width: Get.width / 1.5,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xffF9F9F9)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonRatingBar(
                                ignoreGestures: true,
                                initialRating: double.parse(controller
                                    .getMyTrainerProfileModel
                                    .result!
                                    .user
                                    .trainerReview[index]
                                    .ratting
                                    .toString()),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.getMyTrainerProfileModel.result!
                                    .user.trainerReview[index].description,
                                maxLines: 2,
                                style: CustomTextStyles.normal(
                                    fontSize: 13.0, fontColor: themeBlack),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "~ ${controller.getMyTrainerProfileModel.result!
                                    .user.trainerReview[index].trainee
                                    .firstName} ${controller
                                    .getMyTrainerProfileModel.result!.user
                                    .trainerReview[index].trainee.lastName}",
                                style: CustomTextStyles.semiBold(
                                    fontSize: 13.0, fontColor: themeBlack),
                              ),
                            ],
                          ),
                        ),
                        circleProfileNetworkImage(
                            networkImage: controller
                                .getMyTrainerProfileModel
                                .result!
                                .user
                                .trainerReview[index]
                                .badgeUrl,
                            borderRadius: 1.0,
                            width: 35,
                            height: 35),
                      ],
                    ),
                  );
                })
                : noDataFound()),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }

  normalTrainerProfile() {
    return Column(
      children: [
        profileTopView(),
        contactDetailsView(),
        const SizedBox(height: 20),
        professionQualification(),
        const SizedBox(height: 20),
        certificationInsuranceView(),
        const SizedBox(height: 20),
        trainerAvailability(),
        const SizedBox(height: 100),
      ],
    );
  }

  professionalServiceView() {
    return Column(
      children: [
        profileTopView(),
        badgeView(),
        const SizedBox(height: 20),
        trainingTypeView(),
        const SizedBox(height: 20),
        trainingModeView(),
        const SizedBox(height: 20),
        kidFriendly(),
        const SizedBox(height: 20),
        galleryView(),
        const SizedBox(height: 20),
        achievementCaseStudy(),
        const SizedBox(height: 20),
        reviewView(),
        const SizedBox(height: 50),
      ],
    );
  }

  overlayContainerItem(item,
      subItem, {
        hasIcon = false,
        hasIconWithText = false,
        icon,
      }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIconWithText
                ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon),
                Text(
                  subItem == null ? "-" : " $subItem",
                  style: CustomTextStyles.semiBold(
                    fontColor: themeYellow,
                    fontSize: 16.0,
                  ),
                )
              ],
            )
                : hasIcon
                ? SvgPicture.asset(icon)
                : Text(
              subItem == null || subItem == "null"
                  ? "-"
                  : " $subItem",
              style: CustomTextStyles.semiBold(
                fontColor: themeBlack,
                fontSize: 16.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4.0),
            Text(
              "$item",
              style: CustomTextStyles.normal(
                fontColor: grey50,
                fontSize: 14.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  kidFriendly() {
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
                SvgPicture.asset(ImageResourceSvg.kidFriendly),
                const SizedBox(width: 5.0),
                Text(
                  "Kid Friendly ",
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
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "• ${controller.getMyTrainerProfileModel.result!.user
                  .kidFriendly == 0 ? "No" : "Yes"}",
              style: CustomTextStyles.semiBold(
                  fontSize: 14.0, fontColor: themeBlack),
            ),
          )
        ],
      ),
    );
  }
}
