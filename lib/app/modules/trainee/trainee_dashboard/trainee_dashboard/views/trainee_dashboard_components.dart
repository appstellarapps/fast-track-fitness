import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/trainee/my_sessions/views/my_sessions_view.dart';
import 'package:fasttrackfitness/app/modules/trainee/resources/controllers/resources_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/helper/app_storage.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_button.dart';
import '../../../../../data/get_nearby_trainer_model.dart';
import '../../../../../routes/app_pages.dart';
import '../../../my_diary/controllers/my_diary_controller.dart';
import '../../../my_diary/views/my_diary_view.dart';
import '../../../my_sessions/controllers/my_sessions_controller.dart';
import '../../../resources/views/resources_view.dart';
import '../controllers/trainee_dashboard_controller.dart';

mixin TraineeDashboardComponents {
  var controller = Get.put(TraineeDashboardController());

  traineeDashboardView() {
    return Stack(
      children: [
        Visibility(visible: false, child: Text(controller.widgetRefresher.value)),
        Obx(() => controller.showMapView.value ? mapView() : listView()),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 100, right: 16.0),
            child: Stack(alignment: Alignment.topRight, children: [
              commonIcon(
                ImageResourceSvg.filterIc,
                onTap: () {
                  controller.showCard.value = false;
                  Get.toNamed(Routes.FILTER_VIEW)!.then((value) {
                    if (value != null) {
                      controller.range = value[0];
                      controller.filterTrainingTypeId = value[1];
                      controller.filterRatings = value[2];
                      controller.filterTrainingModeId = value[3];
                      controller.filterTiming = value[4];
                      controller.kidFriendly = value[5].toString();
                      if (controller.filterTrainingTypeId.isNotEmpty ||
                          controller.filterRatings.isNotEmpty ||
                          controller.filterTrainingModeId.isNotEmpty ||
                          controller.filterTiming.isNotEmpty ||
                          controller.kidFriendly != "All" ||
                          controller.range != 50) {
                        controller.hasFilterApplied.value = true;
                      } else {
                        controller.hasFilterApplied.value = false;
                      }
                      apiLoader(asyncCall: () => controller.getCurrentLocation());
                    }
                    controller.isMarkerLoaded.value = true;
                  });
                },
              ),
              controller.hasFilterApplied.value
                  ? const Padding(
                      padding: EdgeInsets.only(top: 4.0, right: 6.0),
                      child: CircleAvatar(radius: 4.0, backgroundColor: themeGreen))
                  : const SizedBox.shrink(),
            ]),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 94, right: 16.0, left: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => commonIcon(
                    !controller.showMapView.value
                        ? ImageResourceSvg.mapIc
                        : ImageResourceSvg.listViewIc,
                    onTap: () {
                      controller.showMapView.value = !controller.showMapView.value;
                      if (controller.showCard.value) {
                        controller.showCard.value = false;
                      }
                    },
                  ),
                ),
                Obx(() => controller.showCard.value ? singleCard() : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  commonIcon(icon, {Function? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: themeWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.0, 0.15),
              color: const Color(0xffBCBCBC).withOpacity(0.50),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            )
          ],
        ),
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(icon),
      ),
    );
  }

  mapView() {
    return controller.isMarkerLoaded.value ? googleMapView() : googleMapView();
  }

  googleMapView() {
    return GoogleMap(
      onTap: (val) {
        if (controller.showCard.value == true) {
          controller.showCard.value = false;
        }
      },
      mapType: MapType.normal,
      initialCameraPosition: controller.kGooglePlex,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: false,
      minMaxZoomPreference: const MinMaxZoomPreference(0, 100),
      mapToolbarEnabled: false,
      onCameraMove: (val) {
        // printLog(val);
      },
      onMapCreated: (GoogleMapController googleMapController) {
        if (!controller.mapController.isCompleted) {
          controller.mapController.complete(googleMapController);
        } else {
          //other calling, later is true,
          //don't call again completer()
        }
      },
      markers: controller.userMarkers,
    );
  }

  listView() {
    return Obx(
      () => controller.nearestTrainers.isEmpty
          ? noDataFound()
          : controller.isDashboardLoading.value
              ? const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: themeGreen,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(
                    top: 100,
                    bottom: 100,
                    left: 20.0,
                    right: 20.0,
                  ),
                  itemBuilder: (context, index) {
                    return itemCard(controller.nearestTrainers[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16.0);
                  },
                  itemCount: controller.nearestTrainers.length),
    );
  }

  itemCard(NearTrainer trainers) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: themeWhite,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                color: dropShadow8,
                blurRadius: 20.0,
                spreadRadius: 1.0)
          ]),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            circleProfileNetworkImage(
                              networkImage: trainers.profileImage,
                              height: 48,
                              width: 48,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 2.0,
                          right: 0.5,
                          child: SvgPicture.asset(
                            trainers.onlineStatus == "Active"
                                ? ImageResourceSvg.onlineIc
                                : ImageResourceSvg.offlineIc,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Text(
                      "${trainers.firstName} ${trainers.lastName}",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 16.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      trainers.userSpecialist.title ?? "",
                      style: CustomTextStyles.normal(
                        fontSize: 14.0,
                        fontColor: themeGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(ImageResourceSvg.achievementsIc),
                              const SizedBox(width: 20.0),
                              trainers.qualificationFileStatus == "Pending"
                                  ? const SizedBox.shrink()
                                  : SvgPicture.asset(ImageResourceSvg.badgeIc),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.TRAINER_PROFILE, arguments: trainers.id);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                            decoration: const BoxDecoration(
                              color: themeGreen,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "View Profile",
                              style:
                                  CustomTextStyles.semiBold(fontSize: 16.0, fontColor: themeBlack),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8.0,
            left: 26.0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              color: themeYellow,
              child: Column(
                children: [
                  SvgPicture.asset(
                    ImageResourceSvg.starIc,
                    color: themeWhite,
                    height: 10,
                    width: 10,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    trainers.averageRatting.toString(),
                    style: CustomTextStyles.medium(fontColor: themeWhite, fontSize: 12.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  singleCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: themeWhite,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 10),
                  color: dropShadow8,
                  blurRadius: 20.0,
                  spreadRadius: 1.0)
            ]),
        child: controller.nearestTrainers[controller.selectedCardIndex.value] == null
            ? noDataFound()
            : Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(mainAxisSize: MainAxisSize.max, children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    circleProfileNetworkImage(
                                      networkImage: controller
                                          .nearestTrainers[controller.selectedCardIndex.value]
                                          .profileImage,
                                      height: 48,
                                      width: 48,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: 2.0,
                                  right: 0.5,
                                  child: SvgPicture.asset(controller
                                              .nearestTrainers[controller.selectedCardIndex.value]
                                              .onlineStatus ==
                                          "Active"
                                      ? ImageResourceSvg.onlineIc
                                      : ImageResourceSvg.offlineIc),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            Text(
                              "${controller.nearestTrainers[controller.selectedCardIndex.value].firstName} ${controller.nearestTrainers[controller.selectedCardIndex.value].lastName}",
                              style: CustomTextStyles.semiBold(
                                fontColor: themeBlack,
                                fontSize: 16.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              controller.nearestTrainers[controller.selectedCardIndex.value]
                                  .userSpecialist.title,
                              style: CustomTextStyles.normal(
                                fontSize: 14.0,
                                fontColor: themeGrey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 14.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageResourceSvg.achievementsIc),
                                      const SizedBox(width: 20.0),
                                      controller.nearestTrainers[controller.selectedCardIndex.value]
                                                  .qualificationFileStatus ==
                                              "Pending"
                                          ? const SizedBox.shrink()
                                          : SvgPicture.asset(ImageResourceSvg.badgeIc),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.TRAINER_PROFILE,
                                        arguments: controller
                                            .nearestTrainers[controller.selectedCardIndex.value]
                                            .id);
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                                    decoration: const BoxDecoration(
                                      color: themeGreen,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      "View Profile",
                                      style: CustomTextStyles.medium(
                                        fontSize: 16.0,
                                        fontColor: themeBlack,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 8.0,
                    left: 27.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                      color: themeYellow,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            ImageResourceSvg.starIc,
                            color: themeWhite,
                            height: 10,
                            width: 10,
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            controller
                                .nearestTrainers[controller.selectedCardIndex.value].averageRatting
                                .toStringAsFixed(1),
                            style: CustomTextStyles.medium(fontColor: themeWhite, fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  commonTab(index, {icon, activeText}) {
    return Obx(
      () => InkWell(
        onTap: () async {
          if (controller.isDashboardLoading.isFalse) {
            Get.closeAllSnackbars();
            if (controller.selectedTab.value != index) {
              controller.selectedTab.value = index;
              if (!AppStorage.isLogin()) {
                if (controller.selectedTab.value == 1 || controller.selectedTab.value == 3) {
                  CustomMethod.guestDialog();
                }
              }
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
          decoration: BoxDecoration(
            color: controller.selectedTab.value == index ? themeGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: controller.selectedTab.value != index
              ? SvgPicture.asset(
                  icon,
                  color: const Color(0xff030303).withOpacity(0.50),
                  height: 24,
                  width: 24,
                )
              : Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      color: themeBlack,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      activeText,
                      style: CustomTextStyles.medium(
                        fontColor: themeBlack,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  screens() {
    if (controller.selectedTab.value == 0) {
      // var crt = Get.put(TraineeDashboardController());
      // crt.onInit();
      return traineeDashboardView();
    } else if (controller.selectedTab.value == 1) {
      if (AppStorage.isLogin()) {
        var controller = Get.put(MySessionsController());
        controller.traineeBookingHistoryListPage = 1;
        controller.traineeUpcomingBookingsListPage = 1;
        controller.traineeOngoingBookingsListPage = 1;
        controller.isLoading.value = true;

        controller.onInit();
        return MySessionsView();
      } else {
        return Container();
      }
    } else if (controller.selectedTab.value == 2) {
      var ctr = Get.put(MyDiaryController());
      AppStorage.isLogin() ? ctr.selectTabIndex.value = 0 : ();
      ctr.onInit();
      return MyDiaryView();
    } else {
      var ctr = Get.put(ResourcesController());
      ctr.selectTabIndex.value = 0;
      ctr.page = 1;
      ctr.isLoading.value = true;
      ctr.searchCtr.clear();
      ctr.onInit();
      return ResourcesView();
    }
  }

  static locationBottomSheet() {
    return Get.bottomSheet(
        SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                color: themeWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    "App required location permission",
                    style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 40.0,
                  ),
                  child: ButtonRegular(
                    verticalPadding: 14.0,
                    buttonText: "OK",
                    onPress: () {
                      openAppSettings();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: false);
  }
}
