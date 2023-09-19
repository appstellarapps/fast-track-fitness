import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_button.dart';
import 'package:fasttrackfitness/app/core/helper/helper.dart';
import 'package:fasttrackfitness/app/modules/add_card/controllers/add_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';

import '../../../core/helper/text_style.dart';
import '../../../data/card_model.dart';

mixin AddCardComponents {
  var controller = Get.put(AddCardController());

  cardView(UserCard userCard, index) {
    return GestureDetector(
      onTap: () {
        controller.userCardList[index].isSelected.value = true;
        for (var userCard in controller.userCardList) {
          if (userCard.isSelected.value && userCard.id != controller.userCardList[index].id) {
            userCard.isSelected.value = false;
          }
        }
      },
      // behavior: HitTestBehavior.translucent,
      // onLongPressStart: (details) => controller.showPopupMenu(Get.context, details, index),
      child: Obx(
        () => Container(
          width: Get.width / 1.3,
          decoration: BoxDecoration(
            color: themeBlack,
            borderRadius: BorderRadius.circular(24.0),
            // image: DecorationImage(
            //   image: AssetImage(
            //       index.floor().isEven ? ImageResourcePng.cardBgOne : ImageResourcePng.cardBgTwo),
            //   fit: BoxFit.cover,
            // ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    controller.userCardList[index].cardImageUrl!,
                    height: 35,
                    width: 40,
                  ),
                  const Spacer(),
                  controller.userCardList[index].isSelected.value
                      ? const Icon(Icons.fiber_manual_record, color: themeGreen)
                      : const Icon(
                          Icons.fiber_manual_record_outlined,
                          color: themeWhite,
                        ),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTapDown: (details) => controller.showPopupMenu(Get.context, details, index),
                      child: const Icon(Icons.delete, color: themeWhite)),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "XXXX   XXXX   XXXX   ${controller.userCardList[index].last4.toString()!}",
                style: CustomTextStyles.bold(fontSize: 18.0, fontColor: themeWhite),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CARD HOLDER",
                        style: CustomTextStyles.bold(fontSize: 10.0, fontColor: themeWhite),
                      ),
                      Text(
                        controller.userCardList[index].cardHolderName!,
                        style: CustomTextStyles.bold(fontSize: 13.0, fontColor: themeWhite),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "VALID TILL",
                        style: CustomTextStyles.bold(fontSize: 10.0, fontColor: themeWhite),
                      ),
                      Text(
                        controller.userCardList[index].expiryDate.toString(),
                        style: CustomTextStyles.bold(fontSize: 13.0, fontColor: themeWhite),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          //declare your widget here
        ),
      ),
    );
  }

  paymentOption(title, image, index) {
    return InkWell(
      onTap: () {
        controller.selectedMethod.value = index;
        if (controller.selectedMethod.value == 1) {
          controller.cardNumber.value = '';
          controller.expiryDate.value = '';
          controller.cardHolderName.value = '';
          controller.cvvCode.value = '';
          controller.isCvvFocused.value = false;
          controller.useGlassMorphism.value = false;
          controller.useBackgroundImage.value = false;
          cardBottomSheet();
        }
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0), color: const Color(0xff222222)),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    title,
                    style: CustomTextStyles.medium(fontSize: 11.0, fontColor: themeWhite),
                  )
                ],
              )),
              Container(
                margin: const EdgeInsets.only(right: 8, top: 8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(width: 1.0, color: themeWhite)),
                height: 12,
                width: 12,
                padding: const EdgeInsets.all(1.5),
                child: controller.selectedMethod.value == index
                    ? Container(
                        decoration:
                            const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  cardBottomSheet() {
    return Get.bottomSheet(
        isScrollControlled: true,
        FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            decoration: const BoxDecoration(
              color: Color(0xff1E1E1E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Obx(
              () => SafeArea(
                child: Column(
                  children: [
                    CreditCardWidget(
                      cardNumber: controller.cardNumber.value,
                      expiryDate: controller.expiryDate.value,
                      cardHolderName: controller.cardHolderName.value,
                      cvvCode: controller.cvvCode.value,
                      showBackView: controller.isCvvFocused.value,
                      onCreditCardWidgetChange:
                          (CreditCardBrand) {}, //true when you want to show cvv(back) view
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            CreditCardForm(
                              formKey: controller.formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: controller.cardNumber.value,
                              cvvCode: controller.cvvCode.value,
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName: controller.cardHolderName.value,
                              expiryDate: controller.expiryDate.value,
                              themeColor: Colors.blue,
                              textColor: Colors.white,
                              cardNumberDecoration: InputDecoration(
                                labelText: 'Number',
                                hintText: 'XXXX XXXX XXXX XXXX',
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                focusedBorder: controller.border,
                                enabledBorder: controller.border,
                              ),
                              expiryDateDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                focusedBorder: controller.border,
                                enabledBorder: controller.border,
                                labelText: 'Expired Date',
                                hintText: 'XX/XX',
                              ),
                              cvvCodeDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                focusedBorder: controller.border,
                                enabledBorder: controller.border,
                                labelText: 'CVV',
                                hintText: 'XXX',
                              ),
                              cardHolderDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                focusedBorder: controller.border,
                                enabledBorder: controller.border,
                                labelText: 'Card Holder',
                              ),
                              onCreditCardModelChange: controller.onCreditCardModelChange,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: ButtonRegular(
                                buttonText: "ADD",
                                onPress: () async {
                                  if (controller.formKey.currentState!.validate()) {
                                    Get.back();
                                    controller.isDefault.value = await makeDefaultCardPayment();
                                    apiLoader(asyncCall: () => controller.callCreateCardApi());
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  makeDefaultCardPayment() {
    return Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Default Card",
                  style: CustomTextStyles.bold(fontColor: themeBlack, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Want to make this card default for payment",
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40.0,
                ),
                child: ButtonRegular(
                  verticalPadding: 14.0,
                  buttonText: "Ok",
                  onPress: () {
                    Get.back(result: 1);
                    Helper().hideKeyBoard();
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.back(result: 0);
                  Helper().hideKeyBoard();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: colorGreyText),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    "No",
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }

  paymentBottomSheet() {
    return Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Payment",
                  style: CustomTextStyles.bold(fontColor: themeBlack, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Are you sure you want to pay ?",
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40.0,
                ),
                child: ButtonRegular(
                  verticalPadding: 14.0,
                  buttonText: "Yes",
                  onPress: () {
                    if (Get.isBottomSheetOpen!) Get.back();
                    apiLoader(asyncCall: () => controller.makePayment());
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: colorGreyText),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Cancel",
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }
}
