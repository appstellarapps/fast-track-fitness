import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/auth/subscription/controllers/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../data/subscripation_model.dart';
import '../../../../routes/app_pages.dart';

mixin SubscriptionComponents {
  var controller = Get.put(SubscriptionController());

  subscriptionView() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageResourcePng.welcomeBg,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: SvgPicture.asset(ImageResourceSvg.back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            const SizedBox(height: 100),
            subscriptionList()
          ],
        ),
      ),
    );
  }

  subscriptionList() {
    return Obx(
      () => controller.isLoading.value
          ? const SizedBox.shrink()
          : controller.subscriptionModel.value.result!.subscription.isEmpty
              ? noDataFound()
              : Expanded(
                  child: ListView.separated(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                      ),
                      itemBuilder: (context, index) {
                        return planView(
                            index, controller.subscriptionModel.value.result!.subscription[index]);
                      },
                      separatorBuilder: (_, index) {
                        return Container(
                          height: 20,
                        );
                      },
                      itemCount: controller.subscriptionModel.value.result!.subscription.length),
                ),
    );
  }

  planView(index, Subscription subscription) {
    return subscription.name == "Free"
        ? const SizedBox.shrink()
        : Obx(() => InkWell(
              onTap: () {
                for (var i = 0;
                    i < controller.subscriptionModel.value.result!.subscription.length;
                    i++) {
                  if (index == i) {
                    controller
                            .subscriptionModel.value.result!.subscription[index].isSelected.value =
                        !controller
                            .subscriptionModel.value.result!.subscription[i].isSelected.value;
                    if (controller
                        .subscriptionModel.value.result!.subscription[index].isSelected.value) {
                      controller.isPlanSelected.value = true;
                      controller.selectedPlanId = controller
                          .subscriptionModel.value.result!.subscription[index].id
                          .toString();
                      controller.selectedType = controller
                          .subscriptionModel.value.result!.subscription[index].name
                          .toString();
                    } else {
                      controller.isPlanSelected.value = false;
                    }
                  } else {
                    controller.subscriptionModel.value.result!.subscription[i].isSelected.value =
                        false;
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: themeWhite,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    controller.subscriptionModel.value.result!.subscription[index].isSelected.value
                        ? SvgPicture.asset(ImageResourceSvg.planSelected)
                        : Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: colorGreyText),
                            ),
                          ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subscription.name.toString(),
                            style:
                                CustomTextStyles.semiBold(fontSize: 13.0, fontColor: colorGreyText),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            subscription.validity.toString(),
                            style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '\$${subscription.amount.toString()}',
                      style: CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack),
                    )
                  ],
                ),
              ),
            ));
  }

  btnView() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 28.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => controller.isPlanSelected.value
              ? ButtonRegular(
                  buttonText: "Make Payment".toUpperCase(),
                  onPress: () {
                    for (var i = 0;
                        i < controller.subscriptionModel.value.result!.subscription.length;
                        i++) {
                      if (controller
                          .subscriptionModel.value.result!.subscription[i].isSelected.value) {
                        Get.toNamed(Routes.ADD_CARD,
                            arguments: controller.subscriptionModel.value.result!.subscription[i]);
                      }
                    }
                  },
                  isShadow: true,
                )
              : AppStorage.userData.result!.user.isFreeTrail == 0
                  ? ButtonRegular(
                      onPress: () {
                        for (var i = 0;
                            i < controller.subscriptionModel.value.result!.subscription.length;
                            i++) {
                          if (controller.subscriptionModel.value.result!.subscription[i].name ==
                              'Free') {
                            Get.toNamed(Routes.ADD_CARD,
                                arguments:
                                    controller.subscriptionModel.value.result!.subscription[i]);
                          }
                        }
                      },
                      buttonText: 'Start 1 month free trial'.toUpperCase(),
                      isShadow: true,
                    )
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}
