import 'dart:async';
import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:fasttrackfitness/app/core/helper/pdf_viewer.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/data/training_mode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../../core/helper/app_storage.dart';
import '../../../../../core/helper/common_dialog.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../../core/helper/custom_method.dart';
import '../../../../../core/helper/helper.dart';
import '../../../../../core/helper/image_custom_cropper.dart';
import '../../../../../core/helper/images_resources.dart';
import '../../../../../core/helper/keyboard_avoider.dart';
import '../../../../../data/get_my_trainer_profile_model.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/create_trainer_profile_controller.dart';

mixin CreateTrainerProfileComponents {
  var controller = Get.put(CreateTrainerProfileController());

  willPop() {
    if (controller.updatedTrainerProfilePic.value.isEmpty &&
        controller.updateMedia.value == false) {
      Get.back();
    } else {
      Get.back(result: controller.updatedTrainerProfilePic.value);
    }
  }

  appBar() {
    return Container(
      decoration: const BoxDecoration(
        color: themeBlack,
      ),
      padding: const EdgeInsets.only(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    willPop();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppStorage.userData.result!.user.isProfileVerified == 0
                          ? const SizedBox.shrink()
                          : SvgPicture.asset(ImageResourceSvg.backArrowIc)),
                ),
              ],
            ),
          ),
          Obx(
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
                            getImage(ImageSource.camera, "trainerprofilepic");
                          }, onPressTitle2: () {
                            getImage(ImageSource.gallery, "trainerprofilepic");
                          });
                        },
                        child: Stack(children: [
                          circleProfileNetworkImage(
                            borderRadius: 15.0,
                            width: 100,
                            height: 100,
                            networkImage: controller.profilePic.value,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                              decoration: const BoxDecoration(
                                color: themeWhite,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(22),
                                  bottomRight: Radius.circular(22),
                                ),
                              ),
                              child: Text(
                                "Upload",
                                style: CustomTextStyles.semiBold(
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
                const SizedBox(height: 20.0),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffE5E5E5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Obx(
                    () => Row(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.profileType.value = "Personal";
                          },
                          child: Container(
                            width: Get.width,
                            alignment: Alignment.center,
                            height: 46,
                            decoration: BoxDecoration(
                              color: controller.profileType.value == "Personal"
                                  ? themeGreen
                                  : const Color(0xffE5E5E5),
                              borderRadius: controller.profileType.value == "Personal"
                                  ? const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    )
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                    ),
                            ),
                            child: SafeArea(
                              child: Text("Personal Profile",
                                  style: CustomTextStyles.semiBold(
                                    fontSize: 16.0,
                                    fontColor: themeBlack,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (controller.profileType.value == "Personal") {
                              if (controller.isPersonalDetailValid()) {
                                controller.profileType.value = "Professional";
                              }
                            }
                          },
                          child: Container(
                            height: 46,
                            width: Get.width,
                            padding: const EdgeInsets.only(top: 0, bottom: 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.profileType.value == "Professional"
                                  ? themeGreen
                                  : const Color(0xffE5E5E5),
                              borderRadius: controller.profileType.value == "Professional"
                                  ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                    )
                                  : const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                    ),
                            ),
                            child: SafeArea(
                              child: Text("Professional Services",
                                  style: CustomTextStyles.semiBold(
                                      fontColor: themeBlack, fontSize: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future getImage(ImageSource source, type) async {
    Helper().hideKeyBoard();
    if (Get.isBottomSheetOpen!) Get.back();

    File profileImage;
    final pickedFile = await CustomImageCropper().imagePicker(source);

    if (pickedFile != null && pickedFile.isNotEmpty) {
      profileImage = File(pickedFile);

      controller.selectedProfile.value = profileImage;
      apiLoader(
          asyncCall: () =>
              controller.callUploadProfileFileAPI(controller.selectedProfile.value, type));
    }
  }

  personalForm() {
    return KeyboardAvoider(
      autoScroll: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0, bottom: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(ImageResourceSvg.profilePhone),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  "Personal Information",
                  style: CustomTextStyles.semiBold(fontSize: 18.0, fontColor: themeBlack),
                )
              ],
            ),
            const SizedBox(height: 10),
            commonDivider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "First Name",
                        style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: colorGreyText),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        maxLength: 20,
                        key: controller.keyFName,
                        hintText: "First Name",
                        controller: controller.fNameController,
                        hasBorder: false,
                        borderColor: borderColor,
                        fontColor: themeBlack,
                        focusNode: controller.focusFName,
                        focusNext: controller.focusLName,
                        validateTypes: ValidateTypes.empty,
                        style: CustomTextStyles.semiBold(
                          fontSize: 14.0,
                          fontColor: themeBlack,
                        ),
                        textInputAction: TextInputAction.next,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last Name",
                        style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: colorGreyText),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        maxLength: 20,
                        key: controller.keyLName,
                        hintText: "Last Name",
                        controller: controller.lNameController,
                        hasBorder: false,
                        borderColor: borderColor,
                        fontColor: themeBlack,
                        focusNode: controller.focusLName,
                        focusNext: controller.focusMobile,
                        validateTypes: ValidateTypes.empty,
                        style: CustomTextStyles.semiBold(
                          fontSize: 14.0,
                          fontColor: themeBlack,
                        ),
                        textInputAction: TextInputAction.next,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: controller.commonFieldSpace),
            CustomTextFormField(
              key: controller.keyMobile,
              hintText: "Mobile No",
              controller: controller.mobileController,
              hasBorder: false,
              borderColor: borderColor,
              fontColor: themeBlack,
              focusNode: controller.focusMobile,
              focusNext: controller.focusEmail,
              textInputType: TextInputType.number,
              maxLength: 16,
              inputFormat: [FilteringTextInputFormatter.digitsOnly],
              validateTypes: ValidateTypes.mobile,
              textInputAction: TextInputAction.next,
              prefix: SvgPicture.asset(ImageResourceSvg.icMobile),
            ),
            SizedBox(height: controller.commonFieldSpace),
            CustomTextFormField(
              key: controller.keyEmail,
              hintText: "Enter your email",
              controller: controller.emailController,
              hasBorder: false,
              borderColor: borderColor,
              fontColor: themeBlack,
              focusNode: controller.focusEmail,
              focusNext: controller.focusAge,
              textInputType: TextInputType.emailAddress,
              validateTypes: ValidateTypes.email,
              textInputAction: TextInputAction.next,
              prefix: SvgPicture.asset(ImageResourceSvg.profileEmail),
            ),
            SizedBox(height: controller.commonFieldSpace),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      printLog(":${DateTime.now()}");
                      showDatePicker(
                        context: Get.context!,
                        initialDate: controller.dobController.text.isNotEmpty
                            ? DateTime.parse(CustomMethod.convertDateFormat(
                                controller.dobController.text, "dd-MM-yyyy", "yyyy-MM-dd"))
                            : DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Colors.black,
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: Colors.red, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then((value) {
                        final DateFormat formatter = DateFormat('dd-MM-yyyy');
                        if (value != null) {
                          final String formatted = formatter.format(value);
                          controller.dobController.text = formatted;
                          if (controller.keyAge.currentState!.checkValidation(false)) ;
                        }
                      });
                    },
                    child: CustomTextFormField(
                      key: controller.keyAge,
                      hintText: "DOB",
                      controller: controller.dobController,
                      hasBorder: false,
                      borderColor: borderColor,
                      fontColor: themeBlack,
                      focusNode: controller.focusAge,
                      focusNext: controller.focusExperience,
                      validateTypes: ValidateTypes.empty,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormat: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 3,
                      enabledTextField: false,
                      prefix: SvgPicture.asset(ImageResourceSvg.profileCalendar),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: CustomTextFormField(
                    key: controller.keyExperience,
                    hintText: "Yrs of exp.",
                    controller: controller.experienceController,
                    inputFormat: [FilteringTextInputFormatter.digitsOnly],
                    hasBorder: false,
                    borderColor: borderColor,
                    fontColor: themeBlack,
                    focusNode: controller.focusExperience,
                    textInputType: TextInputType.number,
                    validateTypes: ValidateTypes.empty,
                    textInputAction: TextInputAction.done,
                    maxLength: 2,
                    prefix: SvgPicture.asset(ImageResourceSvg.bagIc),
                  ),
                ),
              ],
            ),
            SizedBox(height: controller.commonFieldSpace),
            Row(
              children: [
                radioButton(1, "  Male"),
                const SizedBox(width: 10.0),
                radioButton(2, "  Female"),
              ],
            ),
            SizedBox(height: controller.commonFieldSpace),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.GET_LOCATION_MAP)!.then((value) {
                  if (value != null) {
                    controller.locationController.text = value[0];
                    controller.userLat.value = value[1].toString();
                    controller.userLng.value = value[2].toString();
                    controller.keyLocation.currentState!.checkValidation();
                    Helper().hideKeyBoard();
                  }
                });
              },
              child: CustomTextFormField(
                key: controller.keyLocation,
                hintText: "Location",
                controller: controller.locationController,
                hasBorder: true,
                enabled: false,
                enabledTextField: false,
                borderColor: borderColor,
                fontColor: themeBlack,
                textInputType: TextInputType.emailAddress,
                validateTypes: ValidateTypes.empty,
                textInputAction: TextInputAction.done,
                prefix: SvgPicture.asset(ImageResourceSvg.locationTwo),
                suffixIcon: SvgPicture.asset(ImageResourceSvg.currentLocIc),
              ),
            ),
            SizedBox(height: controller.commonFieldSpace),
            degreeOrCertificateView(),
            SizedBox(height: controller.commonFieldSpace),
            Row(
              children: [
                SvgPicture.asset(ImageResourceSvg.availability),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  "Availability",
                  style: CustomTextStyles.semiBold(fontSize: 18.0, fontColor: themeBlack),
                )
              ],
            ),
            const SizedBox(height: 15),
            commonDivider(),
            const SizedBox(height: 15),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                // color: inputGrey,
                border: Border.all(width: 1, color: inputGrey),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () => controller.selectStartTime(true),
                            child: SvgPicture.asset(ImageResourceSvg.timingIc)),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () => controller.selectStartTime(true),
                          child: Text(
                            controller.morningSTime.isNotEmpty
                                ? "${controller.morningSTime.value} am - "
                                : "Start time - ",
                            style: CustomTextStyles.semiBold(
                              fontSize: 16.0,
                              fontColor: themeBlack,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.selectEndTime(true);
                          },
                          child: Text(
                            controller.morningETime.isNotEmpty
                                ? "${controller.morningETime.value} am"
                                : "End time",
                            style: CustomTextStyles.semiBold(
                              fontSize: 16.0,
                              fontColor: themeBlack,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                            onTap: () => controller.selectEndTime(true),
                            child: SvgPicture.asset(ImageResourceSvg.downArrow))
                      ],
                    ),


                    const SizedBox(height: 10.0),
                    Obx(
                      () => Row(
                        children: List.generate(
                          controller.morningWeekList.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 0.0 : 10.0),
                            child: InkWell(
                              onTap: () {
                                controller.morningWeekList[index].isSelected.value =
                                    !controller.morningWeekList[index].isSelected.value;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.morningWeekList[index].isSelected.value
                                      ? themeBlack
                                      : themeLightWhite,
                                ),
                                height: 28,
                                width: 28,
                                child: Center(
                                  child: Text(
                                    controller.morningWeekList[index].day,
                                    style: CustomTextStyles.normal(
                                      fontSize: 16.0,
                                      fontColor: controller.morningWeekList[index].isSelected.value
                                          ? themeWhite
                                          : themeBlack,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        InkWell(
                            onTap: () => controller.selectStartTime(false),
                            child: SvgPicture.asset(ImageResourceSvg.timingIc)),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () => controller.selectStartTime(false),
                          child: Text(
                            controller.eveningSTime.isNotEmpty
                                ? "${controller.eveningSTime.value} pm - "
                                : "Start time - ",
                            style: CustomTextStyles.semiBold(
                              fontSize: 16.0,
                              fontColor: themeBlack,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.selectEndTime(false);
                          },
                          child: Text(
                            controller.eveningETime.isNotEmpty
                                ? "${controller.eveningETime.value} pm"
                                : "End time",
                            style: CustomTextStyles.semiBold(
                              fontSize: 16.0,
                              fontColor: themeBlack,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                            onTap: () => controller.selectEndTime(false),
                            child: SvgPicture.asset(ImageResourceSvg.downArrow))
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Obx(
                      () => Row(
                        children: List.generate(
                          controller.eveningWeekList.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 0.0 : 10.0),
                            child: InkWell(
                              onTap: () {
                                controller.eveningWeekList[index].isSelected.value =
                                    !controller.eveningWeekList[index].isSelected.value;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.eveningWeekList[index].isSelected.value
                                      ? themeBlack
                                      : themeLightWhite,
                                ),
                                height: 28,
                                width: 28,
                                child: Center(
                                  child: Text(
                                    controller.eveningWeekList[index].day,
                                    style: CustomTextStyles.normal(
                                      fontSize: 16.0,
                                      fontColor: controller.eveningWeekList[index].isSelected.value
                                          ? themeWhite
                                          : themeBlack,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: controller.commonFieldSpace),
          ],
        ),
      ),
    );
  }

  commonDivider() {
    return Container(
      height: 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xffF2F2F2),
      ),
    );
  }

  radioButton(index, title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.selectedGenderRadio.value = index;
        },
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: inputGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  controller.selectedGenderRadio.value == index
                      ? ImageResourceSvg.activeRadioIc
                      : ImageResourceSvg.inActiveRadioIc,
                  color: controller.selectedGenderRadio.value == index ? themeGreen : themeGrey,
                ),
                Text(
                  title,
                  style: CustomTextStyles.semiBold(
                    fontColor: controller.selectedGenderRadio.value == index ? themeBlack : grey50,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  qualificationContainer() {
    return Obx(() => controller.trainerQualifications.isEmpty
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
              color: themeWhite,
              border: Border.all(width: 2, color: inputGrey),
            ),
            margin: const EdgeInsets.only(bottom: 15.0),
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "\u2022 ${controller.trainerQualifications[index].title}",
                                style: CustomTextStyles.semiBold(
                                  fontColor: themeBlack,
                                  fontSize: 14.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  var ids = [];
                                  ids.add(controller.trainerQualifications[index].id);
                                  apiLoader(
                                      asyncCall: () => controller.deleteQualificationCer(
                                          "qulificationfile", ids,
                                          selIndex: index));
                                },
                                child: SvgPicture.asset(ImageResourceSvg.deleteIc))
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfViewer(
                                      controller.trainerQualifications[index].qulificationfileUrl,
                                      controller.trainerQualifications[index].qualificationFile)),
                            );
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ImageResourceSvg.pdfIc),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Text(
                                    controller.trainerQualifications[index].qualificationFile,
                                    style: CustomTextStyles.normal(
                                        fontSize: 14.0, fontColor: const Color(0xff0062D4)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: controller.trainerQualifications.length),
          ));
  }

  insuranceContainer() {
    return Obx(() => controller.trainerInsurance.isEmpty
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
              color: themeWhite,
              border: Border.all(width: 2, color: inputGrey),
            ),
            margin: const EdgeInsets.only(bottom: 15.0),
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "\u2022 ${controller.trainerInsurance[index].title}",
                                style: CustomTextStyles.semiBold(
                                  fontColor: themeBlack,
                                  fontSize: 14.0,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  var ids = [];
                                  ids.add(controller.trainerInsurance[index].id);
                                  apiLoader(
                                      asyncCall: () => controller.deleteQualificationCer(
                                          "trainerinsurance", ids,
                                          selIndex: index));
                                },
                                child: SvgPicture.asset(ImageResourceSvg.deleteIc))
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfViewer(
                                      controller.trainerInsurance[index].qulificationfileUrl,
                                      controller.trainerInsurance[index].qualificationFile)),
                            );
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ImageResourceSvg.pdfIc),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Text(
                                    controller.trainerInsurance[index].qualificationFile,
                                    style: CustomTextStyles.normal(
                                        fontSize: 14.0, fontColor: const Color(0xff0062D4)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: controller.trainerInsurance.length),
          ));
  }

  professionalForm() {
    return Obx(
      () => KeyboardAvoider(
        autoScroll: true,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 20.0,
            right: 20.0,
            bottom: 90,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  overlayContainerItem(
                      "Ratings",
                      controller.overAllRating.value == "null"
                          ? "0.0"
                          : controller.overAllRating.value,
                      hasIconWithText: true,
                      icon: ImageResourceSvg.starIc),
                  /*controller.getMyTrainerProfileModel.result!.user.isProfileVerified == 1
                      ?*/
                  overlayContainerItem("Verified", "",
                      hasIcon: true,
                      icon: ImageResourceSvg.approvedIc,
                      itemColor:
                          controller.getMyTrainerProfileModel.result!.user.isProfileVerified == 1
                              ? themeGreen
                              : colorGreyText),
                  // : const SizedBox.shrink(),
                  /*controller.getMyTrainerProfileModel.result!.user.badge.isNotEmpty
                      ? overlayContainerItem("Badge", "",
                          hasIconUrl: true,
                          url: controller.getMyTrainerProfileModel.result!.user.badge)
                      : const SizedBox.shrink(),*/
                ],
              ),
              SizedBox(height: controller.commonFieldSpace),
              badgeView(),
              SizedBox(height: controller.commonFieldSpace),
              Row(
                children: [
                  SvgPicture.asset(ImageResourceSvg.weight),
                  Expanded(
                    child: Text(
                      " Training Type",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.TRAINING_TYPE, arguments: controller.trainingTypeList);
                      },
                      child: SvgPicture.asset(ImageResourceSvg.addIc)),
                ],
              ),
              const SizedBox(height: 10.0),
              controller.trainingTypeList.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: inputGrey,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Obx(() => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller.trainingTypeList[index].title!,
                                        style: CustomTextStyles.semiBold(
                                          fontSize: 16.0,
                                          fontColor: themeBlack,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          controller.trainingTypeList.removeAt(index);
                                          controller.trainingTypeList.refresh();
                                        },
                                        child: SvgPicture.asset(ImageResourceSvg.deleteIc)),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Flexible(
                                      child: SizedBox(
                                        height: 28,
                                        width: 90,
                                        child: TextField(
                                          controller:
                                              controller.trainingTypeList[index].inputController,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.number,
                                          maxLength: 4,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          decoration: InputDecoration(
                                            counterText: '',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                borderSide: const BorderSide(
                                                  color: themeBlack,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                borderSide: const BorderSide(
                                                  color: themeBlack,
                                                )),
                                            contentPadding:
                                                const EdgeInsets.only(left: 6.0, right: 6.0),
                                            prefixText: "\$",
                                            prefixStyle: CustomTextStyles.semiBold(
                                              fontSize: 14.0,
                                              fontColor: themeBlack,
                                            ),
                                            hintText: "Amount",
                                            hintStyle: CustomTextStyles.normal(
                                              fontSize: 14.0,
                                              fontColor: themeGrey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "  /  ",
                                      style: CustomTextStyles.normal(
                                          fontSize: 14.0, fontColor: themeBlack),
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        height: 40,
                                        child: DropdownButtonFormField<String>(
                                            value: controller.trainingTypeList[index].priceOption ==
                                                    ""
                                                ? null
                                                : controller.trainingTypeList[index].priceOption,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(0xffEBEBEB),
                                              hintText: "Type",
                                              hintStyle: CustomTextStyles.normal(
                                                  fontSize: 16.0, fontColor: themeBlack),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(left: 10.0, right: 10.0),
                                            ),
                                            isExpanded: true,
                                            dropdownColor: Colors.white,
                                            // icon: Image.asset(ImageResource.downArrowIc),
                                            icon: SvgPicture.asset(
                                              ImageResourceSvg.downArrowIc,
                                            ),
                                            style: CustomTextStyles.normal(
                                                fontColor: Colors.black87, fontSize: 12.0),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                controller.trainingTypeList[index].priceOption =
                                                    newValue;
                                              }
                                            },
                                            items: controller.priceTypeOptionList),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
                              child: Divider(height: 1.0, color: borderColor),
                            );
                          },
                          itemCount: controller.trainingTypeList.length)),
                    ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  SvgPicture.asset(ImageResourceSvg.icLocation),
                  Expanded(
                    child: Text(
                      " Training Mode",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => GridView.builder(
                  itemCount: controller.trainingModes.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 20.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 6.0,
                    childAspectRatio: 3.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return selectableItem(
                      controller.trainingModes.value[index],
                      title: "Weight Loss",
                    );
                  },
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageResourceSvg.kidFriendly,
                  ),
                  Expanded(
                    child: Text(
                      " Kid Friendly",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.kidFriendly.value = 1;
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: controller.kidFriendly.value == 1 ? themeBlack : themeWhite,
                          border: Border.all(
                            width: 1, //                   <--- border width here
                          ),
                        ),
                        child: Text(
                          "Yes",
                          style: CustomTextStyles.semiBold(
                            fontSize: 16.0,
                            fontColor: controller.kidFriendly.value == 1 ? themeWhite : themeBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.kidFriendly.value = 0;
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: controller.kidFriendly.value == 0 ? themeBlack : themeWhite,
                          border: Border.all(
                            width: 1, //                   <--- border width here
                          ),
                        ),
                        child: Text(
                          "No",
                          style: CustomTextStyles.semiBold(
                            fontSize: 16.0,
                            fontColor: controller.kidFriendly.value == 0 ? themeWhite : themeBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: controller.commonFieldSpace),
              Row(
                children: [
                  SvgPicture.asset(ImageResourceSvg.gallery1),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      " Gallery",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Helper().hideKeyBoard();
                      Get.toNamed(Routes.MEDIA, arguments: [
                        "media",
                        AppStorage.userData.result!.user.id,
                        controller.mediaLength,
                        controller.achievementLength
                      ]);
                    },
                    child: controller.usertrainerMediaCount > 5
                        ? Text(
                            "View All>",
                            style: CustomTextStyles.semiBold(
                              fontColor: themeGrey,
                              fontSize: 14.0,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              controller.userTrainerMedia.length < 2
                  ? InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        Helper().hideKeyBoard();
                        Get.toNamed(Routes.MEDIA, arguments: [
                          "media",
                          AppStorage.userData.result!.user.id,
                          controller.mediaLength,
                          controller.achievementLength
                        ]);
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(vertical: 26.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: inputGrey,
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(ImageResourceSvg.uploadIc),
                            Text(
                              "Upload training photos/videos",
                              style: CustomTextStyles.semiBold(
                                fontSize: 14.0,
                                fontColor: themeGrey,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              controller.userTrainerMedia.length < 2
                  ? SizedBox(height: controller.commonFieldSpace)
                  : const SizedBox.shrink(),
              controller.userTrainerMedia.length > 1
                  ? SizedBox(
                      height: 140.0,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return index != controller.userTrainerMedia.length - 1
                              ? InkWell(
                                  onTap: () async {
                                    if (controller.userTrainerMedia[index].mediaFileType ==
                                        "Video") {
                                      Get.toNamed(Routes.VIDEO_PLAYER, arguments: [
                                        controller.userTrainerMedia[index].mediaFileUrl,
                                        controller.userTrainerMedia[index].title,
                                        controller.userTrainerMedia[index].createdDateFormat
                                      ]);
                                    } else {
                                      await CustomMethod.showFullImages(
                                          controller.userTrainerMedia[index].mediaFileUrl);
                                    }
                                  },
                                  child: SizedBox(
                                    width: 140.0,
                                    height: 140.0,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 10.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            mediaNetworkImage(
                                                networkImage: controller.userTrainerMedia[index]
                                                        .thumbnailFileUrl.isNotEmpty
                                                    ? controller
                                                        .userTrainerMedia[index].thumbnailFileUrl
                                                    : controller
                                                        .userTrainerMedia[index].mediaFileUrl,
                                                borderRadius: 10.0,
                                                width: 140,
                                                height: 140),
                                            controller.userTrainerMedia[index].mediaFileType ==
                                                    "Video"
                                                ? Positioned(
                                                    child:
                                                        SvgPicture.asset(ImageResourceSvg.icPlay))
                                                : const SizedBox.shrink()
                                          ],
                                        )),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.MEDIA, arguments: [
                                      "media",
                                      AppStorage.userData.result!.user.id,
                                      controller.mediaLength,
                                      controller.achievementLength
                                    ]);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(ImageResourcePng.imgPlus,
                                          fit: BoxFit.cover)));
                        },
                        itemCount: controller.userTrainerMedia.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(height: controller.commonFieldSpace),
              Row(
                children: [
                  SvgPicture.asset(ImageResourceSvg.achievementsIc1),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      " Achievements",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Helper().hideKeyBoard();
                      Get.toNamed(Routes.MEDIA, arguments: [
                        "achievement",
                        AppStorage.userData.result!.user.id,
                        controller.mediaLength,
                        controller.achievementLength
                      ]);
                    },
                    child: controller.userAchievementFilesCount > 5
                        ? Text(
                            "View All>",
                            style: CustomTextStyles.semiBold(
                              fontColor: themeGrey,
                              fontSize: 14.0,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              controller.userAchievementFile.length < 2
                  ? InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        Helper().hideKeyBoard();
                        Get.toNamed(Routes.MEDIA, arguments: [
                          "achievement",
                          AppStorage.userData.result!.user.id,
                          controller.mediaLength,
                          controller.achievementLength
                        ]);
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(vertical: 26.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: inputGrey,
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(ImageResourceSvg.uploadIc),
                            Text(
                              "Upload training photos/videos",
                              style: CustomTextStyles.semiBold(
                                fontSize: 14.0,
                                fontColor: themeGrey,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              controller.userAchievementFile.length > 1
                  ? SizedBox(
                      height: 140.0,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return index != controller.userAchievementFile.length - 1
                              ? InkWell(
                                  onTap: () async {
                                    if (controller.userAchievementFile[index].achievementType ==
                                        "Video") {
                                      Get.toNamed(Routes.VIDEO_PLAYER, arguments: [
                                        controller.userAchievementFile[index].achievementFileUrl,
                                        controller.userAchievementFile[index].title,
                                        controller.userAchievementFile[index].createdDateFormat
                                      ]);
                                    } else {
                                      await CustomMethod.showFullImages(
                                          controller.userAchievementFile[index].achievementFileUrl);
                                    }
                                  },
                                  child: SizedBox(
                                    width: 140,
                                    height: 140,
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            mediaNetworkImage(
                                                networkImage: controller.userAchievementFile[index]
                                                        .thumbnailFileUrl.isNotEmpty
                                                    ? controller
                                                        .userAchievementFile[index].thumbnailFileUrl
                                                    : controller.userAchievementFile[index]
                                                        .achievementFileUrl,
                                                borderRadius: 10.0,
                                                width: 140,
                                                height: 140),
                                            controller.userAchievementFile[index].achievementType ==
                                                    "Video"
                                                ? Positioned(
                                                    child:
                                                        SvgPicture.asset(ImageResourceSvg.icPlay))
                                                : const SizedBox.shrink()
                                          ],
                                        )),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.MEDIA, arguments: [
                                      "achievement",
                                      AppStorage.userData.result!.user.id,
                                      controller.mediaLength,
                                      controller.achievementLength
                                    ]);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(ImageResourcePng.imgPlus,
                                          fit: BoxFit.cover)));
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.userAchievementFile.length,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  selectableItem(TrainingMode trainingMode, {title, bool isSelected = false}) {
    return Obx(
      () => InkWell(
        onTap: () {
          trainingMode.isSelected.value = !trainingMode.isSelected.value;
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: trainingMode.isSelected.value ? themeBlack : themeWhite,
            border: Border.all(
              width: 1, //                   <--- border width here
            ),
          ),
          child: Text(
            trainingMode.title!,
            style: CustomTextStyles.semiBold(
              fontSize: 16.0,
              fontColor: trainingMode.isSelected.value ? themeWhite : themeBlack,
            ),
          ),
        ),
      ),
    );
  }

  overlayContainerItem(item, subItem,
      {hasIcon = false, hasIconWithText = false, icon, itemColor, hasIconUrl, url}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIconWithText
                ? Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: Row(
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
                    ),
                  )
                : hasIcon
                    ? Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: SizedBox(
                            width: 30, height: 30, child: SvgPicture.asset(icon, color: itemColor)))
                    : hasIconUrl
                        ? SizedBox(width: 37, height: 37, child: Image.network(url))
                        : Text(
                            subItem == null || subItem == "null" ? "-" : " $subItem",
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

  professionalDetailCommonItem(icon, title, value,
      {hasActionIc = false, Function? onPress, actionIc}) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: CustomTextStyles.normal(
              fontSize: 17.0,
              fontColor: grey50,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (onPress != null) {
              onPress();
            }
          },
          child: hasActionIc
              ? SvgPicture.asset(actionIc)
              : Expanded(
                  child: Text(
                    value ?? "-",
                    style: CustomTextStyles.semiBold(
                      fontSize: 17.0,
                      fontColor: themeBlack,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
        ),
      ],
    );
  }

  badgeView() {
    return Container(
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
                            controller.getMyTrainerProfileModel.result!
                                .user.userBadges[index].type ==
                                "Review" &&
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
                                      color: themeGrey, borderRadius: BorderRadius.circular(10.0)),
                                  child: Text(
                                    controller.getMyTrainerProfileModel.result!
                                        .user.userBadges[index]
                                        .badgeCount
                                        .toString(),
                                    style: CustomTextStyles.semiBold(
                                      fontSize: 10.0,
                                      fontColor: themeWhite,
                                    ),
                                  ),
                                )) : const SizedBox.shrink()
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

  convertThumbnail(filePath) async {
    File uploadFile;
    uploadFile = await VideoCompress.getFileThumbnail(filePath,
        quality: 50, // default(100)
        position: -1 // default(-1)
        );
    return uploadFile;
  }

  DropdownMenuItem<String> commonDropDownItem(dropDownText, {value}) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        dropDownText,
        style: CustomTextStyles.normal(
          fontSize: 16.0,
          fontColor: themeBlack,
        ),
      ),
    );
  }

  var listDropDownBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.0),
    borderSide: BorderSide.none,
  );

  String formatHHMMSS(int seconds) {
    if (seconds > 0) {
      int minutes = (seconds / 60).truncate();
      int second = seconds - (minutes * 60);
      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (second).toString().padLeft(2, '0');
      return "$minutesStr:$secondsStr";
    } else {
      return "";
    }
  }

  void startTimer() {
    if (controller.timer != null) {
      controller.timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    controller.timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (controller.timerStart.value < 1) {
          timer!.cancel();
        } else {
          controller.timerStart.value = controller.timerStart.value - 1;
        }
      },
    );
  }

  degreeOrCertificateView() {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(ImageResourceSvg.qualification),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              "Degree or Certificates",
              style: CustomTextStyles.semiBold(fontSize: 18.0, fontColor: themeBlack),
            )
          ],
        ),
        const SizedBox(height: 10),
        commonDivider(),
        const SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: controller.trainerQualifications.isEmpty ? 0.0 : 10.0),
          decoration: BoxDecoration(
            color: controller.trainerQualifications.isEmpty ? themeWhite : colorGrey,
            border: Border.all(
                width: 1, color: controller.trainerQualifications.isEmpty ? themeWhite : inputGrey),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(controller.trainerQualifications.isNotEmpty ? 10.0 : 0.0),
                topRight:
                    Radius.circular(controller.trainerQualifications.isNotEmpty ? 10.0 : 0.0)),
          ),
          child: Row(
            children: [
              SvgPicture.asset(ImageResourceSvg.certificate),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Text(
                  "Professional Qualifications *",
                  style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: colorGreyText),
                ),
              ),
              InkWell(
                  onTap: () {
                    Get.dialog(const CommonDialogView(
                      title: "Add Qualification Certs",
                      inputHint: "Certificate name here",
                      type: "certificate",
                    )).then((value) {
                      if (value != null) {
                        var model = UserQualificationFile(
                            id: value.id,
                            userId: AppStorage.userData.result!.user.id,
                            title: value.title,
                            qualificationFile: value.fileName,
                            qulificationfileUrl: value.fileUrl,
                            status: "");

                        controller.trainerQualifications.add(model);
                        controller.trainerQualifications.refresh();
                      }
                    });
                  },
                  child: SvgPicture.asset(ImageResourceSvg.plusGreen))
            ],
          ),
        ),
        qualificationContainer(),
        controller.trainerQualifications.isNotEmpty && controller.trainerInsurance.isNotEmpty
            ? const SizedBox.shrink()
            : commonDivider(),
        const SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: controller.trainerInsurance.isEmpty ? 0.0 : 10.0),
          decoration: BoxDecoration(
            color: controller.trainerInsurance.isEmpty ? themeWhite : colorGrey,
            border: Border.all(
                width: 1, color: controller.trainerInsurance.isEmpty ? themeWhite : inputGrey),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(controller.trainerInsurance.isNotEmpty ? 10.0 : 0.0),
                topRight:
                    Radius.circular(controller.trainerQualifications.isNotEmpty ? 10.0 : 0.0)),
          ),
          child: Row(
            children: [
              SvgPicture.asset(ImageResourceSvg.certificate),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Text(
                  "Certificate of Insurance (COI) *",
                  style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: colorGreyText),
                ),
              ),
              InkWell(
                  onTap: () async {
                    Get.dialog(const CommonDialogView(
                      title: "Add Insurance Certs",
                      inputHint: "Certificate name here",
                      type: "Insurance_Certificate",
                    )).then((value) {
                      if (value != null) {
                        var model = UserQualificationFile(
                            id: value.id,
                            userId: AppStorage.userData.result!.user.id,
                            title: value.title,
                            qualificationFile: value.fileName,
                            qulificationfileUrl: value.fileUrl,
                            status: "");

                        controller.trainerInsurance.add(model);
                        controller.trainerInsurance.refresh();
                      }
                    });
                  },
                  child: SvgPicture.asset(ImageResourceSvg.plusGreen))
            ],
          ),
        ),
        insuranceContainer(),
      ],
    );
  }
}
