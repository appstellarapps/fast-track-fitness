import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/debouncer_timer.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/custom_meal_model.dart';
import '../../../../data/premade_meal_model.dart';

class NutritionLibraryController extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController searchCtr = TextEditingController();
  var isSelected = false.obs;

  final GlobalKey<CustomTextFormFieldState> searchKey = GlobalKey<CustomTextFormFieldState>();

  var isLoading = true.obs;
  var customMealList = <CustomMeal>[].obs;
  var preMadeMealList = <PreMadeMeal>[].obs;

  var haseMore = false.obs;
  var page = 1;
  var tag = Get.arguments[0];
  var isMeal = Get.arguments[1];

  Timer? _debounce;
  var lastSearchValue = "".obs;
  var isSearchLoading = false.obs;
  var isTyping = false.obs;

  final Debouncer onSearchDebouncer = Debouncer(const Duration(milliseconds: 1000));

  @override
  void onInit() {
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    apiLoader(asyncCall: () => getMealLibrary());

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

  scroll() {
    if (scrollController.position.maxScrollExtent - 500 == scrollController.position.pixels - 500) {
      if (haseMore.value) {
        page++;
        getMealLibrary();
      }
    }
  }

  onSearchChanged(val) {
    if (lastSearchValue.value != val) {
      lastSearchValue.value = val;
      isSearchLoading.value = true;
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(seconds: 3), () {
        if (searchCtr.text.isNotEmpty && val.isNotEmpty) {
          getMealLibrary();
        }
      });
    }
  }

  void getMealLibrary() {
    var body = {'page': page, "search": searchCtr.text};
    WebServices.postRequest(
      body: body,
      uri: tag == 0 ? EndPoints.GET_CUSTOM_MEAL : EndPoints.GET_PREMADE_MEAL,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        if (tag == 0) {
          CustomMealModel customMealModel = customMealModelFromJson(responseBody);
          customMealList.addAll(customMealModel.result!.data);
          haseMore.value = customMealModel.result!.hasMoreResults == 0 ? false : true;
          isLoading.value = false;
        } else {
          PreMadeMealModel preMadeMealModel = preMadeMealModelFromJson(responseBody);
          preMadeMealList.addAll(preMadeMealModel.result!.data);
          haseMore.value = preMadeMealModel.result!.hasMoreResults == 0 ? false : true;
          isLoading.value = false;
        }
        isTyping.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
