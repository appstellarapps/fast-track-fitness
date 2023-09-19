import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/debouncer_timer.dart';
import '../../../../core/services/web_services.dart';
import '../../../../data/exercise_library_model.dart';

class ExerciseLibraryController extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController searchCtr = TextEditingController();

  final GlobalKey<CustomTextFormFieldState> searchKey = GlobalKey<CustomTextFormFieldState>();
  final Debouncer onSearchDebouncer = Debouncer(const Duration(milliseconds: 1000));

  Timer? _debounce;

  var isLoading = true.obs;
  var exerciseList = <Exercise>[].obs;
  var isSelected = false.obs;
  var haseMore = false.obs;
  var page = 1;
  var tag = Get.arguments[0];
  var isMeal = Get.arguments[1];
  var lastSearchValue = "".obs;
  var isSearchLoading = false.obs;
  var isTyping = false.obs;

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

  checkTime(timeString) {
    Duration duration = Duration(
      hours: int.parse(timeString.split(':')[0]),
      minutes: int.parse(timeString.split(':')[1]),
      seconds: int.parse(timeString.split(':')[2]),
    );
    if (duration.inMinutes > 0.60) {
      return "${duration.inMinutes} Minute";
    } else {
      return "${duration.inSeconds} Seconds";
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

  onSearchChanged(val) {
    if (lastSearchValue.value != val) {
      lastSearchValue.value = val;
      isSearchLoading.value = true;
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(seconds: 3), () {
        if (searchCtr.text.isNotEmpty && val.isNotEmpty) {
          page = 1;
          getExerciseLibrary();
        }
      });
    }
  }
}
