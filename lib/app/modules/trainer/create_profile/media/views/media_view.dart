import 'package:fasttrackfitness/app/core/helper/app_storage.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/data/upload_media_model.dart';
import 'package:fasttrackfitness/app/modules/trainer/create_profile/media/views/media_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_button.dart';
import '../controllers/media_controller.dart';

class MediaView extends GetView<MediaController> with MediaComponents {
  MediaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPop(),
      child: Scaffold(
          backgroundColor: themeWhite,
          appBar: ScaffoldAppBar.appBar(
            backIcon: Obx(
              () => SvgPicture.asset(
                controller.isSelectable.value
                    ? ImageResourceSvg.planSelected
                    : ImageResourceSvg.backArrowIc,
                color: themeWhite,
              ),
            ),
            onBackPressed: () {
              willPop();
            },
            titleWidget: Text(
              controller.isSelectable.value
                  ? "${controller.selectedItemCount.value.toString()} Selected"
                  : "Gallery",
              style: CustomTextStyles.semiBold(
                fontSize: 20.0,
                fontColor: themeWhite,
              ),
            ),
            actions: [
              MenuIcon(
                visibleWidget: AppStorage.userData.result!.user.id == controller.userId
                    ? IconButton(
                        onPressed: () {
                          controller.isFromDelete.value = true;
                        },
                        icon: Obx(
                          () => controller.isSelectedTab.value == 0 &&
                                  controller.userTrainerMedia.isNotEmpty
                              ? SvgPicture.asset(
                                  ImageResourceSvg.deleteIc,
                                  color: themeWhite,
                                  height: 20,
                                  width: 20,
                                )
                              : controller.isSelectedTab.value == 1 &&
                                      controller.userAchievement.isNotEmpty
                                  ? SvgPicture.asset(
                                      ImageResourceSvg.deleteIc,
                                      color: themeWhite,
                                      height: 20,
                                      width: 20,
                                    )
                                  : const SizedBox.shrink(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              MenuIcon(
                visibleWidget: AppStorage.userData.result!.user.id == controller.userId
                    ? IconButton(
                        onPressed: () {
                          controller.isFromDelete.value = false;
                          imageUploadOptionSheet(
                              title1: "Upload Image",
                              title2: "Upload Video",
                              onPressTitle1: () {
                                if (Get.isBottomSheetOpen!) Get.back();
                                imageUploadOptionSheet(
                                    title1: "Camera",
                                    title2: "Gallery",
                                    onPressTitle1: () {
                                      controller.getImage(ImageSource.camera);
                                    },
                                    onPressTitle2: () {
                                      controller.getImage(ImageSource.gallery);
                                    });
                              },
                              onPressTitle2: () {
                                if (Get.isBottomSheetOpen!) Get.back();
                                imageUploadOptionSheet(
                                    title1: "Camera",
                                    title2: "Gallery",
                                    onPressTitle1: () {
                                      controller.pickVideo(ImageSource.camera);
                                    },
                                    onPressTitle2: () {
                                      controller.pickVideo(ImageSource.gallery);
                                    });
                              });
                        },
                        icon: SvgPicture.asset(
                          ImageResourceSvg.icPlus,
                          color: themeWhite,
                          height: 20,
                          width: 20,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          body: Column(
            children: [
              tabView(),
              body(),
              Obx(() => controller.isAnySelectFile.value
                  ? Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ButtonRegular(
                        onPress: () {
                          var fileIds = [];
                          if (controller.isSelectedTab.value == 0) {
                            for (int i = 0; i < controller.userTrainerMedia.length; i++) {
                              if (controller.userTrainerMedia[i].isSelected.value) {
                                fileIds.add(controller.userTrainerMedia[i].id);
                              }
                            }
                          } else {
                            for (int i = 0; i < controller.userAchievement.length; i++) {
                              if (controller.userAchievement[i].isSelected.value) {
                                fileIds.add(controller.userAchievement[i].id);
                              }
                            }
                          }

                          apiLoader(asyncCall: () => controller.callDeleteMediaAPI(fileIds));
                        },
                        buttonText: "DELETE",
                      ),
                    )
                  : const SizedBox.shrink()),
              Obx(() => controller.isAnyPendingUploadFile.value
                  ? Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ButtonRegular(
                        onPress: () {
                          var mediaList = [];
                          var isValid = true;
                          if (controller.isSelectedTab.value == 0) {
                            for (int i = 0; i < controller.userTrainerMedia.length; i++) {
                              if (controller.userTrainerMedia[i].id.isEmpty) {
                                if (controller.titleController[i].text.isNotEmpty) {
                                  mediaList.add(UploadMedia(
                                      id: "",
                                      fileUrl: controller.userTrainerMedia[i].mediaFileUrl,
                                      fileName: "",
                                      thumbnailFileUrl:
                                          controller.userTrainerMedia[i].thumbnailFileUrl,
                                      thumbnailFileName:
                                          controller.userTrainerMedia[i].thumbnailFileName,
                                      title: controller.titleController[i].text));
                                } else {
                                  isValid = false;
                                  showSnackBar(title: "Error", message: "Please enter title");
                                  break;
                                }
                              }
                            }
                          } else {
                            for (int i = 0; i < controller.userAchievement.length; i++) {
                              if (controller.userAchievement[i].id.isEmpty) {
                                if (controller.titleController[i].text.isNotEmpty) {
                                  mediaList.add(UploadMedia(
                                      id: "",
                                      fileUrl: controller.userAchievement[i].mediaFileUrl,
                                      fileName: "",
                                      thumbnailFileUrl:
                                          controller.userAchievement[i].thumbnailFileUrl,
                                      thumbnailFileName:
                                          controller.userAchievement[i].thumbnailFileName,
                                      title: controller.titleController[i].text));
                                } else {
                                  isValid = false;
                                  showSnackBar(title: "Error", message: "Please enter title");
                                  break;
                                }
                              }
                            }
                          }

                          if (isValid) {
                            for (int i = 0; i < mediaList.length; i++) {
                              apiLoader(
                                  asyncCall: () => controller.callUploadProfileFileAPI(
                                      mediaList[i],
                                      controller.isSelectedTab.value == 0
                                          ? "trainermediafile"
                                          : "trainerachievementfile"));
                            }
                          }
                        },
                        buttonText: "UPLOAD",
                      ),
                    )
                  : const SizedBox.shrink())
            ],
          )),
    );
  }
}
