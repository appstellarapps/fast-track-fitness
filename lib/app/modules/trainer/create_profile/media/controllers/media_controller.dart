import 'dart:convert';
import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:fasttrackfitness/app/data/get_my_trainer_profile_model.dart';
import 'package:fasttrackfitness/app/data/media_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../../core/helper/app_storage.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_textformfield.dart';
import '../../../../../core/helper/constants.dart';
import '../../../../../core/helper/helper.dart';
import '../../../../../core/helper/image_custom_cropper.dart';
import '../../../../../core/services/web_services.dart';
import '../../../../../data/upload_media_model.dart';
import '../../create_trainer_profile/controllers/create_trainer_profile_controller.dart';

class MediaController extends GetxController {
  ScrollController scrollController = ScrollController();

  var isSelectedTab = 0.obs;
  var isSelectable = false.obs;
  var selectedItemCount = 0.obs;
  var page = 1;
  var haseMore = false.obs;
  var isFromDelete = false.obs;
  var isAnySelectFile = false.obs;
  var isAnyPendingUploadFile = false.obs;
  var isRefresh = false.obs;
  var isLoading = true.obs;
  var isCallMedia = false;
  var isCallAchievement = false;

  var userTrainerMedia = <Media>[].obs;
  var userAchievement = <Media>[].obs;

  List<TextEditingController> titleController = [];
  List<GlobalKey<CustomTextFormFieldState>> keyTitle = [];

  var type = Get.arguments[0];
  var userId = Get.arguments[1];
  var mediaLength = Get.arguments[2];
  var achievementLength = Get.arguments[3];

  @override
  void onInit() {
    isSelectedTab.value = type == "media" ? 0 : 1;
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(scroll);

    printLog(">>MEDIA LENGTH>>>$mediaLength>>>>>");
    printLog(">>ACHIV LENGTH>>>$achievementLength>>>>>");

    if (isSelectedTab.value == 0 && mediaLength > 0) {
      apiLoader(asyncCall: () => callGetTrainerMediaAchievementAPI(type));
    } else if (isSelectedTab.value == 1 && achievementLength > 0) {
      apiLoader(asyncCall: () => callGetTrainerMediaAchievementAPI(type));
    } else {
      isLoading.value = false;
    }
    super.onInit();
  }

  scroll() {
    if (scrollController.position.maxScrollExtent - 500 == scrollController.position.pixels - 500) {
      if (haseMore.value) {
        page++;
        callGetTrainerMediaAchievementAPI(type);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void callGetTrainerMediaAchievementAPI(type) {
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINER_MEDIA_ACHIVEMENT,
      hasBearer: true,
      body: {"type": type, "trainerId": userId, "page": page},
      onStatusSuccess: (responseBody) {
        MediaModel mediaModel;
        mediaModel = mediaModelFromJson(responseBody);

        haseMore.value = mediaModel.result.hasMoreResults == 0 ? false : true;

        titleController.add(TextEditingController());
        keyTitle.add(GlobalKey<CustomTextFormFieldState>());

        if (isSelectedTab.value == 0) {
          isCallMedia = true;
          userTrainerMedia.clear();
          userTrainerMedia.addAll(mediaModel.result.data);
          userTrainerMedia.refresh();
          mediaLength = userTrainerMedia.length;
        } else {
          isCallAchievement = true;
          userAchievement.clear();
          userAchievement.addAll(mediaModel.result.data);
          userAchievement.refresh();
          achievementLength = userAchievement.length;
        }


        for (int i = 0; i < mediaModel.result.data.length; i++) {
          titleController.add(TextEditingController());
          keyTitle.add(GlobalKey<CustomTextFormFieldState>());
        }
        isLoading.value = false;
        hideAppLoader();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
        isLoading.value = false;
      },
    );
  }

  callDeleteMediaAPI(fileIds) {
    WebServices.postRequest(
      uri: EndPoints.COMMON_DELETE_FILE,
      hasBearer: true,
      body: {
        "type": isSelectedTab.value == 0 ? "trainermediafile" : "trainerachievementfile",
        "userId": AppStorage.userData.result!.user.id,
        "fileIds": fileIds
      },
      onStatusSuccess: (responseBody) {
        var json = jsonDecode(responseBody);
        if (json['status'] == 1) {
          if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
            var createController = Get.put(CreateTrainerProfileController());
            isAnySelectFile.value = false;
            isFromDelete.value = false;
            isRefresh.value = true;

            if (isSelectedTab.value == 0) {
              for (int i = 0; i < userTrainerMedia.length; i++) {
                for (int j = 0; j < fileIds.length; j++) {
                  if (userTrainerMedia[i].id == fileIds[j]) {
                    userTrainerMedia.removeAt(i);
                  }
                }
              }
              userTrainerMedia.refresh();
              createController.mediaLength = userTrainerMedia.length;
              mediaLength = userTrainerMedia.length;
            } else {
              for (int i = 0; i < userAchievement.length; i++) {
                for (int j = 0; j < fileIds.length; j++) {
                  if (userAchievement[i].id == fileIds[j]) {
                    userAchievement.removeAt(i);
                  }
                }
              }
              userAchievement.refresh();
              createController.achievementLength = userAchievement.length;
              achievementLength = userAchievement.length;
            }
          }
        }
        hideAppLoader();
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  Future getImage(ImageSource source) async {
    Helper().hideKeyBoard();
    if (Get.isBottomSheetOpen!) Get.back();

    File profileImage;
    final pickedFile = await CustomImageCropper().imagePicker(source);

    if (pickedFile != null && pickedFile.isNotEmpty) {
      profileImage = File(pickedFile);

      var data = Media(
          id: "",
          userId: "",
          title: "",
          mediaFile: profileImage.toString(),
          mediaFileUrl: profileImage.path,
          mediaFileType: "Image",
          timming: "",
          description: "",
          thumbnailFileName: "",
          thumbnailFileUrl: "",
          createdDateFormat: "");

      titleController.add(TextEditingController());
      keyTitle.add(GlobalKey<CustomTextFormFieldState>());

      isAnyPendingUploadFile.value = true;

      if (isSelectedTab.value == 0) {
        userTrainerMedia.add(data);
        userTrainerMedia.refresh();
      } else {
        userAchievement.add(data);
        userAchievement.refresh();
      }

      printLog("1....${profileImage.path}");
      printLog("1....${profileImage.uri}");
      printLog("1....$profileImage");
    }
  }

  Future pickVideo(ImageSource source) async {
    Helper().hideKeyBoard();
    if (Get.isBottomSheetOpen!) Get.back();
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickVideo(
      source: source,
      maxDuration: const Duration(minutes: 5),
    );

    var thumbnail;
    if (file != null) {
      thumbnail = await VideoCompress.getFileThumbnail(file.path,
          quality: 50, // default(100)
          position: -1 // default(-1)
          );

      var data = Media(
          id: "",
          userId: "",
          title: "",
          mediaFile: file.path.toString(),
          mediaFileUrl: file.path,
          mediaFileType: "Video",
          timming: "",
          description: "",
          thumbnailFileName: file.name,
          thumbnailFileUrl: thumbnail.path,
          createdDateFormat: "");

      titleController.add(TextEditingController());
      keyTitle.add(GlobalKey<CustomTextFormFieldState>());

      isAnyPendingUploadFile.value = true;
      if (isSelectedTab.value == 0) {
        userTrainerMedia.add(data);
        userTrainerMedia.refresh();
      } else {
        userAchievement.add(data);
        userAchievement.refresh();
      }

      printLog("1....${file.path}");
      printLog("1....${file.name}");
      printLog("1....$file");
      printLog("1....${thumbnail.path}");

      // selectedAttachment.value = File(file.path);
      var fileNameSplit = file.path.split("/");
      printLog(fileNameSplit.last);
      // selectedAttachmentPath.value = fileNameSplit.last;
    } else {
      printLog('No image selected.');
    }
  }

  callUploadProfileFileAPI(data, type) {
    Helper().hideKeyBoard();
    WebServices.uploadImage(
      uri: EndPoints.UPLOAD_FILE,
      hasBearer: true,
      type: type,
      file: File(data.fileUrl),
      moduleId: AppStorage.userData.result!.user.id,
      mediaTitle: data.title,
      thumbnailFile: File(data.thumbnailFileUrl),
      onSuccess: (response) {
        hideAppLoader();
        UploadMediaModel uploadMediaModel;
        uploadMediaModel = uploadMediaModelFromJson(response);

        if (uploadMediaModel.status == 1) {
          isAnyPendingUploadFile.value = false;
          isRefresh.value = true;
          apiLoader(
              asyncCall: () => callGetTrainerMediaAchievementAPI(
                  isSelectedTab.value == 0 ? "media" : "achievement"));

          keyTitle.removeAt(0);
          titleController.removeAt(0);
        }
      },
      onFailure: (error) {
        hideAppLoader();
      },
    );
  }

  refreshFunction() {
    if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
      var createController = Get.put(CreateTrainerProfileController());

      if (isCallMedia) {
        createController.userTrainerMedia.clear();
        createController.usertrainerMediaCount.value = userTrainerMedia.length;
        for (int i = 0; i < (userTrainerMedia.length > 5 ? 5 : userTrainerMedia.length); i++) {
          var userMedia = UsertrainerMedia(
              id: userTrainerMedia[i].id,
              userId: userTrainerMedia[i].userId,
              title: userTrainerMedia[i].title,
              mediaFile: userTrainerMedia[i].mediaFile,
              mediaFileUrl: userTrainerMedia[i].mediaFileUrl,
              mediaFileType: userTrainerMedia[i].mediaFileType,
              timming: userTrainerMedia[i].timming,
              description: userTrainerMedia[i].description,
              thumbnailFileName: userTrainerMedia[i].thumbnailFileName,
              thumbnailFileUrl: userTrainerMedia[i].thumbnailFileUrl,
              createdDateFormat: userTrainerMedia[i].createdDateFormat);

          createController.userTrainerMedia.add(userMedia);
        }

        createController.userTrainerMedia.add(UsertrainerMedia(
            id: "id",
            userId: "",
            title: "",
            mediaFile: "",
            mediaFileUrl: "",
            mediaFileType: "",
            timming: "",
            description: "",
            thumbnailFileName: "",
            thumbnailFileUrl: "",
            createdDateFormat: ""));
        createController.userTrainerMedia.refresh();

        createController.mediaLength = userTrainerMedia.length;
      }

      if (isCallAchievement) {
        createController.userAchievementFile.clear();
        createController.userAchievementFilesCount.value = userAchievement.length;
        for (int i = 0; i < (userAchievement.length > 5 ? 5 : userAchievement.length); i++) {
          var userAchieve = UserAchievementFile(
              id: userAchievement[i].id,
              userId: userAchievement[i].userId,
              title: userAchievement[i].title,
              achievementFile: userAchievement[i].mediaFile,
              achievementFileUrl: userAchievement[i].mediaFileUrl,
              achievementType: userAchievement[i].mediaFileType,
              timming: userAchievement[i].timming,
              thumbnailFileName: userAchievement[i].thumbnailFileName,
              thumbnailFileUrl: userAchievement[i].thumbnailFileUrl,
              createdDateFormat: userAchievement[i].createdDateFormat);

          createController.userAchievementFile.add(userAchieve);
        }

        createController.userAchievementFile.add(UserAchievementFile(
            id: "",
            userId: "",
            title: "",
            timming: "",
            achievementFile: "",
            achievementFileUrl: "",
            achievementType: "",
            thumbnailFileName: "",
            thumbnailFileUrl: "",
            createdDateFormat: ""));
        createController.userAchievementFile.refresh();

        createController.achievementLength = userAchievement.length;
      }
    }
  }
}
