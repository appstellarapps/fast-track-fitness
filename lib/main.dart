import 'dart:io';

import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/data/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/core/helper/app_storage.dart';
import 'app/core/helper/constants.dart';
import 'app/routes/app_pages.dart';

/// test
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppStorage.initializeApp();
  AppStorage.fcmToken = (await FirebaseMessaging.instance.getToken())!;

  if (AppStorage.isLogin()) {
    // printLog("this is Fcm Token ${AppStorage.fcmToken}");
    AppStorage.userData = userModelFromJson(AppStorage.getLoginProfileModel());
    FTFGlobal.firstName.value = AppStorage.userData.result!.user.firstName!.value;
    FTFGlobal.lastName.value = AppStorage.userData.result!.user.lastName!.value;
    FTFGlobal.userName.value = AppStorage.userData.result!.user.fullName!.value;
    FTFGlobal.mobileNo.value = AppStorage.userData.result!.user.phoneNumber!.value;
    FTFGlobal.email.value = AppStorage.userData.result!.user.email!.value;
    FTFGlobal.userProfilePic.value = AppStorage.userData.result!.user.profileImage;
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var initialRoute = Routes.WELCOME;
    if (AppStorage.isLogin()) {
      if (AppStorage.getUserType() == EndPoints.USER_TYPE_TRAINER) {
        if (AppStorage.userData.result!.user.isProfileVerified == 0) {
          initialRoute = Routes.CREATE_TRAINER_PROFILE;
        } else if (AppStorage.userData.result!.user.isSubscribed == 0) {
          initialRoute = Routes.SUBSCRIPTION;
        } else {
          initialRoute = Routes.TRAINER_DASHBOARD;
        }
      } else {
        initialRoute = Routes.TRAINEE_DASHBOARD;
      }
    }
    if (Platform.isAndroid) {
      // Android-specific code
    } else if (Platform.isIOS) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarColor: themeWhite, systemNavigationBarIconBrightness: Brightness.light));
    }

    return GetMaterialApp(
      title: "Fast Track Fitness",
      initialRoute: initialRoute,
      theme: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
