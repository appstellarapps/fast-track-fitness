import 'dart:io';

import 'package:fasttrackfitness/app/modules/trainee/workout_calendar/controllers/workout_calendar_controller.dart';
import 'package:fasttrackfitness/app/modules/trainer/schedule/controllers/schedule_controller.dart';
import 'package:fasttrackfitness/app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

var bookingId = '';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initPushNotify() async {
  print("push notification init --------------->");
  localNotificationsSetup();
  await FirebaseMessaging.instance.requestPermission(sound: true, badge: true, alert: true);
  if (Platform.isAndroid) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      print("message received home view");
      print('${event.notification!.title}');
      // await setDeviceInfoApi();
      showNotification(event);
    });
  }
  FirebaseMessaging.onBackgroundMessage((RemoteMessage event) async {
    print("message received bg ");
    // showNotification(event);
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  //----------------handling redirection when in app----------------//

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) async {
    print('A new onMessageOpenedApp event was published!');
    if (event.data['tagname'] == 'Appointment') {
      bookingId = event.data['appointmentId'];
    }
    onRedirection(event.data['tagname'], bookingId);
  });

  //----------------handling redirection when app killed----------------//
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? event) async {
    if (event != null) {
      if (event.data['tagname'] == 'Appointment') {
        bookingId = event.data['appointmentId'];
      }
      onRedirection(event.data['tagname'], bookingId);
    }
  });
}

//----------------show notification in device----------------//

showNotification(RemoteMessage event) async {
  var androidDetails = AndroidNotificationDetails(
    '${event.messageId}',
    'FastTrackFitness',
    channelShowBadge: true,
    priority: Priority.high,
    importance: Importance.max,
  );

  var iOSDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
  );
  print("this is iOS details------->$iOSDetails");
  var platformChannel = NotificationDetails(android: androidDetails, iOS: iOSDetails);
  print(event.notification!.title);
  await flutterLocalNotificationsPlugin.show(
      0, event.notification!.title, event.notification!.body, platformChannel,
      payload: '${event.data}');
}

//----------------local notification set up----------------//

localNotificationsSetup() async {
  var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true, requestSoundPermission: true, requestBadgePermission: true);
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onNotificationResponse);
}

//----------------when app background get notification----------------//

Future<void> onNotificationResponse(NotificationResponse details) async {
  String notificationPayload = details.payload!;
  List<String> str = notificationPayload.replaceAll("{", "").replaceAll("}", "").split(",");
  Map<String, dynamic> notificationResult = {};
  for (int i = 0; i < str.length; i++) {
    List<String> s = str[i].split(":");
    notificationResult.putIfAbsent(s[0].trim(), () => s[1].trim());
  }
  if (notificationResult['tagname'] == 'Appointment') {
    bookingId = notificationResult['appointmentId'];
  }
  onRedirection(notificationResult['tagname'], bookingId);
}

///--------------------------manage notification redirection flow----------------//
onRedirection(eventType, bookingId) {
  switch (eventType) {
    case "Exercise":
      Get.delete<WorkoutCalendarController>();
      Get.toNamed(Routes.WORKOUT_CALENDAR, arguments: [0, '']);
      break;
    case "Nutritional":
      Get.delete<WorkoutCalendarController>();
      Get.toNamed(Routes.WORKOUT_CALENDAR, arguments: [1, '']);
      break;
    case "Appointment":
      Get.delete<ScheduleController>();
      Get.toNamed(Routes.SCHEDULE, arguments: [bookingId, '3']);
      break;
  }
}
