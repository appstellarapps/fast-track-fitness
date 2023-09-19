import 'dart:async';

import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/debouncer_timer.dart';
import '../../../../data/common/common_models.dart';
import '../../../../data/training_type_model.dart';

class TrainingTypeController extends GetxController {

  Timer? timer;
  int start = 3;
  TextEditingController searchController = TextEditingController();

  RxList<TrainingTypes> trainingTypes = <TrainingTypes>[].obs;
  List<EditTrainingTypeListModel> initialTrainingTypeData = [];
  var isTyping = false.obs;
  var isLoading = true.obs;
  final Debouncer onSearchDebouncer = Debouncer(const Duration(milliseconds: 1000));


  @override
  void onInit() {
    apiLoader(asyncCall: () => getTrainingType());
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
    var body = {"search": searchController.text};
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINING_TYPE,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();

        TrainingTypeModel getTrainingTypeModel;
        getTrainingTypeModel = trainingTypeModelFromJson(responseBody);
        if (getTrainingTypeModel.status == 1) {
          trainingTypes.value = getTrainingTypeModel.result;
          if (Get.arguments != null) {
            initialTrainingTypeData = Get.arguments;
            var initialTypes = [];
            for (var element in initialTrainingTypeData) {
              initialTypes.add(element.id);
            }
            printLog(initialTypes.length);
            printLog("DAs");
            for (var element in trainingTypes) {
              printLog(element.id);
              printLog(initialTypes);
              if (initialTypes.contains(element.id)) {
                element.isSelected.value = true;
              }
            }
            trainingTypes.refresh();
            isTyping.value = false;
          }

          isLoading.value = false;
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

}
