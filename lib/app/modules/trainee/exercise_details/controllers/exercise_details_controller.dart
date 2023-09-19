import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/custom_meal_model.dart';
import '../../../../data/get_exercise_details_model.dart';
import '../../../../data/get_premade_meals_details.dart';

class ExerciseDetailsController extends GetxController {
  ScrollController scrollController = ScrollController();

  TextEditingController proteinCrt = TextEditingController();
  TextEditingController carbCtr = TextEditingController();
  TextEditingController fatCrt = TextEditingController();
  TextEditingController calorieCtr = TextEditingController();

  var isLoading = true.obs;
  var haseMore = false.obs;
  var page = 1;
  var exerciseDetailsModel = ExerciseDetailsModel();
  var preMadeMealDetails = PreMadeMealDetails();
  var getResourcesExerciseList = <Excercise>[].obs;
  var getPreMadeMealList = <GetResourcesNutrition>[].obs;

  var id = Get.arguments[0];
  var tag = Get.arguments[1];
  var isExercise = Get.arguments[2];
  var isFromResource = Get.arguments[3];
  var customMeal = CustomMeals();
  var mealIndex;
  var isPreMadeAlreadyAdded = false.obs;
  var isPreMadeAlreadyAddedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    if (isExercise == 0) {
      apiLoader(asyncCall: () => getExerciseDetails());
    } else if (isExercise == 1 && tag == 1) {
      apiLoader(asyncCall: () => getMealDetails());
    } else {
      customMeal = Get.arguments[4];
      mealIndex = Get.arguments[5];
      print("this is meal index $mealIndex");
      isLoading.value = false;
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
          getExerciseDetails();
        } else if (isExercise == 1 && tag == 1) {
          getMealDetails();
        } else {
          //code remain
        }
      }
    }
  }

  checkSelectedExercise() {
    for (final val1 in getResourcesExerciseList) {
      for (final val2 in AppStorage.userSelectedExerciseList) {
        if (val1.id == val2.id) {
          if (val2.isSelected.value) {
            val1.isSelected.value = true;
          }
          isPreMadeAlreadyAdded.value = true;
        }
      }
    }
  }

  checkSelectedMeal() {
    for (final val1 in getPreMadeMealList) {
      for (final val2 in AppStorage.preMadeMealLIst) {
        if (val1.categoryId == val2.id) {
          isPreMadeAlreadyAdded.value = true;
        }
      }
    }
  }

  void getExerciseDetails() {
    var body = {'page': page, 'categoryId': id};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_RESOURCE_EXSERCISE_DETAILS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        exerciseDetailsModel = exerciseDetailsModelFromJson(responseBody);
        getResourcesExerciseList.addAll(exerciseDetailsModel.result!.excercises);
        checkSelectedExercise();
        haseMore.value = exerciseDetailsModel.result!.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void getMealDetails() {
    var body = {'page': page, 'categoryId': id};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_PREMADE_MEAL_DETAILS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        preMadeMealDetails = preMadeMealDetailsFromJson(responseBody);
        getPreMadeMealList.addAll(preMadeMealDetails.result!.getResourcesNutrition);
        checkSelectedMeal();
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
