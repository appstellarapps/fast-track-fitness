import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/debouncer_timer.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/trainee_model.dart';

class ExerciseDiaryController extends GetxController {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  var exerciseDiaryList = <TraineeUser>[].obs;
  var isTyping = false.obs;
  var isLoading = true.obs;
  var haseMore = false.obs;
  var page = 1;

  Timer? _debounce;
  var lastSearchValue = "".obs;
  var isSearchLoading = false.obs;

  final Debouncer onSearchDebouncer = Debouncer(const Duration(milliseconds: 1000));

  var isFrom = Get.arguments; // 0 = Exercise Diary, 1 = Nutrition Diary

  @override
  void onInit() {
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);
    apiLoader(asyncCall: () => getExerciseDiaryListAPI());

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
        getExerciseDiaryListAPI();
      }
    }
  }

  void getExerciseDiaryListAPI() {
    var body = {"search": searchController.text, 'page': page};
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINEE_LIST,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) async {
        hideAppLoader();
        isLoading.value = false;
        var getTraineeModel = traineeModelFromJson(responseBody);
        isTyping.value = false;
        exerciseDiaryList.clear();
        exerciseDiaryList.addAll(getTraineeModel.result.traineeUser);
        exerciseDiaryList.refresh();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  onSearchChanged(val) {
    if (lastSearchValue.value != val) {
      lastSearchValue.value = val;
      isSearchLoading.value = true;
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(seconds: 3), () {
        if (searchController.text.isNotEmpty && val.isNotEmpty) {
          getExerciseDiaryListAPI();
        }
      });
    }
  }
}
