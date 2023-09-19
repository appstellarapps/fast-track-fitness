import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/badges_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_button.dart';
import '../../../../../core/helper/constants.dart';

class WriteAReviewController extends GetxController {
  TextEditingController reviewController = TextEditingController();
  final GlobalKey<CustomTextFormFieldState> keyReview = GlobalKey<CustomTextFormFieldState>();
  final List<Result> badgeList = [];

  late BadgesModel badgesModel;

  RxList<Result> badgesList = <Result>[].obs;
  List<DropdownMenuItem<Result>> dropdownMenuItems = [];

  var badgesId = "";
  var rates = "0.0".obs;
  var count = 1.obs;
  var trainerId = Get.arguments;
  var badges = Result().obs;

  @override
  void onInit() {
    apiLoader(asyncCall: () => getBadgesAPI());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void writeReviewAPI() {
    var body = {
      "trainerId": trainerId,
      "ratting": rates.value,
      "badgeId": badgesId,
      "description": reviewController.text
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.WRITE_REVIEW,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        thankYouSheet();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void getBadgesAPI() {
    WebServices.postRequest(
      uri: EndPoints.GET_BADGES,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        badgesModel = badgesModelFromJson(responseBody);
        badgesList.addAll(badgesModel.result!);
        badgesList.refresh();
        badgeList.add(Result(
            id: '', badge: '', badgeUrl: '', isActive: 0, title: 'No badges selected.', type: ''));
        badgeList.addAll(badgesList);
        dropdownMenuItems.addAll(buildDropdownMenuItems(badgeList));
        badges.value = dropdownMenuItems[0].value!;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  thankYouSheet() {
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
                  "Thank you!",
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 20.0,
                  bottom: 20.0,
                ),
                child: Text(
                  "By making your voice heard. That’s great you are satisfied with the training. Your feedback is very helpful to us.",
                  style: CustomTextStyles.normal(
                    fontSize: 14.0,
                    fontColor: grey50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                child: ButtonRegular(
                  buttonText: "Continue",
                  onPress: () {
                    if (Get.isBottomSheetOpen!) Get.back();
                    Get.back(result: true);
                  },
                ),
              )
            ],
          ),
        ),
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: false);
  }

  List<DropdownMenuItem<Result>> buildDropdownMenuItems(List badges) {
    List<DropdownMenuItem<Result>> items = [];
    for (Result badge in badges) {
      items.add(
        DropdownMenuItem(
          value: badge,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                badge.badgeUrl!.isNotEmpty
                    ? Image.network(
                        badge.badgeUrl!,
                        width: 50,
                        height: 50,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  width: 10,
                ),
                Text(badge.title!)
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }
}
