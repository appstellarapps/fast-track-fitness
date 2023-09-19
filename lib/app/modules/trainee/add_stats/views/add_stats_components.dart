import 'package:cached_network_image/cached_network_image.dart';
import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/add_stats/controllers/add_stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_textformfield.dart';

mixin AddStatsComponents {
  var controller = Get.put(AddStatsController());

  var searchCommonBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xffE6E6E6),
      ));

  statsView(index) {
    return Container(
      decoration: BoxDecoration(
          color: Color(
              int.parse(controller.statsList[index].bodyColour.substring(1, 7), radix: 16) +
                  0xFF000000),
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: Get.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.statsList[index].imageUrl,
                    fit: BoxFit.contain,
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    placeholder: (context, url) => Container(
                      color: Colors.transparent,
                      child: const CircularProgressIndicator(
                        color: themeGreen,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      ImageResourcePng.placeHolder,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    controller.statsList[index].displayName,
                    style: CustomTextStyles.bold(
                      fontSize: 12.0,
                      fontColor: Color(int.parse(
                              controller.statsList[index].nameColour.substring(1, 7),
                              radix: 16) +
                          0xFF000000),
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 2,
            height: Get.height * 0.18,
            color: themeWhite,
          ),
          SizedBox(
            width: Get.width * 0.5,
            child: ListView.separated(
                padding: const EdgeInsets.only(left: 5, right: 5),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, subIndex) {
                  return subStatsView(index, subIndex);
                },
                separatorBuilder: (_, index) {
                  return Container();
                },
                itemCount: controller.statsList[index].excerciseTypeFields.length),
          )
        ],
      ),
    );
  }

  subStatsView(index, subIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: subIndex != 0 ? 10 : 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  controller.addOrRemoveStats(index, subIndex, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(ImageResourceSvg.statsMinus),
                )),
            SizedBox(
              width: 100,
              child: CustomTextFormField(
                getOnChageCallBack: true,
                onChanged: (val) {
                  if (controller.statsList[index].excerciseTypeFields[subIndex].type == 'Hours') {
                    timeFormat(val, index, subIndex);
                  }
                },
                maxLength: 5,
                enabledTextField: true,
                hintText: "",
                controller:
                    controller.statsList[index].excerciseTypeFields[subIndex].stateController,
                key: controller.statsList[index].excerciseTypeFields[subIndex].stateKey,
                hasBorder: false,
                validateTypes: ValidateTypes.noValidation,
                inputBorder: InputBorder.none,
                fontColor: themeBlack,
                textInputType: TextInputType.number,
                style: CustomTextStyles.semiBold(
                  fontSize: 19.0,
                  fontColor: themeBlack,
                ),
                isDense: true,
                hintStyle: CustomTextStyles.normal(fontSize: 12.0, fontColor: colorGreyText),
                textInputAction: TextInputAction.done,
                contentPadding:
                    const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0, right: 0.0),
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
                onTap: () {
                  controller.addOrRemoveStats(index, subIndex, 0);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(ImageResourceSvg.statsPlus),
                )),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          controller.statsList[index].excerciseTypeFields[subIndex].type,
          style: CustomTextStyles.semiBold(fontSize: 12.0, fontColor: const Color(0xff7F7968)),
        ),
        controller.statsList.length > 1 ? const SizedBox(height: 10) : const SizedBox.shrink()
      ],
    );
  }

  timeFormat(val, index, subIndex) {
    var filteredText = val.replaceAll(RegExp(r'[^0-9:]'), '');

    if (filteredText.length > 5) {
      filteredText = filteredText.substring(0, 5);
    }

    if (filteredText.length > 2 && !filteredText.contains(':')) {
      filteredText = filteredText.substring(0, 2) + ":" + filteredText.substring(2);
    }

    if (val != filteredText) {
      controller.statsList[index].excerciseTypeFields[subIndex].stateController.text = filteredText;
      controller.statsList[index].excerciseTypeFields[subIndex].stateController.selection =
          TextSelection.fromPosition(TextPosition(
              offset: controller
                  .statsList[index].excerciseTypeFields[subIndex].stateController.text.length));
    }
  }
}
