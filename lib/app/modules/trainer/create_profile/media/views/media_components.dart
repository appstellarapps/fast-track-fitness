import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:fasttrackfitness/app/modules/trainer/create_profile/media/controllers/media_controller.dart';
import 'package:fasttrackfitness/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../../core/helper/custom_method.dart';
import '../../../../../core/helper/images_resources.dart';
import '../../../../../core/helper/text_style.dart';

mixin MediaComponents {
  var controller = Get.put(MediaController());

  willPop() async {
    await controller.refreshFunction();
    Get.back(result: controller.isRefresh.value);
  }

  tabView() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 14.0),
      child: Row(
        children: [
          tabItem(0, tabText: "Media"),
          tabItem(1, tabText: "Achievements"),
        ],
      ),
    );
  }

  tabItem(index, {tabText}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (controller.isSelectedTab.value != index) {
            controller.isSelectedTab.value = index;
            controller.userTrainerMedia.clear();
            controller.userTrainerMedia.refresh();

            controller.keyTitle.clear();
            controller.titleController.clear();

            if (controller.isSelectedTab.value == 0 && controller.mediaLength > 0) {
              controller.isLoading.value = true;
              controller.page = 1;
              controller.isFromDelete.value = false;
              controller.isAnyPendingUploadFile.value = false;
              apiLoader(asyncCall: () => controller.callGetTrainerMediaAchievementAPI("media"));
            } else if (controller.isSelectedTab.value == 1 && controller.achievementLength > 0) {
              controller.isLoading.value = true;
              controller.page = 1;
              controller.isFromDelete.value = false;
              controller.isAnyPendingUploadFile.value = false;
              apiLoader(
                  asyncCall: () => controller.callGetTrainerMediaAchievementAPI("achievement"));
            }
          }
        },
        child: Obx(
          () => Column(
            children: [
              Center(
                child: Text(
                  tabText,
                  style: CustomTextStyles.semiBold(
                    fontColor: controller.isSelectedTab.value == index ? themeBlack : themeBlack50,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: controller.isSelectedTab.value == index ? themeGreen : colorGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 2.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  body() {
    return Expanded(
      child: trainerMediaList(),
    );
  }

  trainerMediaList() {
    return Obx(() => controller.isLoading.value
        ? const SizedBox.shrink()
        : controller.isSelectedTab.value == 0 && controller.userTrainerMedia.isNotEmpty
            ? GridView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0, bottom: 16.0),
                itemCount: controller.userTrainerMedia.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  childAspectRatio: Get.height / Get.width * 0.35, /*childAspectRatio: 0.75*/
                ),
                itemBuilder: (BuildContext context, int index) {
                  return itemView(index, controller.userTrainerMedia);
                })
            : controller.isSelectedTab.value == 1 && controller.userAchievement.isNotEmpty
                ? GridView.builder(
                    controller: controller.scrollController,
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0, bottom: 16.0),
                    itemCount: controller.userAchievement.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 10,
                      childAspectRatio: Get.height / Get.width * 0.35, /*childAspectRatio: 0.75*/
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return itemView(index, controller.userAchievement);
                    })
                : noDataFound());
  }

  itemView(index, item) {
    return Obx(
      () => Stack(
        alignment: Alignment.topLeft,
        children: [
          InkWell(
            onTap: controller.isSelectable.value ? () {} : null,
            child: Container(
              height: 230,
              child: Stack(children: [
                GestureDetector(
                  onTap: () async {
                    if (item[index].mediaFileType == "Video") {
                      Get.toNamed(Routes.VIDEO_PLAYER, arguments: [
                        item[index].mediaFileUrl,
                        item[index].title,
                        item[index].createdDateFormat
                      ]);
                    } else {
                      await CustomMethod.showFullImages(item[index].mediaFileUrl);
                    }
                  },
                  child: IntrinsicHeight(
                    child: Card(
                      color: item[index].isSelected.value ? themeBlack : themeWhite,
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          color: item[index].isSelected.value ? themeBlack : themeWhite,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                item[index].id.isNotEmpty
                                    ? mediaNetworkImage(
                                        borderRadius: 10.0,
                                        networkImage: item[index].thumbnailFileUrl.isEmpty
                                            ? item[index].mediaFileUrl
                                            : item[index].thumbnailFileUrl,
                                        height: 120,
                                        width: Get.width,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.file(
                                            File(item[index].thumbnailFileUrl.isEmpty
                                                ? item[index].mediaFileUrl
                                                : item[index].thumbnailFileUrl),
                                            height: 120,
                                            width: Get.width,
                                            fit: BoxFit.cover)),
                                Positioned(
                                    child: item[index].mediaFileType == "Video"
                                        ? SvgPicture.asset(item[index].isSelected.value
                                            ? ImageResourceSvg.icPlayBlack
                                            : ImageResourceSvg.icPlay)
                                        : const SizedBox.shrink())
                              ],
                            ),
                            SizedBox(height: item[index].id.isNotEmpty ? 12.0 : 8.0),
                            item[index].id.isNotEmpty
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item[index].title,
                                        style: CustomTextStyles.semiBold(
                                          fontColor: item[index].isSelected.value
                                              ? themeWhite
                                              : themeBlack,
                                          fontSize: 16.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        item[index].createdDateFormat.toString(),
                                        style: CustomTextStyles.semiBold(
                                          fontSize: 14.0,
                                          fontColor:
                                              item[index].isSelected.value ? themeWhite : themeGrey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            item[index].id.isEmpty
                                ? CustomTextFormField(
                                    key: controller.keyTitle[index],
                                    hintText: 'Enter title here',
                                    controller: controller.titleController[index],
                                    borderColor: themeGrey,
                                    fontColor: themeBlack,
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                controller.isFromDelete.value
                    ? Positioned(
                        left: 0,
                        top: 7,
                        child: InkWell(
                            onTap: () {
                              item[index].isSelected.value =
                                  item[index].isSelected.value ? false : true;
                              controller.isAnySelectFile.value = false;
                              for (int i = 0; i < item.length; i++) {
                                if (item[i].isSelected.value) {
                                  controller.isAnySelectFile.value = true;
                                  break;
                                }
                              }
                            },
                            child: controller.isFromDelete.value
                                ? SvgPicture.asset(item[index].isSelected.value
                                    ? ImageResourceSvg.icCheck1
                                    : ImageResourceSvg.icUncheck1)
                                : const SizedBox.shrink()))
                    : const SizedBox.shrink(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
