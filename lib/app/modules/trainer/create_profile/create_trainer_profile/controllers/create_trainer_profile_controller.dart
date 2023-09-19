import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';
import 'package:fasttrackfitness/app/core/helper/custom_method.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:fasttrackfitness/app/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/helper/app_storage.dart';
import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../core/helper/common_widget/custom_button.dart';
import '../../../../../core/helper/constants.dart';
import '../../../../../core/helper/helper.dart';
import '../../../../../data/common/common_models.dart';
import '../../../../../data/common_drop_down_data.dart';
import '../../../../../data/get_my_trainer_profile_model.dart';
import '../../../../../data/training_mode_model.dart';
import '../../../../../data/training_type_model.dart';
import '../../../../../data/update_trainer_profile_model.dart';
import '../../../../../data/upload_media_model.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../trainee/my_booking_trainee/controllers/my_booking_trainee_controller.dart';

class CreateTrainerProfileController extends GetxController {
  Timer? timer;

  final focusFName = FocusNode(),
      focusLName = FocusNode(),
      focusMobile = FocusNode(),
      focusEmail = FocusNode(),
      focusAge = FocusNode(),
      focusExperience = FocusNode();

  TextEditingController fNameController = TextEditingController(),
      lNameController = TextEditingController(),
      mobileController = TextEditingController(),
      emailController = TextEditingController(),
      dobController = TextEditingController(),
      experienceController = TextEditingController(),
      locationController = TextEditingController();

  GlobalKey<CustomTextFormFieldState> keyFName = GlobalKey<CustomTextFormFieldState>(),
      keyLName = GlobalKey<CustomTextFormFieldState>(),
      keyMobile = GlobalKey<CustomTextFormFieldState>(),
      keyEmail = GlobalKey<CustomTextFormFieldState>(),
      keyAge = GlobalKey<CustomTextFormFieldState>(),
      keyExperience = GlobalKey<CustomTextFormFieldState>(),
      keyLocation = GlobalKey<CustomTextFormFieldState>();

  late UpdateTrainerProfileModel updateTrainerProfileModel;
  late GetTrainerProfileDetailModel getMyTrainerProfileModel;

  var morningWeekList = <WeekList>[];
  var eveningWeekList = <WeekList>[];
  var trainingTypeList = <EditTrainingTypeListModel>[].obs;
  var profilePic = "".obs;
  var profilePictureUrl = "".obs;
  var fullName = "".obs;
  var overAllRating = "".obs;
  var commonFieldSpace = 20.0;
  var trainingModes = <TrainingMode>[].obs;
  var achievementsList = <UserAchievementFile>[].obs;
  var userTrainerMedia = <UsertrainerMedia>[].obs;
  var userAchievementFile = <UserAchievementFile>[].obs;
  var userLat = "".obs;
  var userLng = "".obs;
  var updatedTrainerProfilePic = "".obs;
  var updateMedia = false.obs;
  var profileType = "Personal".obs;
  var selectedProfile = File("").obs;
  var userId = "".obs;
  var selectedGenderRadio = 1.obs;
  var usertrainerMediaCount = 0.obs;
  var userAchievementFilesCount = 0.obs;
  var kidFriendly = 1.obs;
  var trainerQualifications = <UserQualificationFile>[].obs;
  var trainerInsurance = <UserQualificationFile>[].obs;
  var totalRatings = "0.0".obs;
  var morningSTime = "".obs;
  var morningETime = "".obs;
  var eveningSTime = "".obs;
  var eveningETime = "".obs;
  var phoneCode = "+91".obs;
  var timerStart = 0.obs;
  var userModel = UserModel();
  var priceTypeOptionList = <DropdownMenuItem<String>>[].obs;
  var specialistList = <DropdownMenuItem<String>>[].obs;
  var mediaLength = 0;
  var achievementLength = 0;

  @override
  void onInit() {
    getPriceTypes();
    updateMedia.value = false;
    updatedTrainerProfilePic.value = "";
    getTrainingModes();
    getTrainingType();
    morningWeekList.add(WeekList(day: "M", value: "Mon"));
    morningWeekList.add(WeekList(day: "T", value: "Tue"));
    morningWeekList.add(WeekList(day: "W", value: "Wed"));
    morningWeekList.add(WeekList(day: "T", value: "Thu"));
    morningWeekList.add(WeekList(day: "F", value: "Fri"));
    morningWeekList.add(WeekList(day: "S", value: "Sat"));
    morningWeekList.add(WeekList(day: "S", value: "Sun"));

    eveningWeekList.add(WeekList(day: "M", value: "Mon"));
    eveningWeekList.add(WeekList(day: "T", value: "Tue"));
    eveningWeekList.add(WeekList(day: "W", value: "Wed"));
    eveningWeekList.add(WeekList(day: "T", value: "Thu"));
    eveningWeekList.add(WeekList(day: "F", value: "Fri"));
    eveningWeekList.add(WeekList(day: "S", value: "Sat"));
    eveningWeekList.add(WeekList(day: "S", value: "Sun"));

    if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
      apiLoader(asyncCall: () => getMyTrainerProfileAPI());
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  isPersonalDetailValid() {
    Get.closeAllSnackbars();
    var isValid = true;

    if (keyFName.currentState!.checkValidation()) isValid = false;
    if (keyLName.currentState!.checkValidation(false)) isValid = false;
    if (keyMobile.currentState!.checkValidation(false)) isValid = false;
    if (keyAge.currentState!.checkValidation(false)) isValid = false;
    if (keyExperience.currentState!.checkValidation(false)) isValid = false;
    if (keyLocation.currentState!.checkValidation(false)) isValid = false;

    var hasSelMWeek = false;
    var hasSelEWeek = false;

    for (var element in morningWeekList) {
      if (element.isSelected.value) {
        hasSelMWeek = true;
      }
    }
    for (var element in eveningWeekList) {
      if (element.isSelected.value) {
        hasSelEWeek = true;
      }
    }
    if (!hasSelMWeek && !hasSelEWeek) {
      showSnackBar(title: "Error", message: "Please select your availability");
      isValid = false;
    }
    return isValid;
  }

  isProfessionalDetailValid() {
    var isValid = true;
    var hasSelectedTrainingMode = false;
    print(trainingModes.length.toString());
    for (var element in trainingModes) {
      if (element.isSelected.value) {
        print(element.title);
        print(element.isSelected.value.toString());
        hasSelectedTrainingMode = true;
      }
    }

    if (!hasSelectedTrainingMode) {
      print("HSA");
      print(hasSelectedTrainingMode.toString());
      isValid = false;
      showSnackBar(title: "Error", message: "Please select your training Mode");
    }

    if (trainingTypeList.isNotEmpty) {
      var hasTrainingTypePriceEmpty = false;
      for (var element in trainingTypeList) {
        if (element.inputController!.text.isEmpty) {
          hasTrainingTypePriceEmpty = true;
        }
      }
      if (hasTrainingTypePriceEmpty) {
        isValid = false;
        showSnackBar(title: "Error", message: "Please add your training price");
      }
    }

    if (trainingTypeList.isNotEmpty) {
      var hasTrainingTypeEmpty = false;
      for (var element in trainingTypeList) {
        printLog(element.priceOption);
        if (element.priceOption == null ||
            element.priceOption.isEmpty ||
            element.priceOption == "type") {
          hasTrainingTypeEmpty = true;
        }
      }
      if (hasTrainingTypeEmpty) {
        isValid = false;
        showSnackBar(title: "Error", message: "Please select your training type");
      }
    }

    return isValid;
  }

  void callUploadProfileFileAPI(imageFile, type) {
    WebServices.uploadImage(
      uri: EndPoints.UPLOAD_FILE,
      hasBearer: true,
      type: type,
      file: imageFile,
      moduleId: userId.value,
      onSuccess: (response) {
        hideAppLoader();
        UploadMediaModel uploadMediaModel;
        uploadMediaModel = uploadMediaModelFromJson(response);

        if (uploadMediaModel.status == 1) {
          if (type == "trainerprofilepic") {
            profilePic.value = uploadMediaModel.result.fileUrl;
            updatedTrainerProfilePic.value = uploadMediaModel.result.fileUrl;
            profilePictureUrl.value = uploadMediaModel.result.fileUrl;
          } else if (type == "trainermediafile") {
            var model = UsertrainerMedia(
                id: uploadMediaModel.result.id,
                userId: AppStorage.userData.result!.user.id,
                title: uploadMediaModel.result.title,
                mediaFile: uploadMediaModel.result.fileUrl,
                mediaFileUrl: uploadMediaModel.result.fileUrl,
                mediaFileType: "",
                timming: "",
                description: "",
                thumbnailFileName: uploadMediaModel.result.thumbnailFileName,
                thumbnailFileUrl: uploadMediaModel.result.thumbnailFileUrl,
                createdDateFormat: "");
            userTrainerMedia.add(model);
            userTrainerMedia.refresh();
          } else if (type == "trainerachievementfile") {
            var model = UserAchievementFile(
                id: uploadMediaModel.result.id,
                userId: AppStorage.userData.result!.user.id,
                title: uploadMediaModel.result.title,
                timming: "",
                achievementFile: uploadMediaModel.result.fileUrl,
                achievementFileUrl: uploadMediaModel.result.fileUrl,
                achievementType: "",
                thumbnailFileName: uploadMediaModel.result.thumbnailFileName,
                thumbnailFileUrl: uploadMediaModel.result.thumbnailFileUrl,
                createdDateFormat: "");
            userAchievementFile.add(model);
            userAchievementFile.refresh();
          }
        }
      },
      onFailure: (error) {
        hideAppLoader();
      },
    );
  }

  void getTrainingModes() {
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINING_MODE,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        TrainingModeModel getTrainingModeModel;
        getTrainingModeModel = trainingModeModelFromJson(responseBody);
        if (getTrainingModeModel.status == 1) {
          trainingModes.value = getTrainingModeModel.result;
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void deleteQualificationCer(type, fileIds, {selIndex}) {
    var body = {
      "type": type,
      "userId": AppStorage.userData.result!.user.id,
      "fileIds": fileIds,
    };
    WebServices.postRequest(
      body: body,
      uri: EndPoints.COMMON_DELETE_FILE,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        var data = jsonDecode(responseBody);
        if (data['status'] == 1) {
          if (type == "qulificationfile") {
            trainerQualifications.removeAt(selIndex);
            trainerQualifications.refresh();
          } else if (type == "trainerinsurance") {
            trainerInsurance.removeAt(selIndex);
            trainerInsurance.refresh();
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void getMyTrainerProfileAPI() {
    WebServices.postRequest(
      uri: EndPoints.GET_MY_TRAINER_PROFILE,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        getMyTrainerProfileModel = getTrainerProfileDetailModelFromJson(responseBody);
        if (getMyTrainerProfileModel.status == 1) {
          var getMyTrainerUserDetail = getMyTrainerProfileModel.result!.user;
          userId.value = getMyTrainerUserDetail.id;
          profilePic.value = getMyTrainerUserDetail.profileImage;
          fNameController.text = getMyTrainerUserDetail.firstName;
          lNameController.text = getMyTrainerUserDetail.lastName;
          phoneCode.value = getMyTrainerUserDetail.countryCode.toString();
          mobileController.text = getMyTrainerUserDetail.phoneNumber.toString();
          emailController.text = getMyTrainerUserDetail.email;
          selectedGenderRadio.value = getMyTrainerUserDetail.gender == "Male" ? 1 : 2;
          usertrainerMediaCount.value = getMyTrainerProfileModel.result!.user.usertrainerMediaCount;
          userAchievementFilesCount.value =
              getMyTrainerProfileModel.result!.user.userAchievementFilesCount;

          printLog(getMyTrainerUserDetail.dateOfBirth);

          if (getMyTrainerUserDetail.dateOfBirth.isNotEmpty) {
            dobController.text = CustomMethod.convertDateFormat(
                getMyTrainerUserDetail.dateOfBirth.toString(), "yyyy-MM-dd", "dd-MM-yyyy");
          }

          if (getMyTrainerUserDetail.firstName.isNotEmpty) {
            experienceController.text = getMyTrainerUserDetail.expInYear.toString();
          }
          trainerQualifications.value = getMyTrainerUserDetail.userQualificationFiles;
          trainerInsurance.value = getMyTrainerUserDetail.userInsuranceFiles;
          locationController.text = getMyTrainerUserDetail.address;
          userLat.value = getMyTrainerUserDetail.latitude.toString();
          userLng.value = getMyTrainerUserDetail.longitude.toString();
          overAllRating.value = getMyTrainerUserDetail.reviewAverage == ""
              ? "0.0"
              : getMyTrainerUserDetail.reviewAverage.toStringAsFixed(1);
          morningSTime.value = getMyTrainerUserDetail.userShiftTimming.morningStartTime.toString();
          morningETime.value = getMyTrainerUserDetail.userShiftTimming.morningEndTime.toString();
          eveningSTime.value = getMyTrainerUserDetail.userShiftTimming.eveningStartTime.toString();
          eveningETime.value = getMyTrainerUserDetail.userShiftTimming.eveningEndTime.toString();
          kidFriendly.value = getMyTrainerUserDetail.kidFriendly;
          if (getMyTrainerUserDetail.userShiftTimming.morningWeek.isNotEmpty) {
            for (var element in morningWeekList) {
              if (getMyTrainerUserDetail.userShiftTimming.morningWeek.contains(element.value)) {
                element.isSelected.value = true;
              }
            }
          }

          if (getMyTrainerUserDetail.userShiftTimming.eveningWeek.isNotEmpty) {
            for (var element in eveningWeekList) {
              if (getMyTrainerUserDetail.userShiftTimming.eveningWeek.contains(element.value)) {
                element.isSelected.value = true;
              }
            }
          }

          if (trainingModes.isNotEmpty) {
            for (var modes in trainingModes) {
              for (var element in getMyTrainerUserDetail.userTrainingModes) {
                if (element.trainingMode.id == modes.id) {
                  modes.isSelected.value = true;
                }
              }
            }
          }
          if (getMyTrainerUserDetail.userTrainingTypes.isNotEmpty) {
            trainingTypeList.clear();
            for (var element in getMyTrainerUserDetail.userTrainingTypes) {
              trainingTypeList.add(EditTrainingTypeListModel(
                  id: element.trainingType.id,
                  title: element.trainingType.title,
                  price: element.price.toString(),
                  priceOption: element.priceOption,
                  inputController: TextEditingController(text: element.price.toString())));
            }
          }

          mediaLength = getMyTrainerUserDetail.usertrainerMedia.length;
          achievementLength = getMyTrainerUserDetail.userAchievementFiles.length;

          printLog(">>MEDIA LENGTH>>>${getMyTrainerUserDetail.usertrainerMedia.length}>>>>>");
          printLog(">>ACHIV LENGTH>>>${getMyTrainerUserDetail.userAchievementFiles.length}>>>>>");
          printLog(">>MEDIA LENGTH>>>$mediaLength>>>>>");
          printLog(">>ACHIV LENGTH>>>$achievementLength>>>>>");

          //
          if (getMyTrainerUserDetail.userAchievementFiles.isNotEmpty) {
            for (var element in getMyTrainerUserDetail.userAchievementFiles) {
              achievementsList.add(UserAchievementFile(
                  title: element.title,
                  id: element.id,
                  userId: element.userId,
                  achievementFile: element.achievementFile,
                  achievementFileUrl: element.achievementFileUrl,
                  achievementType: element.achievementType,
                  thumbnailFileName: element.thumbnailFileName,
                  thumbnailFileUrl: element.thumbnailFileUrl,
                  timming: element.timming,
                  createdDateFormat: element.createdDateFormat));
            }
          }

          userTrainerMedia.value = [];
          userTrainerMedia.value = getMyTrainerUserDetail.usertrainerMedia;
          userTrainerMedia.add(UsertrainerMedia(
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
          userTrainerMedia.refresh();

          userAchievementFile.value = [];
          userAchievementFile.value = getMyTrainerUserDetail.userAchievementFiles;
          userAchievementFile.add(UserAchievementFile(
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
          userAchievementFile.refresh();

          hideAppLoader();
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void getPriceTypes() {
    WebServices.postRequest(
      uri: EndPoints.GET_STATIC_DROP_DOWN,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        GetStaticDdData staticDropDownDataModel;
        staticDropDownDataModel = getStaticDdDataFromJson(responseBody);
        // if (LogicalComponents.staticDropDownDataModel.status == 1) {
        var priceTypes = staticDropDownDataModel.result.data.trainingPaymentDropdown;
        for (var element in priceTypes) {
          priceTypeOptionList.add(commonDropDownItem(element, value: element));
        }
        printLog(priceTypeOptionList.length);
        printLog("LENGTH OF PRICE TYPE OPTION");
        // }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void getTrainingType() {
    WebServices.postRequest(
      uri: EndPoints.GET_TRAINING_TYPE,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        TrainingTypeModel getTrainingTypeModel;
        getTrainingTypeModel = trainingTypeModelFromJson(responseBody);
        if (getTrainingTypeModel.status == 1) {
          var trainingTypes = getTrainingTypeModel.result;
          for (var element in trainingTypes) {
            specialistList.add(commonDropDownItem(element.title, value: element.id));
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void editTrainingProfileAPI() {
    var morningSelectedWeeks = [];
    var eveningSelectedWeeks = [];
    var selectedTrainingTypes = [];
    var selectedTrainingModes = [];
    for (var element in morningWeekList) {
      if (element.isSelected.value) {
        morningSelectedWeeks.add(element.value);
      }
    }
    for (var element in eveningWeekList) {
      if (element.isSelected.value) {
        eveningSelectedWeeks.add(element.value);
      }
    }
    if (trainingTypeList.isNotEmpty) {
      for (var val in trainingTypeList) {
        selectedTrainingTypes.add({
          'id': val.id,
          'price': val.inputController!.text.isNotEmpty
              ? double.parse(val.inputController!.text.toString())
              : "",
          'priceOption': val.priceOption
        });
      }
    }
    hideAppLoader();
    for (var element in trainingModes) {
      if (element.isSelected.value) {
        selectedTrainingModes.add(element.id);
      }
    }

    var body = {
      "firstName": fNameController.text,
      "lastName": lNameController.text,
      "email": emailController.text,
      "gender": selectedGenderRadio.value == 1 ? "male" : "female",
      "dateOfBirth": CustomMethod.convertDateFormat(
          dobController.text, "dd-MM-yyyy", "yyyy-MM-dd"), // dobController.text,
      "expInYear": experienceController.text,
      "address": locationController.text,
      "latitude": userLat.value,
      "longitude": userLng.value,
      "morningStartTime": morningSTime.value,
      "morningEndTime": morningETime.value,
      "morningWeek": morningSelectedWeeks,
      "eveningStartTime": eveningSTime.value,
      "eveningEndTime": eveningETime.value,
      "eveningWeek": eveningSelectedWeeks,
      "trainingTypes": selectedTrainingTypes,
      "trainingModesId": selectedTrainingModes,
      "isKidFriendly": kidFriendly.value,
    };
    hideAppLoader();
    WebServices.postRequest(
      uri: EndPoints.UPDATE_TRAINER_PROFILE,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        updateTrainerProfileModel = updateTrainerProfileModelFromJson(responseBody);
        if (updateTrainerProfileModel.status == 1) {
          if (updateTrainerProfileModel.result!.user!.phoneNumber.toString() ==
              mobileController.text) {
            fullName.value = updateTrainerProfileModel.result!.user!.fullName;
            profilePictureUrl.value = updateTrainerProfileModel.result!.user!.profileImage;

            FTFGlobal.firstName.value = updateTrainerProfileModel.result!.user!.firstName;
            FTFGlobal.lastName.value = updateTrainerProfileModel.result!.user!.lastName;
            FTFGlobal.userName.value = updateTrainerProfileModel.result!.user!.fullName;
            FTFGlobal.mobileNo.value =
                updateTrainerProfileModel.result!.user!.phoneNumber.toString();
            FTFGlobal.email.value = updateTrainerProfileModel.result!.user!.email;
            FTFGlobal.userProfilePic.value = updateTrainerProfileModel.result!.user!.profileImage;

            AppStorage.setUserName(updateTrainerProfileModel.result!.user!.fullName);
            AppStorage.setUserProfilePic(updateTrainerProfileModel.result!.user!.profileImage);
            // Get.back(result: updateTrainerProfileModel.result!.user);

            if (AppStorage.userData.result!.user.isSubscribed == 0 &&
                AppStorage.userData.result!.user.isFreeTrail == 0) {
              Get.toNamed(Routes.SUBSCRIPTION);
            } else {
              Get.offAllNamed(Routes.TRAINER_DASHBOARD);
            }
          } else {
            apiLoader(asyncCall: () => updateMobileNumberAPI());
          }
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void updateMobileNumberAPI() {
    var body = {
      "countryCode": phoneCode.value,
      "phoneNumber": mobileController.text,
    };
    WebServices.postRequest(
      uri: EndPoints.UPDATE_MOBILE_NUMBER,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();

        var data = jsonDecode(responseBody);
        if (data['status'] == 1) {
          timerStart.value = 120;
          startTimer();
          verifyNumberSheet();
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  void resendVerificationCode() {
    var body = {
      "countryCode": phoneCode.value,
      "phoneNumber": mobileController.text,
    };
    WebServices.postRequest(
      uri: EndPoints.UPDATE_MOBILE_NUMBER,
      body: body,
      hasBearer: true,
      onStatusSuccess: (responseBody) {
        hideAppLoader();

        var data = jsonDecode(responseBody);
        if (data['status'] == 1) {
          timerStart.value = 120;
          startTimer();
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  verifyNumberSheet() {
    TextEditingController otpController = TextEditingController();
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
            color: themeWhite,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 16.0),
              child: Text(
                "Enter OTP",
                style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
              ),
            ),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'We have sent OTP on\n',
                    style: CustomTextStyles.semiBold(
                      fontColor: themeBlack,
                      fontSize: 16.0,
                    ),
                  ),
                  WidgetSpan(
                    child: Text(
                      "${phoneCode.value} ${mobileController.text}",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        profileType.value = "Personal";
                        focusMobile.requestFocus();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                        child: Text(
                          ' (Edit)',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.semiBold(
                            fontColor: themeGreen,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0, top: 16.0),
              child: Pinput(
                controller: otpController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme,
                submittedPinTheme: defaultPinTheme,
                showCursor: false,
                onCompleted: (pin) => printLog(pin),
              ),

              /*PinCodeTextField(
                controller: otpController,
                selectedFillColor: themeBlack,
                activeColor: themeBlack,
                activeFillColor: themeBlack,
                inactiveColor: Colors.transparent,
                selectedColor: Colors.transparent,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                fieldWidth: 40,
                fieldHeight: 40,
                obsecureText: false,
                textStyle: CustomTextStyles.bold(fontSize: 16.0, fontColor: themeWhite),
                textInputType: TextInputType.number,
                onCompleted: ((val) {}),
                length: 6,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(40.0),
                onChanged: (String value) {},
              ),*/
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(
              () => InkWell(
                onTap: timerStart.value != 0
                    ? null
                    : () {
                        apiLoader(asyncCall: () => resendVerificationCode());
                        // apiLoader(asyncCall: () => updateMobileNumber());
                      },
                child: formatHHMMSS(timerStart.value).isEmpty
                    ? Text(
                        "Resend Code",
                        style: CustomTextStyles.semiBold(
                          fontSize: 17.0,
                          fontColor: themeGreen,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Request a new code in",
                            style: CustomTextStyles.semiBold(
                              fontSize: 17.0,
                              fontColor: themeBlack,
                            ),
                          ),
                          Text(
                            " (${formatHHMMSS(timerStart.value)})",
                            style: CustomTextStyles.semiBold(
                              fontSize: 17.0,
                              fontColor: themeGreen,
                            ),
                          )
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 20.0, top: 20.0),
              child: ButtonRegular(
                buttonText: "Submit",
                onPress: () {
                  if (otpController.text.isEmpty) {
                    showSnackBar(title: "Error", message: "Please enter OTP");
                  } else if (otpController.text.length != 6) {
                    showSnackBar(title: "Error", message: "Please enter valid OTP");
                  } else {
                    apiLoader(asyncCall: () => verifyOtpAPI(otpController.text));
                  }
                },
              ),
            )
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: true,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  void verifyOtpAPI(otp) {
    Helper().hideKeyBoard();
    var body = {
      "otp": otp,
      "countryCode": phoneCode.value,
      "phoneNumber": updateTrainerProfileModel.result!.user!.phoneNumber,
      "type": "Update",
      "newPhoneNumber": mobileController.text,
    };
    WebServices.postRequest(
      uri: EndPoints.VERIFY_OTP,
      body: body,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        UserModel verifyOtpModel;
        verifyOtpModel = userModelFromJson(responseBody);
        if (verifyOtpModel.status == 1) {
          AppStorage.setAccessToken(verifyOtpModel.result!.accessToken);

          AppStorage.setLoginProfileModel(verifyOtpModel);

          if (verifyOtpModel.result!.user.fullName != null) {
            AppStorage.setUserName(verifyOtpModel.result!.user.fullName.toString());
          }

          FTFGlobal.firstName.value = verifyOtpModel.result!.user.firstName!.value;
          FTFGlobal.lastName.value = verifyOtpModel.result!.user.lastName!.value;
          FTFGlobal.userName.value = verifyOtpModel.result!.user.fullName!.value;
          FTFGlobal.mobileNo.value = verifyOtpModel.result!.user.phoneNumber!.value;
          FTFGlobal.email.value = verifyOtpModel.result!.user.email!.value;
          FTFGlobal.userProfilePic.value = verifyOtpModel.result!.user.profileImage;

          AppStorage.setUserProfilePic(verifyOtpModel.result!.user.profileImage);
          mobileController.text = verifyOtpModel.result!.user.phoneNumber.toString();
          if (Get.isBottomSheetOpen!) {
            Get.back();
          }
          // Get.back(result: verifyOtpModel.result!.user);
          Get.offAllNamed(Routes.TRAINER_DASHBOARD);
        }
      },
      onFailure: (error) {
        hideAppLoader(hideSnacks: false);
      },
    );
  }

  DropdownMenuItem<String> commonDropDownItem(dropDownText, {value}) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        dropDownText,
        style: CustomTextStyles.normal(
          fontSize: 16.0,
          fontColor: themeBlack,
        ),
      ),
    );
  }

  var listDropDownBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.0),
    borderSide: BorderSide.none,
  );

  String formatHHMMSS(int seconds) {
    if (seconds > 0) {
      int minutes = (seconds / 60).truncate();
      int second = seconds - (minutes * 60);
      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (second).toString().padLeft(2, '0');
      return "$minutesStr:$secondsStr";
    } else {
      return "";
    }
  }

  void startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerStart.value < 1) {
          timer.cancel();
        } else {
          timerStart.value = timerStart.value - 1;
        }
      },
    );
  }

  selectStartTime(isFromMorning) async {
    Helper().hideKeyBoard();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay
          .now() /*isFromMorning ? convertTimeStringToTimeOfDay(morningSTime.value) : convertTimeStringToTimeOfDay(eveningSTime.value)*/,
    );

    if (pickedTime != null && pickedTime != morningSTime.value) {
      if (isFromMorning) {
        if (pickedTime.period == DayPeriod.am) {
          if (getCompareTime(
                  pickedTime,
                  morningETime.isNotEmpty
                      ? convertTimeStringToTimeOfDay("${morningETime.value} AM")
                      : convertTimeStringToTimeOfDay(
                          "${convertTimeOfDayToTimeString(pickedTime)} AM")) ||
              morningETime.value.isEmpty) {
            morningSTime.value = convertTimeOfDayToTimeString(pickedTime);
            // isMorningSelected.value = true;
            // morningStartTimeSelected.value = true;
          } else {
            showSnackBar(title: "Alert", message: "start time should be less than end time");
          }
        } else {
          showSnackBar(title: "Alert", message: "Please select AM time");
        }
      } else {
        if (pickedTime.period == DayPeriod.pm) {
          if (getCompareTime(
                  pickedTime,
                  eveningETime.isNotEmpty
                      ? convertTimeStringToTimeOfDay("${eveningETime.value} PM")
                      : convertTimeStringToTimeOfDay(
                          "${convertTimeOfDayToTimeString(pickedTime)} PM")) ||
              eveningETime.value.isEmpty) {
            eveningSTime.value = convertTimeOfDayToTimeString(pickedTime);
            // isEveningSelected.value = true;
            // eveningStartTimeSelected.value = true;
          } else {
            showSnackBar(title: "Alert", message: "start time should be less than end time");
          }
        } else {
          showSnackBar(title: "Alert", message: "Please select PM time");
        }
      }
    }
  }

  getCompareTime(startTime, endTime) {
    bool result = false;
    int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
    int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;

    if (endTimeInt > startTimeInt) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  selectEndTime(isFromMorning) async {
    Helper().hideKeyBoard();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode
          .dial, /*isFromMorning ? convertTimeStringToTimeOfDay(morningETime.value) : convertTimeStringToTimeOfDay(eveningETime.value)*/
    );
    if (pickedTime != null && pickedTime != morningETime.value) {
      if (isFromMorning) {
        if (pickedTime.period == DayPeriod.am) {
          if (getCompareTime(
                  convertTimeStringToTimeOfDay("${morningSTime.value} AM"), pickedTime) ||
              morningSTime.value.isEmpty) {
            morningETime.value = convertTimeOfDayToTimeString(pickedTime);
            // isMorningSelected.value = true;
            // morningStartTimeSelected.value = true;
          } else {
            showSnackBar(title: "Alert", message: "End time should be greater than start time");
          }
        } else {
          showSnackBar(title: "Alert", message: "Please select AM time");
        }
      } else {
        if (pickedTime.period == DayPeriod.pm) {
          if (getCompareTime(
                  convertTimeStringToTimeOfDay("${eveningSTime.value} PM"), pickedTime) ||
              eveningSTime.value.isEmpty) {
            eveningETime.value = convertTimeOfDayToTimeString(pickedTime);
            // isEveningSelected.value = true;
            // eveningStartTimeSelected.value = true;
          } else {
            showSnackBar(title: "Alert", message: "End time should be greater than start time");
          }
        } else {
          showSnackBar(title: "Alert", message: "Please select PM time");
        }
      }
    }
  }

  convertTimeOfDayToTimeString(TimeOfDay timeOfDay) {
    final DateTime now = DateTime.now();
    final DateTime dateTime =
        DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    final DateFormat format = DateFormat.jm();
    var time = format.format(dateTime).replaceAll("AM", "").replaceAll("PM", "").trim();
    return time.length == 4 ? "0$time" : time;
  }

  TimeOfDay convertTimeStringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(' ');
    String timePart = parts[0];
    String amPm = parts[1];

    List<String> timeParts = timePart.split(':');

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (amPm == 'PM' && hour != 12) {
      hour += 12;
    } else if (amPm == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  static PinTheme defaultPinTheme = PinTheme(
    width: 45,
    height: 45,
    margin: const EdgeInsets.all(3.0),
    textStyle: const TextStyle(fontSize: 20, color: themeWhite, fontWeight: FontWeight.bold),
    decoration: BoxDecoration(
      color: themeBlack,
      border: Border.all(color: themeBlack),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
