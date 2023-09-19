import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({
    Key? key,
    this.image,
  }) : super(key: key);
  final String? image;

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  final GlobalKey<CustomTextFormFieldState> inputKey = GlobalKey<CustomTextFormFieldState>();
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Get.back();
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: SvgPicture.asset(ImageResourceSvg.closeIcWithCircle),
                      )
                    ],
                  ),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.image ?? "",
                      height: Get.height / 2,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
