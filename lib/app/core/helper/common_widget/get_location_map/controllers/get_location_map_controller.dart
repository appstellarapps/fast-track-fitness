import 'dart:async';

import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart' as gCoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lc;
import 'package:permission_handler/permission_handler.dart' as ph;

import '../../custom_app_widget.dart';

class GetLocationMapController extends GetxController {
  final Completer<GoogleMapController> gMapController = Completer();
  var currentLat = 0.0.obs;
  var currentLng = (-0.0).obs;
  var appTitle = "Current Location".obs;
  CameraPosition? kGooglePlex;

  var onInitFlag = false;

  var pinSize = 70.0;
  var onMoveStarted = false;

  var locationTitle = "".obs; // Mira road
  var buttonText = "Confirm";
  var rightButtonText = "";
  String title = 'Current Location';
  var isDismissible = true;
  Function? onRightButtonPressed;
  var showCancel = false;
  var locationDesc = ''.obs;

  var _serviceEnabled = false;
  var onCurrentLocationTap = false;
  var stateName = "".obs;
  var cityName = "".obs;
  var zipCode = "".obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      appTitle.value = Get.arguments;
    }
    getCurrentLocation();
    kGooglePlex = CameraPosition(
      target: LatLng(currentLat.value, currentLng.value),
      zoom: 14.4746,
    );

    Future.delayed(const Duration(seconds: 4), () {
      onInitFlag = true;
    });

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

  showPermaDeniedPermissionDialog() {
    Get.defaultDialog(
      onWillPop: () => Future.value(false),
      title: "No Location permission",
      middleText:
          'Open settings, Grant us your location permission, then try again.\nWe will not store any location info in our data base if they are not a part of our platform. For further info read our privacy policy.',
      titlePadding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
      contentPadding: const EdgeInsets.all(20),
      textCancel: 'Open Settings',
      onCancel: () async {
        await ph.openAppSettings().then((value) {
          print('back to app');
        });
      },
    );
  }

  void getCurrentLocation() async {
    onCurrentLocationTap = true;
    GoogleMapController controller = await gMapController.future;
    lc.LocationData? currentLocation;

    lc.Location location = lc.Location();

    var _permissionGranted = await location.hasPermission();
    _serviceEnabled = await location.serviceEnabled();

    if (_permissionGranted != lc.PermissionStatus.granted || !_serviceEnabled) {
      ///asks permission and enable location dialogs
      _permissionGranted = await location.requestPermission();

      _serviceEnabled = await location.requestService();
      if (_permissionGranted == lc.PermissionStatus.deniedForever) {
        ///Do something here
        showPermaDeniedPermissionDialog();
      }
    }

    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    if (currentLocation != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 17.0,
        ),
      ));
      currentLat.value = currentLocation.latitude!;
      currentLng.value = currentLocation.longitude!;

      // _getAddressFromPlaces();
      getAddressFromLatLng();

      Future.delayed(const Duration(seconds: 2), () {
        onCurrentLocationTap = false;
      });
    }
  }

  getAddressFromLatLng() async {
    try {
      List<gCoding.Placemark> p =
          await gCoding.placemarkFromCoordinates(currentLat.value, currentLng.value);
      gCoding.Placemark place = p[0];
      printLog(place.locality);
      printLog(place.postalCode);
      hideAppLoader();
      printLog("LCOALITY SUB");
      printLog("${currentLat.value},${currentLng.value}");
      var currentAddress =
          "${place.street}, ${place.name}, ${place.subLocality} ${place.locality}, ${place.administrativeArea} ${place.country} ${place.postalCode}";
      printLog(currentAddress);
      locationTitle.value = '${place.street}';
      locationDesc.value = currentAddress;
      cityName.value = '${place.locality}';
      stateName.value = "${place.administrativeArea}";
      zipCode.value = "${place.postalCode}";

      // onMoveStarted = true;
      // _add();
    } catch (e) {
      locationTitle.value = 'Unnamed address';
      locationDesc.value = 'Unnamed address';
      // onMoveStarted = true;
      printLog(e);
      hideAppLoader(hideSnacks: true);
    }
  }
}
