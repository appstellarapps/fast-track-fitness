import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lc;
import 'package:location/location.dart';

import '../../../../../core/helper/app_storage.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/constants.dart';
import '../../../../../core/helper/map_helper.dart';
import '../../../../../core/helper/map_marker.dart';
import '../../../../../core/services/notification_services.dart';
import '../../../../../data/get_nearby_trainer_model.dart';
import '../views/trainee_dashboard_components.dart';

class TraineeDashboardController extends GetxController {
  late CameraPosition kGooglePlex;
  DateTime? currentBackPressTime;

  Completer<GoogleMapController> mapController = Completer();

  final Set<Marker> userMarkers = {};
  final count = 0.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final advancedDrawerController = AdvancedDrawerController();
  final List<MapMarker> markers = [];

  var serviceEnabled = false;
  var isMarkerLoaded = true.obs;
  var showMapView = true.obs;
  var filterTrainingTypeId = [];
  var filterRatings = [];
  var filterTiming = "";
  var kidFriendly = "All";
  var range = 50;
  var filterTrainingModeId = [];
  var showCard = false.obs;
  var selectedCardIndex = 0.obs;
  var widgetRefresher = "".obs;
  var currentLat = 45.521563.obs;
  var currentLng = (-122.677433).obs;
  var profilePictureUrl = "".obs;
  var fullName = "".obs;
  var selectedTab = 0.obs;
  var userName = "".obs;
  var profilePic = "".obs;
  var permissionGranted;
  var hasFilterApplied = false.obs;
  var nearestTrainers = <NearTrainer>[].obs;
  var permissionCount = 0;
  var deviceToken = '';
  var deviceType = '';
  var isDashboardLoading = false.obs;

  Location location = Location();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    requestLocationPermission();
    kGooglePlex = CameraPosition(
      target: LatLng(currentLat.value, currentLng.value),
      zoom: 14.4746,
    );
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> onWillPop() {
    showSnackBar(
      title: "Exit",
      message: "Double tap again to exit",
    );
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  getDeviceInfo(lat, lng) async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken = androidDeviceInfo.id;
      deviceType = 'android';
    } else {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken = iosDeviceInfo.identifierForVendor!;
      deviceType = 'ios';
    }

    if (AppStorage.isLogin()) {
      getDeviceInfoApi(lat: lat, lng: lng);
      initPushNotify();
    } else {
      isDashboardLoading.value = false;
    }
  }

  requestLocationPermission() async {
    final hasPermission = await location.requestPermission();
    final servicePermission = await location.requestService();
    if (!servicePermission) {
      requestLocationPermission();
    } else if (hasPermission == PermissionStatus.denied) {
      TraineeDashboardComponents.locationBottomSheet();
    } else if (hasPermission == PermissionStatus.deniedForever) {
      TraineeDashboardComponents.locationBottomSheet();
    } else {
      apiLoader(asyncCall: () => getCurrentLocation());
    }
  }

  void getCurrentLocation() async {
    GoogleMapController controller = await mapController.future;
    lc.LocationData? currentLocation;
    lc.Location location = lc.Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    if (currentLocation != null) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
            zoom: 17.0,
          ),
        ),
      );
      currentLat.value = currentLocation.latitude!;
      currentLng.value = currentLocation.longitude!;
      kGooglePlex = CameraPosition(
        target: LatLng(currentLat.value, currentLng.value),
        zoom: 14.4746,
      );
      if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINEE || !AppStorage.isLogin()) {
        isDashboardLoading.value = true;
        await getNearbyTrainerAPI(lat: currentLat.value, lng: currentLng.value);
        await getDeviceInfo(currentLat.value, currentLng.value);
      } else {
        hideAppLoader();
      }
    }
  }

  getNearbyTrainerAPI({lat, lng}) {
    var body = {
      "latitude": lat,
      "longitude": lng,
      "range": range,
      "trainingTypesId": filterTrainingTypeId,
      "ratting": filterRatings,
      "trainingModesId": filterTrainingModeId,
      "shifting": filterTiming,
      "kidFriendly": kidFriendly
    };
    WebServices.postRequest(
      uri: EndPoints.GET_NEAR_BY_TRAINER,
      body: body,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        GetNearByTrainerModel getNearByTrainerModel;
        getNearByTrainerModel = getNearByTrainerModelFromJson(responseBody);
        if (getNearByTrainerModel.status == 1) {
          nearestTrainers.value = getNearByTrainerModel.result.user;

          initMarkers(nearestTrainers.value);

          selectedTab.value = 0;
          if (AppStorage.isLogin()) {
            userName.value = AppStorage.userData.result!.user.fullName.toString();
            profilePic.value = AppStorage.userData.result!.user.profilePic.toString();
            profilePictureUrl.value = profilePic.value;
            fullName.value = userName.value;
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  getDeviceInfoApi({lat, lng}) {
    var body = {
      "userId": AppStorage.userData.result!.user.id,
      "deviceToken": deviceToken,
      "deviceType": deviceType,
      "fcmToken": AppStorage.fcmToken,
      "latitude": lat,
      "longitude": lng
    };
    WebServices.postRequest(
      uri: EndPoints.Device_Info,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        isDashboardLoading.value = false;

        var res = jsonDecode(responseBody);
        AppStorage.isNotificationIsRead.value =
            res['result']['notificationIsRead'] == 0 ? false : true;
        hideAppLoader();
      },
      onFailure: (error) {
        isDashboardLoading.value = false;

        hideAppLoader(hideSnacks: false);
      },
    );
  }

  initMarkers(List<NearTrainer> trainers) async {
    markers.clear();
    for (int i = 0; i < trainers.length; i++) {
      final BitmapDescriptor markerImage =
          await MapHelper.getMarkerImageFromUrl(trainers[i].userMarkerImage, targetWidth: 120);
      markers.add(
        MapMarker(
          id: LatLng(double.parse(trainers[i].latitude), double.parse(trainers[i].longitude))
              .toString(),
          position: LatLng(double.parse(trainers[i].latitude), double.parse(trainers[i].longitude)),
          icon: markerImage,
          trainerId: trainers[i].id,
        ),
      );
    }

    userMarkers.clear();
    for (int i = 0; i < markers.length; i++) {
      MapMarker? marker = markers[i];
      userMarkers.add(
        Marker(
          markerId: MarkerId(marker.id!),
          position: marker.position!,
          icon: marker.icon!,
          onTap: () {
            selectedCardIndex.value = i;
            showCard.value = true;
          },
        ),
      );
    }

    isMarkerLoaded.value = false;
  }
}
