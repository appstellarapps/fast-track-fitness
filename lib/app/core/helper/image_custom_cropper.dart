import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageCropper {
  Future<String> imagePicker(source) async {
    File imagePath = File("");
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: source, imageQuality: 50);

      if (pickedImage != null) {



        final croppedImage = await ImageCropper().cropImage(
          sourcePath: pickedImage.path,
          aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],

          uiSettings: [
            AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: themeBlack,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
            IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: false,
          ),]
        );

        final croppedFile = File(croppedImage!.path);
        imagePath = croppedFile;
        printLog("Image path: ${croppedFile.path}");
      }
    } on PlatformException catch (e) {
      printLog("Failed to pick or crop image: $e");
    }
    return imagePath.path.toString();
  }
}
