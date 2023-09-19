import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/common_drop_down_data.dart';
import 'package:fasttrackfitness/app/data/training_mode_model.dart';
import 'package:fasttrackfitness/app/data/training_type_model.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/constants.dart';
import '../../../../../data/common/common_models.dart';

var filtersList = [].obs;
var ratingFiltersList = [].obs;
var shiftingFilter = [].obs;
var kidFriendlyFilter = [].obs;
var trainingTypes = [].obs;
var trainingModes = [].obs;

var trainingTypeId = [];
var ratings = [];
var trainingModeId = [];
var shifting = "";
var kidFriendly = 'All';
var range = "";
var filterRange = 50.obs;
var filterTrainingTypesIds = [].obs;
var filterRatings = [].obs;
var filterTrainingModeIds = [].obs;
var filterShifting = "".obs;
var initialRange = 50.0.obs;

class FilterViewController extends GetxController {
  @override
  void onInit() {
    if (filtersList.isEmpty) {
      getRatingTypes();
      getTrainingType();
      getTrainingModes();
      initialRange.value = filterRange.value.toDouble();
      filtersList.add(FiltersModel(title: "Training Type"));
      filtersList.add(FiltersModel(title: "Ratings"));
      filtersList.add(FiltersModel(title: "Time"));
      filtersList.add(FiltersModel(title: "Training Mode"));
      filtersList.add(FiltersModel(title: "Kid Friendly"));

      shiftingFilter.add(ShiftingFilter(id: "All", title: "All"));
      shiftingFilter.add(ShiftingFilter(id: "0", title: "Morning AM"));
      shiftingFilter.add(ShiftingFilter(id: "1", title: "Afternoon PM"));

      kidFriendlyFilter.add(KidFriendlyFilterModel(title: "Yes"));
      kidFriendlyFilter.add(KidFriendlyFilterModel(title: "No"));

      for (var element in shiftingFilter) {
        if (filterShifting == element.title) {
          element.isSelected.value = true;
        }
      }
    }
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

  void getTrainingType() {
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINING_TYPE,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        trainingTypes.clear();

        TrainingTypeModel getTrainingTypeModel;
        getTrainingTypeModel = trainingTypeModelFromJson(responseBody);
        if (getTrainingTypeModel.status == 1) {
          var trainingType = TrainingTypes(
              id: "",
              userId: "",
              title: "All",
              isActive: 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now());
          trainingTypes.add(trainingType);
          trainingTypes.addAll(getTrainingTypeModel.result);
          for (var element in trainingTypes) {
            if (filterTrainingTypesIds.contains(element.id)) {
              element.isSelected.value = true;
            }
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void getTrainingModes() {
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINING_MODE,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        trainingModes.clear();
        TrainingModeModel getTrainingModeModel;
        getTrainingModeModel = trainingModeModelFromJson(responseBody);
        if (getTrainingModeModel.status == 1) {
          var trainingMode = TrainingMode(
              id: "",
              userId: "",
              title: "All",
              isActive: 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now());
          trainingModes.add(trainingMode);
          trainingModes.addAll(getTrainingModeModel.result);
          for (var element in trainingModes) {
            if (filterTrainingModeIds.contains(element.id)) {
              element.isSelected.value = true;
            }
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void getRatingTypes() {
    ratingFiltersList.clear();
    WebServices.postRequest(
      uri: EndPoints.GET_STATIC_DROP_DOWN,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        GetStaticDdData staticDropDownDataModel;
        staticDropDownDataModel = getStaticDdDataFromJson(responseBody);
        // if (LogicalComponents.staticDropDownDataModel.status == 1) {
        var ratting = staticDropDownDataModel.result.data.rattingDropdown;
        var ratingFilter = RatingFilterModel(title: "All");
        ratingFiltersList.add(ratingFilter);
        for (var element in ratting) {
          ratingFiltersList.add(RatingFilterModel(title: element.toString()));
        }
        for (var element in ratingFiltersList) {
          if (filterRatings.contains(element.title)) {
            element.isSelected.value = true;
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }
}
