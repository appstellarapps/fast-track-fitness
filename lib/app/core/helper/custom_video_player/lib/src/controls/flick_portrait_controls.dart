import 'package:fasttrackfitness/app/core/helper/custom_video_player/lib/flick_video_player.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../modules/video_player/controllers/video_player_controller.dart';

/// Default portrait controls.
class FlickPortraitControls extends StatelessWidget {
  const FlickPortraitControls(
      {Key? key,
      this.iconSize = 20,
      this.fontSize = 12,
      this.progressBarSettings})
      : super(key: key);

  /// Icon size.
  ///
  /// This size is used for all the player icons.
  final double iconSize;

  /// Font size.
  ///
  /// This size is used for all the text.
  final double fontSize;

  /// [FlickProgressBarSettings] settings.
  final FlickProgressBarSettings? progressBarSettings;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(VideoPlayersController());
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: FlickShowControlsAction(
            child: FlickSeekVideoAction(
              child: Center(
                child: FlickVideoBuffer(
                  child: FlickAutoHideChild(
                    showIfVideoNotInitialized: false,
                    child: FlickPlayToggle(
                      size: 30,
                      color: Colors.black,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: SvgPicture.asset(ImageResourceSvg.backArrowIc)),
                      const SizedBox(width: 20,),
                      Column(
                        children: [
                          Text(controller.title,style: CustomTextStyles.medium(fontSize: 16.0, fontColor: Colors.white),),
                          Text(controller.date,style: CustomTextStyles.medium(fontSize: 10.0, fontColor: Colors.white54),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
