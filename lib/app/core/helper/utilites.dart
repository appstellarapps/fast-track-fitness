import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:intl/intl.dart';

class Utilities {
  static Future<bool> isConnectedNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Internet available");
        return true;
      } else {
        print("Internet not available");
        return false;
      }
    } on SocketException catch (_) {
      print("Something went wrong with connection");
      return false;
    }
  }

  static String dateFormate(date, {format = "dd-MMM-yyyy"}) {
    var splitDate = date.split('/');

    var convertedDate =
        DateTime(int.parse(splitDate[2]), int.parse(splitDate[1]), int.parse(splitDate[0]));

    DateFormat formatted = DateFormat(format);
    var formattedDate = formatted.format(convertedDate);
    print(formattedDate);
    print("FORMAT DATE");
    return formattedDate;
  }

  static String formatDate(String date) {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return formattedDate;
  }

  static String formatDateTwo(String date) {
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return formattedDate;
  }

  static String getDeviceType() {
    if (GetPlatform.isAndroid) {
      return "ANDROID";
    } else if (GetPlatform.isIOS) {
      return "IOS";
    } else if (GetPlatform.isWeb) {
      return "WEB";
    } else {
      return "";
    }
  }

  static String getTimeZone() {
    return "${DateTime.now().timeZoneOffset}";
  }

  static Future<String> getDeviceToken() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      return await deviceInfoPlugin.androidInfo.then((deviceInfo) => deviceInfo.toString());
    } else if (GetPlatform.isIOS) {
      return await deviceInfoPlugin.iosInfo.then((ss) => ss.identifierForVendor.toString());
    } else {
      return "";
    }
  }

  static String getRandomString({int length = 9}) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static int getRandomNumber({int max = 1000}) {
    var rng = Random();
    return rng.nextInt(max);
  }
}
