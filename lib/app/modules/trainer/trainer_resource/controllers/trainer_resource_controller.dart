import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_button.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/images_resources.dart';
import '../../../../core/helper/text_style.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/exercise_library_model.dart';
import '../../../../data/get_workout_list_model.dart';
import '../../../../data/premade_meal_model.dart';

class TrainerResourceController extends GetxController {
  //TODO: Implement ResourceController

  ScrollController scrollController = ScrollController();
  TextEditingController searchCtr = TextEditingController();
  Timer? _debounce;

  final GlobalKey<CustomTextFormFieldState> searchKey = GlobalKey<CustomTextFormFieldState>();

  var lastSearchValue = "".obs;
  var isTyping = false.obs;
  var page = 1;
  var exerciseList = <Exercise>[].obs;
  var workoutList = <Workout>[].obs;
  var haseMore = false.obs;
  var selectTabIndex = 0.obs;
  var isLoading = true.obs;
  var preMadeMealList = <PreMadeMeal>[].obs;
  var resourceId = '';
  var nutritionalID = '';
  var workoutListId = [];

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    apiLoader(asyncCall: () => getExerciseLibrary());
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
        getExerciseLibrary();
      }
    }
  }

  onSearchChanged(val) {
    if (lastSearchValue.value != val) {
      lastSearchValue.value = val;
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(seconds: 3), () {
        if (searchCtr.text.isNotEmpty && val.isNotEmpty && selectTabIndex.value == 0) {
          getExerciseLibrary();
        } else if (searchCtr.text.isNotEmpty && val.isNotEmpty && selectTabIndex.value == 1) {
          getMealLibrary();
        }
      });
    }
  }

  void getExerciseLibrary() {
    var body = {'page': page, "search": searchCtr.text};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_RESOURCE_EXSERCISE,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        if (page == 1) {
          workoutList.clear();
          exerciseList.clear();
          preMadeMealList.clear();
        }
        ExerciseLibraryModel exerciseLibraryModel = exerciseLibraryModelFromJson(responseBody);
        exerciseList.addAll(exerciseLibraryModel.result!.data);
        haseMore.value = exerciseLibraryModel.result!.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
        isTyping.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void getMealLibrary() {
    var body = {'page': page, "search": searchCtr.text};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_PREMADE_MEAL,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        if (page == 1) {
          workoutList.clear();
          exerciseList.clear();
          preMadeMealList.clear();
        }
        PreMadeMealModel preMadeMealModel = preMadeMealModelFromJson(responseBody);
        preMadeMealList.addAll(preMadeMealModel.result!.data);
        haseMore.value = preMadeMealModel.result!.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
        isTyping.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void getWorkOut(type) {
    var body = {"type": type};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_WORK_OUT_LIST,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        GetWorkoutList getWorkoutList = getWorkoutListFromJson(responseBody);
        workoutList.clear();
        workoutList.addAll(getWorkoutList.result!.workouts!);
        isLoading.value = false;
        addWorkoutDialog();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  void addExerciseFromResource() {
    var body = {
      "resourceIds": [resourceId],
      "workoutId": workoutListId
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.ADD_EXERCISE_FROM_RESOURCES,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        var res = jsonDecode(responseBody);

        hideAppLoader();
        workoutList.clear();
        workoutListId.clear();
        isLoading.value = false;
        showSnackBar(title: "Success", message: res['message']);
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        workoutList.clear();
        workoutListId.clear();
        isLoading.value = false;
      },
    );
  }

  void addMealFromResource() {
    var body = {
      "resourceIds": [resourceId],
      "workoutId": workoutListId
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.ADD_MEAL_FROM_RESOURCES,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        var res = jsonDecode(responseBody);
        workoutList.clear();
        workoutListId.clear();
        isLoading.value = false;
        showSnackBar(title: "Success", message: res['message']);
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        workoutList.clear();
        workoutListId.clear();
        isLoading.value = false;
      },
    );
  }

  addWorkoutDialog() {
    return Get.bottomSheet(
        SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                color: themeWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectTabIndex.value == 0
                        ? "Add to Exercise Diary"
                        : "Add to Nutritional Diary",
                    style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
                  ),
                  const SizedBox(height: 30.0),
                  isLoading.value
                      ? const CircularProgressIndicator()
                      : workoutList.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      workoutList[index].isSelected.value =
                                          !workoutList[index].isSelected.value;
                                      if (workoutList[index].isSelected.value) {
                                        workoutListId.add(workoutList[index].id);
                                      } else {
                                        workoutListId.remove(workoutList[index].id);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          color: inputGrey),
                                      child: Row(
                                        children: [
                                          Obx(
                                            () => workoutList[index].isSelected.value
                                                ? SvgPicture.asset(
                                                    ImageResourceSvg.selectedCheckBox)
                                                : SvgPicture.asset(
                                                    ImageResourceSvg.unSelectedCheckBox),
                                          ),
                                          const SizedBox(width: 30.0),
                                          Text(
                                            workoutList[index].name,
                                            style: CustomTextStyles.semiBold(
                                                fontSize: 14.0, fontColor: themeBlack),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                                  );
                                },
                                itemCount: workoutList.length,
                              ),
                            )
                          : noDataFound(),
                  workoutList.isNotEmpty
                      ? Row(
                          children: [
                            Expanded(
                              child: ButtonRegular(
                                verticalPadding: 14.0,
                                buttonText: "Back",
                                onPress: () {
                                  Get.back();
                                },
                                color: colorGreyText,
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: ButtonRegular(
                                verticalPadding: 14.0,
                                buttonText: "Confirm",
                                onPress: () {
                                  Get.back();
                                  var isSelected = false;
                                  if (selectTabIndex.value == 0) {
                                    for (var workout in workoutList) {
                                      if (workout.isSelected.value) {
                                        isSelected = true;
                                        break;
                                      } else {
                                        isSelected = false;
                                      }
                                    }
                                    if (isSelected) {
                                      apiLoader(asyncCall: () => addExerciseFromResource());
                                    } else {
                                      showSnackBar(
                                          title: "Alert", message: "Please select workout");
                                    }
                                  } else {
                                    for (var workout in workoutList) {
                                      if (workout.isSelected.value) {
                                        isSelected = true;
                                        break;
                                      } else {
                                        isSelected = false;
                                      }
                                    }
                                    if (isSelected) {
                                      apiLoader(asyncCall: () => addMealFromResource());
                                    } else {
                                      showSnackBar(
                                          title: "Alert", message: "Please select workout");
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }
}
