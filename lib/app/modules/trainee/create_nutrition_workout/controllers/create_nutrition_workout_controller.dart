import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/custom_method.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/common/common_models.dart';
import '../../../../data/custom_local_meal_plan.dart';
import '../../../../data/custom_meal_model.dart';
import '../../../../data/get_nutritional_workout_details.dart';
import '../../../../data/get_premade_meals_details.dart';
import '../../../../data/workout_details_model.dart';
import '../../../trainer/trainer_dashboard/trainer_dashboard/controllers/trainer_dashboard_controller.dart';
import '../../my_diary/controllers/my_diary_controller.dart';

class CreateNutritionWorkoutController extends GetxController {
  ///----------------------- variable declaration-----------------------///
  TextEditingController workoutNameCrt = TextEditingController();
  TextEditingController startDateCtr = TextEditingController();
  TextEditingController endDateCtr = TextEditingController();
  TextEditingController descCrt = TextEditingController();

  final GlobalKey<CustomTextFormFieldState> workoutNameKey = GlobalKey<CustomTextFormFieldState>();
  final GlobalKey<CustomTextFormFieldState> startDateKey = GlobalKey<CustomTextFormFieldState>();
  final GlobalKey<CustomTextFormFieldState> endDateKey = GlobalKey<CustomTextFormFieldState>();
  final GlobalKey<CustomTextFormFieldState> desKey = GlobalKey<CustomTextFormFieldState>();

  var isLoading = true.obs;
  var selectedTypeIndex = 0.obs;
  var isValidate = false;
  var customNutritionalList = <NutritionalWorkout>[];
  var workoutDetail = WorkoutDetailsModel();
  var resourceLibList = [];
  var tag = Get.arguments[0];
  var id = Get.arguments[1];
  var date = Get.arguments[2];
  var traineeId = Get.arguments[3];
  var isViewOnly = Get.arguments[4];

  @override
  void onInit() {
    super.onInit();
    if (date != '') {
      apiLoader(asyncCall: () => getNutritionalDetails());
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

  //////////------------add logical method below this----------------/////

  ///-------------------------date select for start and end date method-----------///

  selectDate(isStartDate) {
    return showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 15),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      if (value != null) {
        final String formatted = formatter.format(value);
        if (isStartDate) {
          startDateCtr.text =
              CustomMethod.convertDateFormat(formatted, 'dd-MM-yyyy', 'dd, MMM-yyyy');
        } else {
          endDateCtr.text = CustomMethod.convertDateFormat(formatted, 'dd-MM-yyyy', 'dd, MMM-yyyy');
          ;
        }
      }
    });
  }

  ///-------------------------trigger validation method on save button-----------///
  validateLogin() {
    if (workoutNameKey.currentState!.checkValidation()) {
      return;
    } else if (startDateCtr.text.isEmpty) {
      showSnackBar(title: "Alert", message: "Please select start date");
      return;
    } else if (endDateCtr.text.isEmpty) {
      showSnackBar(title: "Alert", message: "Please select end date");
    } else if (DateFormat('dd, MMM-yyyy')
        .parse(startDateCtr.text)
        .isAfter(DateFormat('dd, MMM-yyyy').parse(endDateCtr.text))) {
      showSnackBar(title: "Alert", message: "Start date should be before end date");
    } else if (desKey.currentState!.checkValidation()) {
      return;
    } else {
      if (date == '') {
        createNutritionWorkout();
      } else {
        updateNutritionWorkout();
      }
    }
  }

  ///-------------------checking appbar title based on tag--------------//
  checkAppBarTitle() {
    if (isViewOnly) {
      if (tag == 0) {
        return "Custom Meal Plan Details";
      } else {
        return 'Pre-Made Recipe Details';
      }
    } else {
      if (tag == 0 && date == "") {
        return "Create Custom Meal Plan";
      } else if (tag == 1 && date == "") {
        return "Add Pre-Made Recipe";
      } else if (tag == 0 && date != "") {
        return "Update Custom Meal Plan";
      } else if (tag == 1 && date != "") {
        return 'Update Pre-Made Recipe';
      }
    }
  }

  ///---------------create nutrition workout method---------///
  createNutritionWorkout() {
    if (tag == 0) {
      for (var data in AppStorage.mainCustomMealList) {
        List<String> tempMealList = [];
        for (var e in data.subMealList!) {
          tempMealList.add(e.id.toString());
        }
        customNutritionalList
            .add(NutritionalWorkout(name: data.mealName.toString(), meals: tempMealList));
      }

      apiLoader(asyncCall: () => createNutritionalWorkout());
    } else {
      for (var data in AppStorage.preMadeMealLIst) {
        if (!resourceLibList.contains(data.id)) {
          resourceLibList.add(data.id);
        }
      }
      apiLoader(asyncCall: () => createNutritionalWorkout());
    }
  }

  ///---------------update nutrition workout method---------///

  updateNutritionWorkout() {
    for (var data in AppStorage.mainCustomMealList) {
      List<String> tempMealList = [];
      for (var e in data.subMealList!) {
        tempMealList.add(e.id.toString());
      }
      customNutritionalList
          .add(NutritionalWorkout(name: data.mealName.toString(), meals: tempMealList));
    }
    resourceLibList.clear();
    for (var e in AppStorage.preMadeMealLIst) {
      for (var data in e.getResourcesNutrition) {
        if (!resourceLibList.contains(data.categoryId)) {
          resourceLibList.add(data.categoryId);
        }
      }
    }
    apiLoader(asyncCall: () => updateNutritionalWorkout());
  }

  ///------------------get nutrition details api call-----------///
  void getNutritionalDetails() {
    var body = {
      'workoutId': id,
      'workoutDate': DateFormat('yyyy-MM-dd').format(date),
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_NUTRITIONAK_CUSTOM_WORK_OUT_DETAILS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        GetWorkouCustomtNutritionalDetails getWorkoutNutritionalDetails =
            getWorkouCustomtNutritionalDetailsFromJson(responseBody);
        if (tag == 0) {
          workoutNameCrt.text = getWorkoutNutritionalDetails.result!.workout.name;
          startDateCtr.text = CustomMethod.convertDateFormat(
              DateFormat('dd-MM-yyyy')
                  .format(getWorkoutNutritionalDetails.result!.workout.startDate),
              'dd-MM-yyyy',
              'dd, MMM-yyyy');
          endDateCtr.text = CustomMethod.convertDateFormat(
              DateFormat('dd-MM-yyyy').format(getWorkoutNutritionalDetails.result!.workout.endDate),
              'dd-MM-yyyy',
              'dd, MMM-yyyy');
          descCrt.text = getWorkoutNutritionalDetails.result!.workout.description;

          for (var i = 0; i < getWorkoutNutritionalDetails.result!.workoutDetails.length; i++) {
            List<CustomMeals>? tempMealList = [];

            for (var e in getWorkoutNutritionalDetails
                .result!.workoutDetails[i].workoutNutritionalMealDaily) {
              tempMealList.add(CustomMeals(
                id: e.resourceMealsId,
                fat: e.defultFat,
                foodName: e.foodName,
                image: e.image,
                resourceLibraryId: e.resourceMealsId,
                weight: e.defultWeight,
                calories: e.defultCalories,
                carbs: e.defultCarbs,
                categoryId: e.workoutNutritionalsId,
                protein: e.defultProtein,
              ));
            }

            AppStorage.mainCustomMealList.add(CustomLocalMealPlan(
                mealName: getWorkoutNutritionalDetails.result!.workoutDetails[i].name,
                subMealList: tempMealList));
          }
        } else {
          workoutNameCrt.text = getWorkoutNutritionalDetails.result!.workout.name;
          startDateCtr.text = CustomMethod.convertDateFormat(
              DateFormat('dd-MM-yyyy')
                  .format(getWorkoutNutritionalDetails.result!.workout.startDate),
              'dd-MM-yyyy',
              'dd, MMM-yyyy');
          endDateCtr.text = CustomMethod.convertDateFormat(
              DateFormat('dd-MM-yyyy').format(getWorkoutNutritionalDetails.result!.workout.endDate),
              'dd-MM-yyyy',
              'dd, MMM-yyyy');
          descCrt.text = getWorkoutNutritionalDetails.result!.workout.description;
          List<GetResourcesNutrition> tempPreMadeSubResourcesNutrition = [];
          List<WorkoutDetail> workoutDetails = [];

          Map<String, WorkoutDetail> mergedMap = {};

          for (var workout in getWorkoutNutritionalDetails.result!.workoutDetails) {
            if (mergedMap.containsKey(workout.categoryId)) {
              // Merge the current workout details into the existing one
              mergedMap[workout.categoryId] = WorkoutDetail(
                id: mergedMap[workout.categoryId]!.id,
                workoutDate: mergedMap[workout.categoryId]!.workoutDate,
                workoutId: mergedMap[workout.categoryId]!.workoutId,
                name: mergedMap[workout.categoryId]!.name,
                categoryId: mergedMap[workout.categoryId]!.categoryId,
                workoutNutritionalMealDaily: [
                  ...mergedMap[workout.categoryId]!.workoutNutritionalMealDaily,
                  ...workout.workoutNutritionalMealDaily
                ],
              );
            } else {
              // Add the workout details to the map
              mergedMap[workout.categoryId] = workout;
            }
          }

          workoutDetails = mergedMap.values.toSet().toList();

          for (var i = 0; i < workoutDetails.length; i++) {
            List<ResourcePreMadeMeal>? tempPreMadeSubChildMealResourceList = [];

            for (var j = 0; j < workoutDetails[i].workoutNutritionalMealDaily.length; j++) {
              tempPreMadeSubChildMealResourceList.add(ResourcePreMadeMeal(
                  id: workoutDetails[i].workoutNutritionalMealDaily[j].id,
                  resourceLibraryId:
                      workoutDetails[i].workoutNutritionalMealDaily[j].resourceMealsId,
                  categoryId: workoutDetails[i].categoryId,
                  type: tag == 0 ? 'Custom' : 'PreMade',
                  foodName: workoutDetails[i].workoutNutritionalMealDaily[j].foodName,
                  weight: workoutDetails[i].workoutNutritionalMealDaily[j].defultWeight,
                  calories: workoutDetails[i].workoutNutritionalMealDaily[j].defultCalories,
                  protein: workoutDetails[i].workoutNutritionalMealDaily[j].defultProtein,
                  carbs: workoutDetails[i].workoutNutritionalMealDaily[j].defultCarbs,
                  fat: workoutDetails[i].workoutNutritionalMealDaily[j].defultFat,
                  image: workoutDetails[i].workoutNutritionalMealDaily[j].image));
            }

            tempPreMadeSubResourcesNutrition.add(GetResourcesNutrition(
                id: workoutDetails[i].id,
                categoryId: workoutDetails[i].categoryId,
                title: '',
                image: '',
                video: '',
                videoUrl: '',
                duration: '',
                restTimeMinutes: '',
                resourcePreMadeMeals: tempPreMadeSubChildMealResourceList,
                imageUrl: '',
                description: ''));
          }

          for (var i = 0; i < tempPreMadeSubResourcesNutrition.length; i++) {
            List<GetResourcesNutrition> tempList = [];
            tempList.add(tempPreMadeSubResourcesNutrition[i]);
            AppStorage.preMadeMealLIst.add(PreMadeResult(
                id: tempPreMadeSubResourcesNutrition[i].categoryId,
                title: "",
                description: "",
                imageUrl: "",
                getResourcesNutrition: tempList));
          }
        }

        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  ///------------------create nutrition details api call-----------///

  void createNutritionalWorkout() {
    var body = {
      "tagName": tag == 0 ? "Custom" : "PreMade",
      "trainerId": traineeId == '' ? '' : AppStorage.userData.result!.user.id,
      "traineeId": traineeId == '' ? AppStorage.userData.result!.user.id : traineeId,
      "name": workoutNameCrt.text.tr.toString(),
      "startDate": CustomMethod.convertDateFormat(
          startDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
      "endDate":
          CustomMethod.convertDateFormat(endDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
      "description": descCrt.text.tr.toString(),
      "resouceNutritional": tag == 0 ? customNutritionalList : [],
      "resouceLibrary": tag == 1 ? resourceLibList : []
    };

    WebServices.postRequest(
      body: body,
      uri: EndPoints.CREATE_NUTRAIONAL_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        resourceLibList.clear();
        AppStorage.userSelectedExerciseList.clear();
        customNutritionalList.clear();
        AppStorage.mainCustomMealList.clear();
        AppStorage.preMadeMealLIst.clear();
        var controller = Get.put(MyDiaryController());
        controller.getResourceCount('Exercise');
        if (traineeId != '') {
          var trainerCtr = Get.put(TrainerDashboardController());
          trainerCtr.trainerDashboardModel.result!.nutrition.todayScheduledCount.value++;
        }
        commonBottomSheet(title: "Your meal plan was created successfully");
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        resourceLibList.clear();
        isLoading.value = false;
      },
    );
  }

  ///------------------update nutrition details api call-----------///

  void updateNutritionalWorkout() {
    var body = {
      "tagName": tag == 0 ? "Custom" : "PreMade",
      "workoutId": id,
      "workoutDate": DateFormat('yyyy-MM-dd').format(date),
      "trainerId": traineeId == '' ? '' : AppStorage.userData.result!.user.id,
      "traineeId": traineeId == '' ? AppStorage.userData.result!.user.id : traineeId,
      "name": workoutNameCrt.text.tr.toString(),
      "description": descCrt.text.tr.toString(),
      "resouceNutritional": tag == 0 ? customNutritionalList : [],
      "resouceLibrary": tag == 1 ? resourceLibList : []
    };

    WebServices.postRequest(
      body: body,
      uri: EndPoints.UPDATE_NUTRAIONAL_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        resourceLibList.clear();
        AppStorage.preMadeMealLIst.clear();
        AppStorage.mainCustomMealList.clear();
        isLoading.value = false;
        commonBottomSheet(title: "Your nutritional workout updated successfully");
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        resourceLibList.clear();
        AppStorage.preMadeMealLIst.clear();
        AppStorage.mainCustomMealList.clear();
        isLoading.value = false;
      },
    );
  }
}
