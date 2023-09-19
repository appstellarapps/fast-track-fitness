import 'package:fasttrackfitness/app/data/all_exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/custom_meal_model.dart';
import '../../../../data/custom_meal_view_all.dart';
import '../../../../data/pre_made_view_all.dart';

class AllExerciseController extends GetxController {
  //TODO: Implement AllExerciseController

  ScrollController scrollController = ScrollController();

  var isLoading = true.obs;
  var haseMore = false.obs;
  var page = 1;
  var allExerciseList = <AllExercise>[].obs;
  var preMadeMealList = <PreMadeMeals>[].obs;
  var customMealList = <CustomMeals>[].obs;

  var id = Get.arguments[0];
  var tag = Get.arguments[1];
  var isExercise = Get.arguments[2];
  var isFromResource = Get.arguments[3];
  var mealIndex;
  var mainCategoryTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    if (isExercise == 0) {
      apiLoader(asyncCall: () => getAllExercise());
    } else if (isExercise == 1 && tag == 1) {
      apiLoader(asyncCall: () => getAllMeal());
    } else {
      mealIndex = Get.arguments[4];
      apiLoader(asyncCall: () => getAllMeal());
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

  scroll() {
    if (scrollController.position.maxScrollExtent - 500 == scrollController.position.pixels - 500) {
      if (haseMore.value) {
        page++;
        if (isExercise == 0) {
          getAllExercise();
        } else if (isExercise == 1 && tag == 0) {
        } else {
          getAllMeal();
        }
      }
    }
  }

  void getAllExercise() {
    var body = {
      'page': page,
      'categoryId': id,
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_RESOURCE_EXSERCISE_VIEWALL,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        AllExerciseModel allExerciseModel = allExerciseModelFromJson(responseBody);
        mainCategoryTitle.value = allExerciseModel.result!.mainCategoryTitle;
        allExerciseList.addAll(allExerciseModel.result!.data);
        haseMore.value = allExerciseModel.result!.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void getAllMeal() {
    var body = {
      'page': page,
      'mainCategoryId': id,
    };
    WebServices.postRequest(
      uri: tag == 0 ? EndPoints.GET_CUSTOM_MEAL_VIEW_ALL : EndPoints.GET_PREMADE_MEAL_VIEW_ALL,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        if (tag == 1) {
          PreMadeViewAll preMadeViewAll = preMadeViewAllFromJson(responseBody);
          preMadeMealList.addAll(preMadeViewAll.result.data);
          mainCategoryTitle.value = preMadeViewAll.result.mainCategoryTitle;
          haseMore.value = preMadeViewAll.result.hasMoreResults == 0 ? false : true;
        } else {
          CustomMealViewAll customMealViewAll = customMealViewAllFromJson(responseBody);
          customMealList.addAll(customMealViewAll.result.data);
          haseMore.value = customMealViewAll.result.hasMoreResults == 0 ? false : true;
          mainCategoryTitle.value = customMealViewAll.result.mainCategoryTitle;
        }
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
