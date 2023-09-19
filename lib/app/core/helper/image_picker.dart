import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomFilePicker {
  static imagePick(context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () {
                    var image = imagePicker(fromCamera: false);
                    Get.back(result: image);
                  },
                  child: Text(
                    "Choose from Gallery",
                    style: CustomTextStyles.normal(fontSize: 16.0, fontColor: themeBlack),
                  )),
              CupertinoActionSheetAction(
                  onPressed: () {
                    var image = imagePicker(fromCamera: true);
                    Get.back(result: image);
                  },
                  child: Text(
                    "Take Picture",
                    style: CustomTextStyles.normal(fontSize: 16.0, fontColor: themeBlack),
                  )),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                "Cancel",
                style: CustomTextStyles.bold(fontSize: 16.0, fontColor: themeBlack),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          );
        });
  }
}

imagePicker({
  required fromCamera,
}) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery, imageQuality: 70);
  if (image != null) {
    return (image.path);
  }
}
