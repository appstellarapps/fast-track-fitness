import 'package:fasttrackfitness/app/core/helper/colors.dart';

import 'package:fasttrackfitness/app/core/helper/helper.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/keyboard_avoider.dart';
import 'package:fasttrackfitness/app/modules/settings/contact_us/views/contact_us_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/image_picker.dart';
import '../../../../core/helper/text_style.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> with ContactUsComponents {
  ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helper().hideKeyBoard(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: btnView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: themeWhite,
        appBar: ScaffoldAppBar.appBar(title: "Contact Us"),
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: KeyboardAvoider(
            autoScroll: true,
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Image.asset(
                  ImageResourcePng.email,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Get in touch with us for\n more information",
                  style: CustomTextStyles.semiBold(
                    fontColor: themeBlack,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                TextField(
                  controller: controller.subController,
                  onChanged: (searchText) {
                    if (searchText.isEmpty) {
                      // searchInput.value = "";
                      // getTraineesAPI();
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xffF9F9F9),
                    filled: true,
                    hintText: "Enter subject here",
                    hintStyle: CustomTextStyles.semiBold(
                        fontSize: 12.0, fontColor: const Color(0xffCDCDCD)),
                    enabledBorder: commonBorderStyle,
                    disabledBorder: commonBorderStyle,
                    focusedBorder: commonBorderStyle,
                    focusedErrorBorder: commonBorderStyle,
                    errorBorder: commonBorderStyle,
                    contentPadding:
                        const EdgeInsets.only(left: 20.0, right: 6.0, top: 2.0, bottom: 2.0),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  controller: controller.msgController,
                  onChanged: (searchText) {
                    if (searchText.isEmpty) {
                      // searchInput.value = "";
                      // getTraineesAPI();
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xffF9F9F9),
                    filled: true,
                    hintText: "Enter Message here",
                    hintStyle: CustomTextStyles.semiBold(
                        fontSize: 12.0, fontColor: const Color(0xffCDCDCD)),
                    border: commonBorderStyle,
                    enabledBorder: commonBorderStyle,
                    disabledBorder: commonBorderStyle,
                    focusedBorder: commonBorderStyle,
                    focusedErrorBorder: commonBorderStyle,
                    errorBorder: commonBorderStyle,
                    contentPadding:
                        const EdgeInsets.only(left: 20.0, right: 6.0, top: 30.0, bottom: 2.0),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  readOnly: true,
                  controller: controller.attachController,
                  onTap: () {
                    CustomFilePicker.imagePick(context).then((value) {
                      if (value != null && value != "") {
                        controller.file = value;
                        controller.attachController.text = 'File Attached';
                      }
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xffF9F9F9),
                    filled: true,
                    hintText: "Attachment",
                    hintStyle: CustomTextStyles.semiBold(
                        fontSize: 12.0, fontColor: const Color(0xffCDCDCD)),
                    border: commonBorderStyle,
                    enabledBorder: commonBorderStyle,
                    disabledBorder: commonBorderStyle,
                    focusedBorder: commonBorderStyle,
                    focusedErrorBorder: commonBorderStyle,
                    errorBorder: commonBorderStyle,
                    contentPadding:
                        const EdgeInsets.only(left: 6.0, right: 6.0, top: 2.0, bottom: 2.0),
                    prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
                        child: // myIcon is a 48px-wide widget.
                            SvgPicture.asset(
                          ImageResourceSvg.attachment,
                        )),
                    prefixIconConstraints: const BoxConstraints(maxHeight: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
