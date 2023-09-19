import 'dart:async';

import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/data/search_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../core/helper/constants.dart';
import '../../../core/helper/debouncer_timer.dart';
import '../../../core/services/web_services.dart';

class GlobalSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  var searchUser = <SearchUser>[].obs;
  var isTyping = false.obs;
  var page = 1;
  var haseMore = false.obs;

  Timer? _debounce;
  var lastSearchValue = "".obs;
  var isSearchLoading = false.obs;

  final Debouncer onSearchDebouncer = Debouncer(const Duration(milliseconds: 1000));

  void searchAPI() {
    var body = {"search": searchController.text, 'page': page};
    WebServices.postRequest(
      uri: AppStorage.isLogin() ? EndPoints.GUEST_SEARCH : EndPoints.SEARCH,
      body: body,
      hasBearer: AppStorage.isLogin() ? false : true,
      onStatusSuccess: (responseBody) async {
        hideAppLoader();
        var getSearchUserModel = searchUserModelFromJson(responseBody);
        isTyping.value = false;
        searchUser.addAll(getSearchUserModel.result.data);
        haseMore.value = getSearchUserModel.result.hasMoreResults == 0 ? false : true;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);
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
        searchAPI();
      }
    }
  }

  onSearchChanged(val) {
    if (lastSearchValue.value != val) {
      lastSearchValue.value = val;
      isSearchLoading.value = true;
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(seconds: 3), () {
        if (searchController.text.isNotEmpty && val.isNotEmpty) {
          page = 1;
          searchAPI();
        }
      });
    }
  }
}
