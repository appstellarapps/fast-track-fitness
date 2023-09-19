import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../core/helper/custom_video_player/lib/flick_video_player.dart';

class VideoPlayersController extends GetxController {
  //TODO: Implement VideoPlayerController

  FlickManager flickManager = FlickManager(
    videoPlayerController:
    VideoPlayerController.networkUrl(Uri.parse(Get.arguments[0])),
  );
  var title = Get.arguments[1] ;
  var date = Get.arguments[2] ;

  @override
  Future<void> onInit() async {
    super.onInit();
    SystemChrome.setPreferredOrientations(
       [DeviceOrientation.landscapeLeft,]);

    
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    flickManager.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
    super.onClose();
  }

  static network(String s) {}


}
