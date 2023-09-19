import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/modules/trainee/my_diary/controllers/my_diary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/app_storage.dart';
import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/common/common_models.dart';
import '../../../../data/get_exercise_details_model.dart';
import '../../../../data/training_type_model.dart';
import '../../../../data/workout_details_model.dart';
import '../../../trainer/trainer_dashboard/trainer_dashboard/controllers/trainer_dashboard_controller.dart';

class CreateWorkoutController extends GetxController {
  ///----------------------- variable declaration-----------------------///

  TextEditingController workoutNameCrt = TextEditingController();
  TextEditingController startDateCtr = TextEditingController();
  TextEditingController endDateCtr = TextEditingController();
  TextEditingController descCrt = TextEditingController();

  final GlobalKey<CustomTextFormFieldState> workoutNameKey = GlobalKey<CustomTextFormFieldState>();
  final GlobalKey<CustomTextFormFieldState> startDateKey = GlobalKey<CustomTextFormFieldState>();
  final GlobalKey<CustomTextFormFieldState> endDateKey = GlobalKey<CustomTextFormFieldState>();
  final GlobalKey<CustomTextFormFieldState> desKey = GlobalKey<CustomTextFormFieldState>();

  var trainingTypeList = <TrainingTypes>[].obs;
  var isTrainingTypeSelected = false.obs;
  var isLoading = true.obs;
  var selectedTypeIndex = 0.obs;
  var isValidate = false;
  var customWorkoutList = <ResourceExercise>[];
  var workoutDetail = WorkoutDetailsModel();
  var resourceLibList = [];
  var tag = Get.arguments[0];
  var id = Get.arguments[1];
  var date = Get.arguments[2]; //date
  var traineeId = Get.arguments[3]; //trainee id
  var isOnlyView = Get.arguments[4]; //true/false

  @override
  onInit() async {
    super.onInit();
    apiLoader(asyncCall: () => getTrainingType());
    if (date != '') {
      apiLoader(asyncCall: () => getWorkoutDetails());
    }

    print("this is trainee ID ${traineeId}");
    print("my id ${AppStorage.userData.result!.user.id}");
    print("this ${isOnlyView}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /////////------------add logical method below this----------------/////

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
    } else if (!isTrainingTypeSelected.value) {
      showSnackBar(title: "Alert", message: "Please select workout type");
    } else if (desKey.currentState!.checkValidation()) {
      return;
    } else {
      if (tag == 0) {
        for (var data in AppStorage.userSelectedExerciseList) {
          List<Sets>? tempSetList = [];

          for (var e in data.resourceExerciseSets) {
            if (e.repsControllers.text.toString().isNotEmpty &&
                e.weightControllers.text.toString().isNotEmpty) {
              if (int.parse(e.repsControllers.text.toString()) != 0 &&
                  int.parse(e.weightControllers.text.toString()) != 0) {
                tempSetList.add(Sets(
                    reps: int.parse(e.repsControllers.text.trim().toString()),
                    weight: int.parse(e.weightControllers.text.trim().toString())));
              } else {
                return showSnackBar(title: "Alert", message: "Sets value should not be 0");
              }
            } else {
              return showSnackBar(title: "Alert", message: "Sets value should not be empty");
            }
          }
          customWorkoutList
              .add(ResourceExercise(resourceExerciseId: data.id, setList: tempSetList));
        }
      } else {
        for (var data in AppStorage.userSelectedExerciseList) {
          if (!resourceLibList.contains(data.categoryId)) {
            resourceLibList.add(data.categoryId);
          }
        }
      }
      if (date != "") {
        apiLoader(asyncCall: () => updateWorkout());
      } else {
        apiLoader(asyncCall: () => createWorkout());
      }
    }
  }

  ///-------------------checking appbar title based on tag--------------//

  checkAppBarTitle() {
    if (isOnlyView) {
      if (tag == 0) {
        return "Custom Workout Details";
      } else {
        return "Pre-Made Workout Details";
      }
    } else {
      if (tag == 0 && date == "") {
        return "Create Custom Workout";
      } else if (tag == 1 && date == "") {
        return "Create Pre-Made Workout";
      } else if (tag == 0 && date != "") {
        return "Update Custom Workout";
      } else if (tag == 1 && date != "") {
        return 'Update Pre-Made Workout';
      }
    }
  }

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

  ///-------------------------get workout details api call-----------///

  void getWorkoutDetails() {
    var body = {
      'workoutId': id,
      'workoutDate': DateFormat('yyyy-MM-dd').format(date),
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.GET_WORKOUT_DETAILS,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        workoutDetail = workoutDetailsModelFromJson(responseBody);
        workoutNameCrt.text = workoutDetail.result!.workout.name;
        startDateCtr.text = CustomMethod.convertDateFormat(
            DateFormat('dd-MM-yyyy').format(workoutDetail.result!.workout.startDate),
            'dd-MM-yyyy',
            'dd, MMM-yyyy');
        endDateCtr.text = CustomMethod.convertDateFormat(
            DateFormat('dd-MM-yyyy').format(workoutDetail.result!.workout.endDate),
            'dd-MM-yyyy',
            'dd, MMM-yyyy');
        descCrt.text = workoutDetail.result!.workout.description;
        for (int i = 0; i < workoutDetail.result!.workoutExerciseDetails.length; i++) {
          List<ResourceExerciseSet>? tempSetList = [];

          for (var e in workoutDetail.result!.workoutExerciseDetails[i].workoutExcerciseSetsDaily) {
            tempSetList.add(ResourceExerciseSet(
                reps: e.reps, weight: e.weight, id: e.id, resourceLibraryId: '', sets: 0));
          }
          AppStorage.userSelectedExerciseList.add(Excercise(
              id: workoutDetail.result!.workoutExerciseDetails[i].resourceLibraryId,
              categoryId: tag == 0
                  ? workoutDetail.result!.workoutExerciseDetails[i].workoutId
                  : workoutDetail.result!.workoutExerciseDetails[i].categoryId,
              title: workoutDetail.result!.workoutExerciseDetails[i].title,
              image: '',
              video: '',
              videoUrl: workoutDetail.result!.workoutExerciseDetails[i].videoUrl,
              imageUrl: workoutDetail.result!.workoutExerciseDetails[i].imageUrl,
              description: workoutDetail.result!.workoutExerciseDetails[i].description,
              duration: '',
              restTimeMinutes: workoutDetail.result!.workoutExerciseDetails[i].restTimeMinutes,
              isSelected: true.obs,
              resourceExerciseSets: tempSetList));
        }
        for (var i = 0; i < trainingTypeList.length; i++) {
          if (trainingTypeList[i].id == workoutDetail.result!.workout.trainingTypeId) {
            selectedTypeIndex.value = i;
            isTrainingTypeSelected.value = true;
          }
        }
        AppStorage.userSelectedExerciseList.sort((a, b) => a.categoryId.compareTo(b.categoryId));
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  ///-------------------------get workout training tye  api call-----------///

  void getTrainingType() {
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINING_TYPE,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        TrainingTypeModel getTrainingTypeModel = trainingTypeModelFromJson(responseBody);
        trainingTypeList.addAll(getTrainingTypeModel.result);
        if (workoutDetail.result != null) {
          for (var i = 0; i < trainingTypeList.length; i++) {
            if (trainingTypeList[i].id == workoutDetail.result!.workout.trainingTypeId) {
              selectedTypeIndex.value = i;
              isTrainingTypeSelected.value = true;
            }
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

  ///-------------------------create workout  api call-----------///

  void createWorkout() {
    var body = {
      "tagName": tag == 0 ? "Custom" : "PreMade",
      "trainerId": traineeId == '' ? '' : AppStorage.userData.result!.user.id,
      "traineeId": traineeId == '' ? AppStorage.userData.result!.user.id : traineeId,
      "name": workoutNameCrt.text.tr.toString(),
      "startDate": CustomMethod.convertDateFormat(
          startDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
      "endDate":
          CustomMethod.convertDateFormat(endDateCtr.text.toString(), 'dd, MMM-yyyy', 'yyyy-MM-dd'),
      "trainingTypeId": trainingTypeList[selectedTypeIndex.value].id,
      "description": descCrt.text.tr.toString(),
      "resourceExercise": tag == 0 ? customWorkoutList : [],
      "resourceLibrary": tag == 1 ? resourceLibList : []
    };

    WebServices.postRequest(
      body: body,
      uri: EndPoints.CREATE_EXSERCISE_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        customWorkoutList.clear();
        resourceLibList.clear();
        AppStorage.userSelectedExerciseList.clear();
        var controller = Get.put(MyDiaryController());
        controller.getResourceCount('Exercise');
        if (traineeId != '') {
          var trainerCtr = Get.put(TrainerDashboardController());
          trainerCtr.trainerDashboardModel.result!.exercise.todayScheduledCount.value++;
        }
        commonBottomSheet(title: "Your workout created successfully");
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        customWorkoutList.clear();
        resourceLibList.clear();
        isLoading.value = false;
      },
    );
  }

  ///-------------------------update workout  api call-----------///

  void updateWorkout() {
    var body = {
      "tagName": tag == 0 ? "Custom" : "PreMade",
      "workoutId": id,
      "workoutDate": DateFormat('yyyy-MM-dd').format(date),
      "trainerId": traineeId == '' ? AppStorage.userData.result!.user.id : '',
      "traineeId": traineeId == '' ? AppStorage.userData.result!.user.id : traineeId,
      "name": workoutNameCrt.text.tr.toString(),
      "trainingTypeId": trainingTypeList[selectedTypeIndex.value].id,
      "description": descCrt.text.tr.toString(),
      "resourceExercise": tag == 0 ? customWorkoutList : [],
      "resourceLibrary": tag == 1 ? resourceLibList : []
    };

    WebServices.postRequest(
      body: body,
      uri: EndPoints.UPDATE_EXERCISE_WORKOUT,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        customWorkoutList.clear();
        resourceLibList.clear();
        AppStorage.userSelectedExerciseList.clear();
        isLoading.value = false;
        commonBottomSheet(title: "Your workout updated successfully");
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        customWorkoutList.clear();
        resourceLibList.clear();
        isLoading.value = false;
      },
    );
  }
}
