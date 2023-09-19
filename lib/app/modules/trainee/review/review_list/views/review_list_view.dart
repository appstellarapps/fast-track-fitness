import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/review/review_list/views/review_list_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/app_storage.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_button.dart';
import '../../../../../core/helper/constants.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/review_list_controller.dart';

class ReviewListView extends GetView<ReviewListController> with ReviewListComponents {
  const ReviewListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ScaffoldAppBar.appBar(title: "Reviews"),
        body: Obx(
          () => controller.isLoading.value
              ? const SizedBox.shrink()
              : Container(
                  color: const Color(0xffE5E5E5).withOpacity(0.50),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                        child: Text(
                          controller.overAllRating.value,
                          style: CustomTextStyles.semiBold(
                            fontSize: 35.0,
                            fontColor: themeBlack,
                          ),
                        ),
                      ),
                      commonRatingBar(
                        initialRating: controller.overAllRating.value == "0.0" ||
                                controller.overAllRating.value == ""
                            ? 0.0
                            : double.parse(controller.overAllRating.value),
                        itemSize: 16.0,
                        ignoreGestures: true,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Based on ${controller.overAllRatingCount.value} reviews",
                        style: CustomTextStyles.medium(
                          fontSize: 14.0,
                          fontColor: grey50,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 15.0,
                        ),
                        child: Divider(
                          height: 1.5,
                          color: borderColor,
                          thickness: 2.5,
                        ),
                      ),
                      Obx(() => Expanded(
                            child: controller.reviewList.isEmpty
                                ? noDataFound()
                                : ListView.separated(
                                    controller: controller.scrollController,
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 60.0,
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    itemBuilder: (context, index) {
                                      return reviewItem(controller.reviewList[index]);
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 20.0);
                                    },
                                    itemCount: controller.reviewList.length),
                          ))
                    ],
                  ),
                ),
        ),
        floatingActionButton: Obx(
          () => AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER
              ? const SizedBox.shrink()
              : controller.isReview.value == 0 && controller.isWritable.value == 1
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      margin: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: ButtonRegular(
                        buttonText: "Write Review",
                        onPress: () {
                          Get.toNamed(Routes.WRITE_A_REVIEW, arguments: controller.trainerId)!
                              .then((value) {
                            if (value != null && value) {
                              apiLoader(asyncCall: () => controller.getReviewListAPI());
                            }
                          });
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
