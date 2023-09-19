import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/constants.dart';
import '../../../../../core/services/web_services.dart';
import '../../../../../data/review_model.dart';

class ReviewListController extends GetxController {
  ScrollController scrollController = ScrollController();

  RxList<ReviewList> reviewList = RxList<ReviewList>();
  late ReviewModel reviewModel;

  var overAllRating = "0".obs;
  var overAllRatingCount = "0".obs;
  var haseMore = false.obs;
  var page = 1;
  var isReview = 0.obs;
  var isWritable = 0.obs;

  var trainerId = Get.arguments[0];
  var isLoading = true.obs;

  @override
  void onInit() {
    scrollController = ScrollController(keepScrollOffset: true);
    apiLoader(asyncCall: () => getReviewListAPI());
    super.onInit();
  }

  scroll() {
    if (scrollController.position.maxScrollExtent - 500 == scrollController.position.pixels - 500) {
      if (haseMore.value) {
        page++;
        getReviewListAPI();
      }
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

  void getReviewListAPI() {
    WebServices.postRequest(
      body: {'trainerId': trainerId, 'page': page},
      uri: EndPoints.GET_COMMON_REVIEW,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        reviewModel = reviewModelFromJson(responseBody);

        overAllRating.value = reviewModel.result.reviewsAvg.toString();
        overAllRatingCount.value = reviewModel.result.reviewsCount.toString();
        isReview.value = reviewModel.result.isReview;
        isWritable.value = reviewModel.result.isWritable;
        reviewList.value = reviewModel.result.data;
        haseMore.value = reviewModel.result.hasMoreResults == 0 ? false : true;
        isLoading.value = false;
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }
}
