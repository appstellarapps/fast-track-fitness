import 'package:fasttrackfitness/app/data/history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../core/helper/constants.dart';
import '../../../core/services/web_services.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  ScrollController scrollController = ScrollController();

  var haseMore = false.obs;
  var page = 1;
  var isLoading = true.obs;
  var historyList = <History>[].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);
    apiLoader(asyncCall: () => getHistory());
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
        getHistory();
      }
    }
  }

  void getHistory() {
    var body = {'page': page};
    WebServices.postRequest(
      body: body,
      uri: EndPoints.SUBSCRIPATION_HISTROY,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();

        HistoryModel historyModel = historyModelFromJson(responseBody);
        historyList.addAll(historyModel.result.histories!);
        haseMore.value = historyModel.result.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }
}
