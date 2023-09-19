import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_storage.dart';
import '../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../core/helper/constants.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/services/web_services.dart';
import '../../../data/card_model.dart';
import '../../../data/subscripation_model.dart';
import '../../../data/user_model.dart';
import '../../../routes/app_pages.dart';

class AddCardController extends GetxController {
  TextEditingController amtController = TextEditingController();
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var selectedMethod = 0.obs;
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var cardHolderName = ''.obs;
  var cvvCode = ''.obs;
  var isCvvFocused = false.obs;
  var useGlassMorphism = false.obs;
  var useBackgroundImage = false.obs;
  var isDefault = 0.obs;
  var isLoading = true.obs;
  var cardModel = CardModel().obs;
  var userModel = UserModel();
  var subscription = Subscription();
  var userCardList = <UserCard>[].obs;
  // var userCurrency = 0.0.obs;
  var isChangeDetected = false.obs;
  var totalPayableAmt = ''.obs;
  var planValidity = ''.obs;
  var planTypeName = ''.obs;
  var subscriptionsId = ''.obs;
  var isSubscribed = 0.obs;

  @override
  void onInit() {
    super.onInit();

    apiLoader(asyncCall: () => callGetCardList());
    if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE) {
      isSubscribed.value = AppStorage.userData.result!.user.isResourceSubscribed;
      getSubscriptionPlanTrainee();
    } else {
      subscription = Get.arguments;
      planTypeName.value = subscription.name.toString();
      planValidity.value = subscription.validity.toString();
      totalPayableAmt.value = subscription.amount.toString();
      subscriptionsId.value = subscription.id.toString();
      isSubscribed.value = AppStorage.userData.result!.user.isSubscribed;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber.value = creditCardModel!.cardNumber;
    expiryDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  void showPopupMenu(context, details, index) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem(
          onTap: () {
            apiLoader(asyncCall: () => callRemoveCardApi(index));
          },
          height: 30,
          child: Text(
            "Remove card",
            style: CustomTextStyles.medium(fontSize: 10.0, fontColor: Colors.black),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  callCreateCardApi() {
    var body = {
      "cardHolderName": cardHolderName.value,
      "cardNumber": cardNumber.value,
      "expiryMonthYear": expiryDate.value,
      "cvv": cvvCode.value,
      "isDefault": isDefault.value
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.CREATE_NEW_CARD,
      hasBearer: true,
      onStatusSuccess: (response) {
        hideAppLoader();
        var res = jsonDecode(response);
        showSnackBar(title: "Success", message: res['message']);
        callGetCardList();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  callGetCardList() {
    WebServices.postRequest(
        uri: EndPoints.GET_CARD_LIST,
        hasBearer: true,
        body: [],
        onStatusSuccess: (response) {
          hideAppLoader();
          cardModel.value = cardModelFromJson(response);
          userCardList.value = cardModel.value.result!.userCards!;
          for (var i = 0; i < userCardList.length; i++) {
            if (userCardList[i].isDefault == 1) {
              userCardList[i].isSelected.value = true;
              userCardList.refresh();
            }
          }
          isLoading.value = false;
        },
        onFailure: (v) {
          hideAppLoader(hideSnacks: false);
          isLoading.value = false;
        });
  }

  callRemoveCardApi(index) {
    var body = {"cardId": cardModel.value.result!.userCards![index].id!};
    WebServices.postRequest(
        uri: EndPoints.REMOVE_USER_CARD,
        hasBearer: true,
        body: body,
        onStatusSuccess: (response) {
          hideAppLoader();
          var res = jsonDecode(response);
          userCardList.removeAt(index);
          showSnackBar(title: "Success", message: res['message']);
        },
        onFailure: (v) {
          hideAppLoader();
        });
  }

  getSubscriptionPlanTrainee() {
    WebServices.postRequest(
      uri: EndPoints.GETTRAINEESUBSCRIPATION,
      hasBearer: true,
      onStatusSuccess: (res) {
        var subModel = SubscriptionModel();
        subModel = subscriptionModelFromJson(res);
        planTypeName.value = subModel.result!.subscription[0].name!;
        planValidity.value = subModel.result!.subscription[0].validity!;
        totalPayableAmt.value = subModel.result!.subscription[0].amount.toString();
        subscriptionsId.value = subModel.result!.subscription[0].id!;
      },
      onFailure: (error) {},
    );
  }

  makePayment() {
    var selectedCardId = '';
    for (var card in userCardList) {
      if (card.isSelected.value) {
        selectedCardId = card.id!;
      }
    }
    WebServices.postRequest(
      uri: EndPoints.MAKE_PAYMENT,
      hasBearer: true,
      body: {"cardId": selectedCardId, "subscriptionsId": subscriptionsId.value},
      onStatusSuccess: (response) {
        hideAppLoader();
        var res = jsonDecode(response);
        userModel = userModelFromJson(response);
        AppStorage.setLoginProfileModel(userModel);
        AppStorage.userData = userModelFromJson(AppStorage.getLoginProfileModel());
        isSubscribed.value = 1;

        if (Get.isDialogOpen!) {
          showSnackBar(title: "Success", message: res['message']);
        }
        if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
          Get.offAllNamed(Routes.TRAINER_DASHBOARD);
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  // void makePaymentTrainer() {
  //   var body = {
  //     // only free train completed for now create 05/07/23
  //     "cardHolderName": "",
  //     "cardNumber": "",
  //     "expiryMonthYear": "",
  //     "cvv": "",
  //     "type": planTypeName,
  //     "subscriptionsId": subscriptionsId,
  //   };
  //   WebServices.postRequest(
  //     body: body,
  //     uri: EndPoints.MAKEPAYMENT,
  //     hasBearer: true,
  //     onStatusSuccess: (res) {
  //       hideAppLoader();
  //       UserModel userModel = userModelFromJson(res);
  //       AppStorage.setLoginProfileModel(userModel);
  //       AppStorage.userData = userModelFromJson(AppStorage.getLoginProfileModel());
  //       Get.offAllNamed(Routes.TRAINER_DASHBOARD);
  //     },
  //     onFailure: (error) {
  //       hideAppLoader(hideSnacks: false);
  //     },
  //   );
  // }
}
