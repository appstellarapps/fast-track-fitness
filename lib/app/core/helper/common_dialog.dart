import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/upload_media_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../data/get_my_trainer_profile_model.dart';
import 'app_storage.dart';
import 'common_widget/custom_app_widget.dart';
import 'constants.dart';
import 'helper.dart';
import 'image_custom_cropper.dart';

class CommonDialogView extends StatefulWidget {
  const CommonDialogView({
    Key? key,
    this.widget,
    this.title = "",
    this.message,
    this.onLButtonPress,
    this.onRButtonPress,
    this.titleColor,
    this.buttonWidget,
    this.lButtonText,
    this.rButtonText,
    this.height,
    this.isShowCloseButton = false,
    this.isDismissable = false,
    this.showTitle = true,
    this.inputHint,
    this.hasAttachment = true,
    this.type,
  }) : super(key: key);
  final Widget? widget;
  final String title;
  final String? message;
  final Function? onLButtonPress;
  final Function? onRButtonPress;
  final Color? titleColor;
  final Widget? buttonWidget;
  final String? lButtonText;
  final String? rButtonText;
  final double? height;
  final bool isShowCloseButton;
  final bool isDismissable;
  final bool showTitle;
  final String? inputHint;
  final bool hasAttachment;
  final String? type;

  @override
  _CommonDialogViewState createState() => _CommonDialogViewState();
}

class _CommonDialogViewState extends State<CommonDialogView> {
  final GlobalKey<CustomTextFormFieldState> inputKey = GlobalKey<CustomTextFormFieldState>();
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (widget.isDismissable) Get.back();
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 14.0,
                    right: 14.0,
                  ),
                  child: Container(
                    margin: EdgeInsets.zero,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: widget.widget ??
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            widget.showTitle
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      widget.title.isEmpty ? "Add Certificate" : widget.title,
                                      style: CustomTextStyles.semiBold(
                                        fontColor: themeBlack,
                                        fontSize: 18.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Container(),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomTextFormField(
                                  key: inputKey,
                                  isOptional: true,
                                  controller: inputController,
                                  hintText: widget.inputHint ?? "Certificate name here",
                                  hasBorder: true,
                                  borderColor: borderColor,
                                  contentPadding: EdgeInsets.zero,
                                  fontColor: themeBlack,
                                )),
                            widget.hasAttachment
                                ? InkWell(
                                    onTap: () async {
                                      if (widget.type == "certificate" ||
                                          widget.type == "Insurance_Certificate") {
                                        final result = await FilePicker.platform.pickFiles(
                                          allowMultiple: false,
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf'],
                                        );

                                        if (result == null) return;

                                        /*if (result != null) {
                                          List<UserQualificationFile>? data = result as List<UserQualificationFile>?;
                                          controller.trainerQualifications.value = data!;
                                          controller.trainerQualifications.refresh();
                                        }*/

                                        // we get the file from result object
                                        final file = result.files.first;
                                        selectedAttachment.value = File(file.path!);
                                        selectedAttachmentPath.value = file.name!;
                                      } else {
                                        imageUploadOptionSheet(
                                            title1: "Upload Image",
                                            title2: "Upload Video",
                                            onPressTitle1: () {
                                              getImage();
                                            },
                                            onPressTitle2: () {
                                              pickVideo();
                                            });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            ImageResourceSvg.pdfIc,
                                            color: themeGreen,
                                          ),
                                          Obx(
                                            () => Expanded(
                                              child: Text(
                                                selectedAttachmentPath.value.isEmpty
                                                    ? "  " "Attach Document"
                                                    : "  ${selectedAttachmentPath.value}",
                                                style: CustomTextStyles.semiBold(
                                                  fontSize: 14.0,
                                                  fontColor: themeBlack,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 20.0),
                            widget.buttonWidget ??
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          if (widget.onLButtonPress != null) {
                                            widget.onLButtonPress!();
                                          } else {
                                            Get.back();
                                          }
                                        },
                                        child: Container(
                                          height: 46,
                                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: borderColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: SafeArea(
                                            child: Text(widget.lButtonText ?? "Cancel",
                                                style: CustomTextStyles.semiBold(
                                                    fontColor: themeGrey, fontSize: 16.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Get.closeAllSnackbars();
                                          if (inputController.text.isEmpty) {
                                            showSnackBar(
                                                title: "Error",
                                                message: "Please enter something",
                                                duration: 1.seconds);
                                          } else if (selectedAttachment.value.path.isEmpty) {
                                            showSnackBar(
                                                title: "Error",
                                                message: "Please Attach Document",
                                                duration: 1.seconds);
                                          } else {
                                            if (widget.type == "certificate") {
                                              apiLoader(
                                                  asyncCall: () =>
                                                      updateQualificationCertificate());
                                            } else if (widget.type == "Insurance_Certificate") {
                                              apiLoader(
                                                  asyncCall: () =>
                                                      updateQualificationCertificate());
                                            } else {
                                              apiLoader(asyncCall: () => addAchievements());
                                            }
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 46,
                                          decoration: const BoxDecoration(
                                            color: themeGreen,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: SafeArea(
                                            child: Text(widget.rButtonText ?? "Save",
                                                style: CustomTextStyles.semiBold(
                                                  fontSize: 16.0,
                                                  fontColor: themeBlack,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                          ],
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();
  var selectedAttachmentPath = "".obs;
  var selectedAttachment = File("").obs;
  var thumbnail = File("").obs;

  Future getImage({ImageSource? resource}) async {
    Helper().hideKeyBoard();
    if (Get.isBottomSheetOpen!) Get.back();

    File profileImage;
    final pickedFile = await CustomImageCropper().imagePicker(resource);

    if (pickedFile != null) {
      profileImage = File(pickedFile);

      selectedAttachment.value = profileImage;
      var paths = profileImage.path;
      var selectedPath = paths.split("/");
      printLog(selectedPath.last);
      selectedAttachmentPath.value = selectedPath.last;
    }

    /*File profileImage;
    final pickedFile =
        await picker.pickImage(source: resource ?? ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);*/

    /*await Get.to(
        () => CustomImageCropper(
          profile: profileImage,
        ),
      )!
          .then((result) {
        if (result != null) {
          if (result[0]) {
            selectedAttachment.value = result[1];
            var paths = result[1].path;
            var selectedPath = paths.split("/");
            print(selectedPath.last);
            selectedAttachmentPath.value = selectedPath.last;
          }
        }
      });*/
  }

  Future pickVideo() async {
    Get.back();
    FocusScope.of(context).requestFocus(FocusNode());
    ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 5),
    );
    if (file != null) {
      thumbnail.value = await VideoCompress.getFileThumbnail(file.path,
          quality: 50, // default(100)
          position: -1 // default(-1)
          );

      selectedAttachment.value = File(file.path);
      var fileNameSplit = file.path.split("/");
      print(fileNameSplit.last);
      print("FILE NAME LAST PATH");
      selectedAttachmentPath.value = fileNameSplit.last;
    } else {
      print('No image selected.');
    }
  }

  void addAchievements() {
    WebServices.uploadImage(
      uri: EndPoints.ACHIEVEMENT_UPDATE,
      hasBearer: true,
      type: "trainerachievementfile",
      file: selectedAttachment.value,
      mediaTitle: inputController.text,
      thumbnailFile: thumbnail.value,
      onSuccess: (response) {
        hideAppLoader();
        GetTrainerProfileDetailModel getTrainerProfileDetailModel;
        getTrainerProfileDetailModel = getTrainerProfileDetailModelFromJson(response);
        var json = jsonDecode(response);
        if (getTrainerProfileDetailModel.status == 1) {
          printLog(json);
          Get.back(result: getTrainerProfileDetailModel.result?.user?.userAchievementFiles);
        }
      },
      onFailure: (error) {
        hideAppLoader();
      },
    );
  }

  void updateQualificationCertificate() {
    WebServices.uploadImage(
      uri: EndPoints.UPLOAD_FILE,
      hasBearer: true,
      type: widget.type == "certificate" ? "qulificationfile" : "trainerinsurance",
      file: selectedAttachment.value,
      mediaTitle: inputController.text,
      thumbnailFile: File(""),
      moduleId: AppStorage.userData.result!.user.id,
      onSuccess: (response) {
        hideAppLoader();
        UploadMediaModel mediaModel;
        mediaModel = uploadMediaModelFromJson(response);
        var json = jsonDecode(response);
        if (mediaModel.status == 1) {
          printLog(json);
          Get.back(result: mediaModel.result);
        }
      },
      onFailure: (error) {
        hideAppLoader();
      },
    );
  }
}
