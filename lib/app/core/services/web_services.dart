import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../routes/app_pages.dart';
import '../helper/app_storage.dart';
import '../helper/colors.dart';
import '../helper/common_widget/custom_app_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/logger.dart';
import '../helper/utilites.dart';

// import 'package:wright_touch/views/NoInternetView.dart';
class WebServices {
  WebServices();

  // Post Request
  static postRequest(
      {@required uri,
      baseUrl, // require for login, and other API url get from Login Response
      body,
      header,
      BuildContext? context,
      jsonEncoded = true,
      bool hasBearer = true,
      bool hideLoaderOnSuccess = false,
      bool hideLoaderOnFail = true,
      bool hideKeyBoardOnRes = true,
      Function(dynamic responseBody)? onSuccess,
      required Function(dynamic res)? onStatusSuccess,
      required Function(dynamic error) onFailure,
      Function? onTimeout,
      Function? onConnectionFailed}) async {
    bool isConnected = await Utilities.isConnectedNetwork();
    if (!isConnected) {
      hideAppLoader();
      return;
    }

    if (hasBearer) {
      header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppStorage.getAccessToken()}',
        "Accept": "application/json"
      };
      Log.longConsole(data: AppStorage.getAccessToken(), key: 'Bearer');
    } else {
      header = {'Content-Type': 'application/json', "Accept": "application/json"};
    }

    if (jsonEncoded) {
      body = jsonEncode(body);
    }

    baseUrl ??= EndPoints.BASE_URL;
    var url = baseUrl + uri;

    //make sure body should not have integer values, below body accept only String values.
    //make sure here body only accept Map type data till you not set 'Content-Type': 'application/json',
    http.post(Uri.parse(url), body: body, headers: header).then((response) {
      Log.displayResponse(payload: body, res: response, requestType: 'POST');
      var json = jsonDecode(response.body);
      if (json['status'] == -1 || response.statusCode == 401) {
        AppStorage.setAppLogin(false);
        FTFGlobal.firstName.value = '';
        FTFGlobal.lastName.value = '';
        FTFGlobal.mobileNo.value = '';
        FTFGlobal.email.value = '';
        FTFGlobal.userProfilePic.value = '';
        FTFGlobal.userName.value = '';

        AppStorage.box.erase();
        Get.offAllNamed(Routes.LOGIN);
      } else {
        if (onSuccess != null) onSuccess(response.body);
        // ignore: unnecessary_null_comparison
        if (response.body != null) {
          if (json['status'] != null && json['status'] == 1) {
            if (onStatusSuccess != null) {
              if (hideLoaderOnSuccess) {
                hideAppLoader();
              }
              if (hideKeyBoardOnRes) {
                Helper().hideKeyBoard();
              }
              onStatusSuccess(response.body);
            }
          } else {
            print('Something went wrong');
            onFailure(json['message']);
            if (hideLoaderOnFail) hideAppLoader();
            if (hideKeyBoardOnRes) {
              Helper().hideKeyBoard();
            }

            WebServices.getSnackToast(
                title: 'Error',
                message: json['message'],
                colorText: Colors.white,
                backgroundColor: errorColor);
          }
        }
      }
    }).catchError((error) {
      print(url);
      print('Error : catchError $error');
      print(url);
      hideAppLoader();
      WebServices.getSnackToast(
          message: error.toString(), colorText: Colors.white, backgroundColor: errorColor);

      onFailure(error);
    }).timeout(Duration(seconds: FTFGlobal.REQUEST_MAX_TIMEOUT), onTimeout: () {
      print(url);
      print('Error : TimeOut');
      hideAppLoader();
      if (onTimeout != null) onTimeout();
    });
  }

  static uploadImage({
    @required uri,
    required File file,
    File? thumbnailFile,
    type = 'photoid', //profile,photoid'
    String videoDuration = "0",
    String imageType = "I",
    var moduleId = "",
    header,
    bool hasBearer = false,
    required Function onSuccess,
    required Function onFailure,
    Function? onTimeout,
    Function? onConnectionFailed,
    String? mediaTitle = "",
  }) async {
    bool isConnected = await Utilities.isConnectedNetwork();
    if (!isConnected) {
      if (onConnectionFailed != null) {
        onConnectionFailed("Check your internet connection and try again");
      }
      hideAppLoader();
      getSnackToast(
        title: 'Connection Error',
        message: "Check your internet connection and try again",
      );
      //Get.to(NoInternetView());
      return;
    }

    if (hasBearer) {
      header = {
        'Authorization': 'Bearer ${AppStorage.getAccessToken()}',
      };
    }

    var url = EndPoints.BASE_URL + uri;
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // var url = EndPoints.baseUrl + uri;
    // var request = http.MultipartRequest('POST', Uri.parse(url));
    if (hasBearer) request.headers.addAll(header);
    request.fields.addAll({
      'type': type,
      'moduleId': moduleId,
      'title': mediaTitle ?? ""
      // 'videoDuration': videoDuration,
      // 'imageType': imageType
    });

    // ignore: unnecessary_null_comparison
    if (file.isAbsolute) {
      var stream = http.ByteStream(Stream.castFrom(file.openRead()));
      var length = await file.length();
      var multipartFile = http.MultipartFile('file', stream, length, filename: basename(file.path));
      request.files.add(multipartFile);
    }

    if (thumbnailFile != null && thumbnailFile.isAbsolute) {
      var stream = http.ByteStream(Stream.castFrom(thumbnailFile.openRead()));
      var length = await thumbnailFile.length();
      var multipartFile = http.MultipartFile('thumbnailFile', stream, length,
          filename: basename(thumbnailFile.path));
      request.files.add(multipartFile);
    }
    print(request.toString());
    await request.send().then((resStream) {
      resStream.stream.transform(utf8.decoder).transform(const LineSplitter()).listen((response) {
        print(response);
        final responseBody = jsonDecode(response);
        // print(responseBody);
        Log.displayResponse(payload: request.fields, res: responseBody, requestType: 'POST');
        onSuccess(response);
      });
    }).catchError((error) {
      print('Error : catchError $error');
      print(url);
      WebServices.getSnackToast(
          message: error.toString(), colorText: Colors.white, backgroundColor: Colors.red);

      onFailure(error);
    }).timeout(Duration(seconds: FTFGlobal.REQUEST_MAX_TIMEOUT), onTimeout: () {
      hideAppLoader();
      if (onTimeout != null) onTimeout();
    });
  }

  //Get request
  static getRequest(
      {@required uri,
      header,
      required Function onSuccess,
      required Function onFailure,
      Function? onTimeout,
      Function? onConnectionFailed}) async {
    bool isConnected = await Utilities.isConnectedNetwork();
    if (!isConnected) {
      onConnectionFailed!(
        "Check your internet connection and try again",
      );
      return;
    }
    String url = EndPoints.BASE_URL + uri;
    http.get(Uri.parse(url), headers: header).then((response) {
      print('Done : Success');
      Log.displayResponse(res: response, requestType: 'GET');
      onSuccess(response);
    }).catchError((error) {
      print('Error : catchError');
      onFailure(error.toString());
    }).timeout(Duration(seconds: FTFGlobal.REQUEST_MAX_TIMEOUT), onTimeout: () {
      print('Error : TimeOut');
      if (onTimeout != null) onTimeout();
    });
  }

  /// if hasCloseButton = true, then make sure text should be get from "title" variable for default titleText widget
  static getSnackToast({
    title = 'Error',
    message = '',
    snackPosition = SnackPosition.TOP,
    backgroundColor,
    colorText,
    Widget? icon,
    hasCloseButton = false,
    Widget? titleText,
    Widget? messageText,
    Duration? duration,
    Function? onTapSnackBar,
    Function? onTapButton,
    bool withButton = false,
    buttonText = 'Ok',
    buttonTextColor,
    Function? onDismissed,
  }) {
    backgroundColor = backgroundColor ?? Colors.black;
    // (SessionImpl.isDarkMode() ? Colors.white : Colors.black);
    colorText = colorText ?? Colors.white;
    //(SessionImpl.isDarkMode() ? Colors.black : Colors.white);
    if (hasCloseButton) {
      titleText = titleText ??
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text('$title', style: const TextStyle(color: Colors.white)),
              ),
              InkWell(
                onTap: () {
                  if (Get.isSnackbarOpen) Get.back();
                },
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              )
            ],
          );
      if (message == null || message.toString().isEmpty) {
        messageText = messageText ?? const Center();
      }
    }

    // if (duration == null) {
    //   duration = Duration(seconds: 3);
    // }

    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        !hasCloseButton ? title : null,
        message,
        // padding: EdgeInsets.all(10),
        mainButton: withButton
            ? TextButton(
                onPressed: () {
                  if (onTapButton != null) onTapButton();
                },
                child: Text(
                  buttonText,
                  style: TextStyle(color: buttonTextColor),
                ),
              )
            : null,
        onTap: (tap) {
          if (onTapSnackBar != null) onTapSnackBar(tap);
        },
        duration: duration ?? const Duration(seconds: 3),
        snackPosition: snackPosition,
        titleText: titleText,
        messageText: messageText,
        backgroundColor: backgroundColor,
        icon: icon,
        colorText: colorText,
        snackbarStatus: (status) {
          print(status.toString());
          if (status == SnackbarStatus.CLOSED) {
            if (onDismissed != null) {
              onDismissed();
            }
          }
        },
      );
    }
  }

  static multipartReq({
    @required uri,
    File? file,
    body,
    header,
    bool hasBearer = false,
    required Function onSuccess,
    required Function onFailure,
    Function? onTimeout,
    Function? onConnectionFailed,
  }) async {
    bool isConnected = await Utilities.isConnectedNetwork();
    if (!isConnected) {
      if (onConnectionFailed != null) {
        onConnectionFailed("Check your internet connection and try again");
      }
      hideAppLoader();
      getSnackToast(
        title: 'Connection Error',
        message: "Check your internet connection and try again",
      );
      //Get.to(NoInternetView());
      return;
    }

    if (hasBearer) {
      header = {
        'Authorization': 'Bearer ${AppStorage.getAccessToken()}',
      };
    }

    var url = EndPoints.BASE_URL + uri;
    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (hasBearer) request.headers.addAll(header);

    request.fields.addAll(body);

    if (file != null && file.isAbsolute) {
      var stream = http.ByteStream(Stream.castFrom(file.openRead()));
      var length = await file.length();
      var multipartFile = http.MultipartFile('file', stream, length, filename: basename(file.path));
      request.files.add(multipartFile);
    }

    print(request.toString());
    await request.send().then((resStream) {
      resStream.stream.transform(utf8.decoder).transform(const LineSplitter()).listen((response) {
        print(response);
        final responseBody = jsonDecode(response);
        Log.displayResponse(payload: request.fields, res: responseBody, requestType: 'POST');
        onSuccess(response);
      });
    }).catchError((error) {
      print('Error : catchError $error');
      print(url);
      WebServices.getSnackToast(
          message: error.toString(), colorText: Colors.white, backgroundColor: Colors.red);

      onFailure(error);
    }).timeout(Duration(seconds: FTFGlobal.REQUEST_MAX_TIMEOUT), onTimeout: () {
      hideAppLoader();
      if (onTimeout != null) onTimeout();
    });
  }
}

/*
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJlMmVlMzEzNi0wMzRlLTQxYzEtOGJlOS00NGIyZjkxYmIxZGYiLCJqdGkiOiI1Mzk0MzI3NTE4ZGE0MmJmMGNlMDk3ZTdjN2UyZTRjMjY4ZjA4OTY0MmM5NWYzN2I2OTk2YWM0NjFmZTcxYjFlYzFiOTc3OGE1OTAwOWMwMyIsImlhdCI6MTYyNTE0NTI5OCwibmJmIjoxNjI1MTQ1Mjk4LCJleHAiOjE2NTY2ODEyOTgsInN1YiI6IjlkNmViOTI0LTVhYTQtNGE1NS05N2IzLTY5MzZlZDc0NjkzZSIsInNjb3BlcyI6W119.Gh_-e3IVj7fvcMZZrsWCLudkN--AJo3HCkCoEQIM0iMjG7yPmevY_y_YNiviOmjbYNxDoq-ciqY6y4bxoRIhoE5boEb20FMpiNDKncuUvuadePWw9uCI9g43ue6CmQXKT1gru7mRY326wkZNhT6WrxIf5s13nnmmdd1ilhpv8Jrtu9GpSuBqtIICCey40lSMPCzaK2gNz9esPZis5ucDZp4RPrpDsXIqlI0jKCy7T305q6BJDnEjbSkLWx8engtNura6UcwTAjXpRuyMIx8ZFh626Uonb7iyvXu44ET1KCtCnlQG9Ehk5n-CWie_-0UonOfXDguWsrBipAHrXP_1Vy9S-dkAkjEieEdCPtCHJ4W7YpR_IWz1bPJ99jmxK1xIe1u-QzSlsMJcUQtMZE8fnaE7ga2vMF0r5IFMBfIdP6wngsI1OKhKlAB0TsO1YgkFvNKtM1IHaY1QQngrAY3AJOSSJoYGHf7sh7ljwLLfo-ZCDNVWZttNxzvOHEvOd1OH78notuzMzxvzgoZdhfXg8UR31qrdC9MGg-3OHzWIFuX1Wnb9xsGm4IFHxECaJIcb4cpKWd2XHDJ8BthybHuJgZyHj5IRnHXj4FaPjX2q-XWKGp-DotNHoPB6E1Ji308OyOtLB2AtUORcyAz-dSdczIq8eFKIzeAxFi6OhcFh5ws

*/
