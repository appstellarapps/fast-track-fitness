import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../custom_button.dart';
import '../../custom_print.dart';
import '../controllers/get_location_map_controller.dart';

mixin GetLocationMapComponents {
  var controller = Get.put(GetLocationMapController());

  mapBuilder() {
    var bottomPad = 0.0; //Get.height * 275 / 843.4285714285714;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: controller.kGooglePlex!,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          zoomGesturesEnabled: true,
          buildingsEnabled: false,
          myLocationButtonEnabled: false,
          // markers: markers.toSet(), //Set<Marker>.of(markers.values),
          padding: EdgeInsets.only(
              bottom: bottomPad,
              left: 15), // liteModeEnabled: GetPlatform.isAndroid ? true : false,
          onMapCreated: (GoogleMapController googleMapController) {
            controller.gMapController.complete(googleMapController);
            controller.gMapController.future.then((GoogleMapController value) {
              print(value.mapId.toString());
            });
          },
          onCameraMoveStarted: () {
            print('onCameraMoveStarted');
            controller.onMoveStarted = true;
          },
          onCameraMove: (CameraPosition cameraPosition) {
            if (controller.onMoveStarted &&
                controller.onInitFlag &&
                !controller.onCurrentLocationTap) {
              print('onCameraMoving...');

              // controller.onMoveStarted = false;
              controller.currentLat.value = cameraPosition.target.latitude;
              controller.currentLng.value = cameraPosition.target.longitude;
              // Future.delayed(const Duration(milliseconds: 1500), () {
              //   apiLoader(asyncCall: () => controller.getAddressFromLatLng());
              // });
            }
          },

          onCameraIdle: () {
            // This callback will be triggered when the camera movement stops
            controller.getAddressFromLatLng();
          },

          onTap: (LatLng latLng) {
            print('Map tapped at: ${latLng.latitude}, ${latLng.longitude}');
            controller.currentLat.value = latLng.latitude;
            controller.currentLng.value = latLng.longitude;
            // apiLoader(asyncCall: () => controller.getAddressFromLatLng());
          },
        ),
        Center(
          child: Image.asset(
            ImageResourcePng.currentLocationPinIc,
            height: controller.pinSize,
            width: controller.pinSize,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              return Transform.translate(
                offset: const Offset(8, -20),
                child: child,
              );
            },
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: FloatingActionButton(
                onPressed: controller.getCurrentLocation,
                backgroundColor: themeWhite,
                child: const Icon(Icons.my_location_rounded, color: themeBlack, size: 28),
              ),
            ),
            bottomBar(),
          ],
        ),
      ],
    );
  }

  bottomBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (controller.isDismissible) Get.back();
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              // padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0, left: 20.0, right: 20.0),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.title.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              Text(
                                controller.appTitle.value,
                                style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10)
                            ],
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on, color: Colors.red),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    controller.locationTitle.value,
                                    style: CustomTextStyles.semiBold(
                                      fontColor: themeBlack,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Text(
                                controller.locationDesc.value,
                                style:
                                    CustomTextStyles.normal(fontSize: 16.0, fontColor: themeBlack),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(height: 40),
                            ButtonRegular(
                                buttonText: controller.buttonText,
                                onPress: () {
                                  printLog(controller.locationDesc.value);
                                  Get.back(result: [
                                    controller.locationDesc.value,
                                    controller.currentLat.value,
                                    controller.currentLng.value,
                                    (controller.locationTitle.value),
                                    (controller.cityName.value),
                                    (controller.stateName.value),
                                    (controller.zipCode.value)
                                  ]);
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // openGeneralMessageDialog()
      ],
    );
  }
}
