import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_app_widget.dart';
import '../controllers/get_location_map_controller.dart';
import 'get_location_map_components.dart';

class GetLocationMapView extends GetView<GetLocationMapController> with GetLocationMapComponents {
  GetLocationMapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.transparent,
      appBar: ScaffoldAppBar.appBar(
        title: controller.appTitle.value,
        textSize: 22.0,
      ),
      body: mapBuilder(),
    );
  }
}
