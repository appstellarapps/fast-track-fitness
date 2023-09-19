import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_button.dart';
import '../../../../../core/helper/helper.dart';
import '../controllers/write_a_review_controller.dart';

class WriteAReviewView extends GetView<WriteAReviewController> {
  const WriteAReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: false,
        appBar: ScaffoldAppBar.appBar(title: "Write A Review"),
        body: Container(
          color: themeWhite,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Helper().hideKeyBoard();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                    top: 20.0,
                  ),
                  child: Text(
                    "Rate Trainer",
                    style: CustomTextStyles.normal(
                      fontSize: 15.0,
                      fontColor: themeBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 36.0,
                    unratedColor: themeLightWhite,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => SvgPicture.asset(ImageResourceSvg.starIc),
                    glowColor: themeGrey,
                    onRatingUpdate: (update) {
                      controller.rates.value = update.toString();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                    top: 20.0,
                  ),
                  child: Text(
                    "Share something about trainer",
                    style: CustomTextStyles.normal(
                      fontSize: 15.0,
                      fontColor: themeBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Obx(
                    () => CustomTextFormField(
                      key: controller.keyReview,
                      hintText: "Write a your review here",
                      errorMsg: "Please enter to write a review",
                      controller: controller.reviewController,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      textInputType: TextInputType.multiline,
                      maxLength: 100,
                      showCounterText: true,
                      hasBorder: false,
                      fontColor: themeBlack,
                      counter: controller.count.value,
                      getOnChageCallBack: true,
                      onChanged: (val) {
                        controller.count.value = controller.reviewController.text.length;
                      },
                      contentPadding: const EdgeInsets.only(top: 10.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                    top: 20.0,
                  ),
                  child: Text(
                    "Select Badges",
                    style: CustomTextStyles.normal(
                      fontSize: 15.0,
                      fontColor: themeBlack,
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: inputGrey),
                    width: Get.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: controller.badges.value,
                        items: controller.dropdownMenuItems,
                        onChanged: (value) {
                          controller.badges.value = value!;
                          controller.badgesId = value.id!;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: ButtonRegular(
            buttonText: "Submit Review",
            onPress: () {
              Get.closeAllSnackbars();
              if (controller.rates.value == "0.0") {
                showSnackBar(title: "Error", message: "Please add at-least 1 review");
              } else if (controller.reviewController.text.isEmpty) {
                showSnackBar(title: "Error", message: "Please Enter Description");
              } else {
                Helper().hideKeyBoard();
                apiLoader(asyncCall: () => controller.writeReviewAPI());
              }
              // Get.toNamed(Routes.writeReview);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
