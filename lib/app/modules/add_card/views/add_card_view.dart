import 'package:fasttrackfitness/app/core/helper/common_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_storage.dart';
import '../../../core/helper/colors.dart';
import '../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../core/helper/constants.dart';
import '../../../core/helper/images_resources.dart';
import '../../../core/helper/text_style.dart';
import '../controllers/add_card_controller.dart';
import 'add_card_components.dart';

class AddCardView extends GetView<AddCardController> with AddCardComponents {
  AddCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeWhite,
      appBar: ScaffoldAppBar.appBar(title: "Payment"),
      body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 00, bottom: 20),
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: inputGrey,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Subscription Plan'.toUpperCase(),
                            style: CustomTextStyles.bold(fontSize: 18.0, fontColor: themeBlack),
                          ),
                          const SizedBox(width: 10),
                          AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
                              ? Obx(
                                  () => SvgPicture.asset(controller.isSubscribed.value == 0
                                      ? ImageResourceSvg.rejected
                                      : ImageResourceSvg.selected),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Plan Type : ${controller.planTypeName.toString()}",
                            style: CustomTextStyles.medium(fontSize: 12.0, fontColor: themeBlack),
                          ),
                          Text(
                            "|",
                            style: CustomTextStyles.medium(fontSize: 12.0, fontColor: themeBlack),
                          ),
                          Text(
                            "Validity : ${controller.planValidity.toString()}",
                            style: CustomTextStyles.medium(fontSize: 12.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Total Payable Amount",
                        style: CustomTextStyles.semiBold(fontSize: 14.0, fontColor: themeBlack),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "AUD ${controller.totalPayableAmt.toString()}",
                        style: CustomTextStyles.bold(fontSize: 20.0, fontColor: themeBlack),
                      ),
                      // AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE
                      //     ? Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             "Active",
                      //             style:
                      //                 CustomTextStyles.bold(fontSize: 16.0, fontColor: themeBlack),
                      //           ),
                      //           const SizedBox(width: 10),
                      //           Obx(
                      //             () => SvgPicture.asset(controller.isSubscribed.value == 0
                      //                 ? ImageResourceSvg.rejected
                      //                 : ImageResourceSvg.selected),
                      //           )
                      //         ],
                      //       )
                      //     : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Saved Cards',
                      style: CustomTextStyles.bold(fontSize: 20.0, fontColor: themeBlack),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        controller.cardNumber.value = '';
                        controller.expiryDate.value = '';
                        controller.cvvCode.value = '';
                        controller.cardHolderName.value = '';

                        cardBottomSheet();
                      },
                      child: SvgPicture.asset(ImageResourceSvg.addRoundPlus)),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      controller.cardNumber.value = '';
                      controller.expiryDate.value = '';
                      controller.cvvCode.value = '';
                      controller.cardHolderName.value = '';
                      cardBottomSheet();
                    },
                    child: Text(
                      'Add New Card',
                      style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() => controller.isLoading.value
                  ? const Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: themeGreen,
                          ),
                        ),
                      ),
                    )
                  : controller.userCardList.isNotEmpty
                      ? SizedBox(
                          height: Get.height * 0.28,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              itemBuilder: (context, index) {
                                return cardView(controller.userCardList[index], index);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 20);
                              },
                              itemCount: controller.userCardList.length),
                        )
                      : Expanded(child: noDataFound())),
              const Spacer(),
              Obx(
                () => ButtonRegular(
                  fontColor: themeBlack,
                  color: themeGreen,
                  onPress: () {
                    if (controller.userCardList.isNotEmpty ||
                        controller.planTypeName.value == "Free") {
                      paymentBottomSheet();
                    } else {
                      showSnackBar(title: "Alert", message: "Please add card first");
                    }
                  },
                  buttonText: "PAY ${controller.totalPayableAmt} AUD",
                ),
              )
            ],
          )),
    );
  }
}
