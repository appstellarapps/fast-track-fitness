import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../constants.dart';
import 'custom_button.dart';

hideAppLoader({hideSnacks = true, isBottomSheet = true}) {
  if (Get.isDialogOpen!) {
    // Future.delayed(Duration(milliseconds: 250), () {
    if (hideSnacks) if (Get.isSnackbarOpen) {
      Get.back();
    }
    if (isBottomSheet) {
      Get.back();
    }
    // });
  }
}

apiLoader({
  loadingText = "Loading...",
  ballRotateChase, //ballTrianglePathColoredFilled, //ballPulseSync
  bool showPathBackground = false,
  Function? asyncCall,
  asyncDuration = const Duration(seconds: 1),
}) {
  Future.delayed(const Duration(milliseconds: 100), () {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          // padding: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(120),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xffBBFFE8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(ImageResourceGif.appLoader, height: 80, width: 80),
                    Text('$loadingText',
                        style: const TextStyle(
                            color: Color(0xff00E0B0), fontSize: 14.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      useSafeArea: true,
    );
    Future.delayed(asyncDuration, () {
      if (asyncCall != null) asyncCall();
    });
  });
}

noDataFound({double imageHeight = 200.0, text = 'Sorry, no data available!'}) {
  return Center(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        // Image.asset(ImageResource.dataNotFound, height: imageHeight),
        // Visibility(visible: false, child: Text(uc.widgetRefresher.value)),
        const SizedBox(height: 20),
        Text("$text",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18.0, color: themeBlack, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
      ]));
}

circleProfileNetworkImage({
  networkImage,
  assetImage,
  isAssetSvg,
  double height = 54.0,
  double width = 54.0,
  double avatarRadius = 30,
  borderRadius = 50.0,
  double assetBorderRadius = 0.0,
  var errorDefaultHeight,
  File? imageFile,
  BoxFit? fit,
}) {
  if (networkImage != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        height: height,
        width: width,
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 250),
          imageUrl: networkImage,
          errorWidget: (context, url, error) => Opacity(
            opacity: 0.9,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(milliseconds: 250),
                    imageUrl: EndPoints.defaultProfilePlaceHolderImage,
                  ),
                )),
          ),
          fit: fit ?? BoxFit.cover,
          height: height,
          width: width,
          placeholder: ((context, String s) => SvgPicture.asset(ImageResourceSvg.defaultProfileIc)),
        ),
      ),
    );
  } else if (assetImage != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(assetBorderRadius),
      child: isAssetSvg
          ? SvgPicture.asset(
              assetImage,
              color: themeGrey,
            )
          : Image.asset(assetImage, fit: BoxFit.fill, width: width, height: height),
    );
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 30.0),
      child: SvgPicture.asset(
        ImageResourceSvg.defaultProfileIc,
        height: height,
        width: width,
      ),
    );
  }
}

mediaNetworkImage({
  networkImage,
  assetImage,
  isAssetSvg,
  double height = 54.0,
  double width = 54.0,
  double avatarRadius = 30,
  borderRadius = 50.0,
  double assetBorderRadius = 0.0,
  var errorDefaultHeight,
  File? imageFile,
  BoxFit? fit,
}) {
  if (networkImage != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        height: height,
        width: width,
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 250),
          imageUrl: networkImage,
          errorWidget: (context, url, error) => Image.asset(ImageResourcePng.placeHolder,
              fit: BoxFit.cover, width: width, height: height),
          fit: fit ?? BoxFit.cover,
          height: height,
          width: width,
          placeholder: ((context, String s) =>
              Image.asset(ImageResourcePng.placeHolder, fit: BoxFit.cover)),
        ),
      ),
    );
  } else if (assetImage != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(assetBorderRadius),
      child: isAssetSvg
          ? SvgPicture.asset(
              assetImage,
              color: themeGrey,
            )
          : Image.asset(assetImage, fit: BoxFit.cover, width: width, height: height),
    );
  } else {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
        child: Image.asset(ImageResourcePng.placeHolder, fit: BoxFit.cover));
  }
}

exerciseNetworkImage({
  networkImage,
  assetImage,
  isAssetSvg,
  double height = 54.0,
  double width = 54.0,
  double avatarRadius = 30,
  borderRadius = 50.0,
  double assetBorderRadius = 0.0,
  var errorDefaultHeight,
  File? imageFile,
  BoxFit? fit,
}) {
  if (networkImage != null) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(avatarRadius),
        topRight: Radius.circular(avatarRadius),
        bottomLeft: Radius.circular(avatarRadius),
      ),
      child: Container(
        foregroundDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.3, 1, 1],
          ),
        ),
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 250),
          imageUrl: networkImage,
          errorWidget: (context, url, error) => Image.asset(ImageResourcePng.placeHolder,
              fit: BoxFit.cover, width: width, height: height),
          fit: fit ?? BoxFit.cover,
          height: height,
          width: width,
          placeholder: ((context, String s) => Image.asset(ImageResourcePng.placeHolder)),
        ),
      ),
    );
  } else if (assetImage != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(assetBorderRadius),
      child: isAssetSvg
          ? SvgPicture.asset(
              assetImage,
              color: themeGrey,
            )
          : Image.asset(assetImage, fit: BoxFit.fill, width: width, height: height),
    );
  } else {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
        child: Image.asset(ImageResourcePng.placeHolder, fit: BoxFit.cover));
  }
}

showSnackBar({title, message, position, Duration? duration}) {
  return Get.snackbar('', '',
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: title == 'Error' || title == 'Success' || title == 'Alert' || title == "Exit"
              ? Colors.white
              : Colors.black,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 16.0,
          color: title == 'Error' || title == 'Success' || title == 'Alert' || title == "Exit"
              ? Colors.white
              : Colors.black,
        ),
      ),
      backgroundColor: title == 'Error' || title == 'Alert'
          ? Colors.red
          : title == 'Download' || title == 'Success' || title == "Exit"
              ? Colors.green
              : Colors.white,
      duration: duration ?? 1.seconds,
      snackPosition: position == null ? SnackPosition.TOP : SnackPosition.BOTTOM,
      isDismissible: true);
}

abstract class ScaffoldAppBar {
  // sappBar() {}

  static AppBar appBar({
    String? title,
    Widget? titleWidget,
    actions,
    Widget? backIcon,
    backToolTip = 'Back',
    bool centerTitle = true,
    hasBackIcon = true,
    bool showBottomBorder = true,
    Function? onBackPressed,
    // bool? isDarkMode,
    var textSize,
  }) {
    // if (isDarkMode == null) isDarkMode = SessionImpl.isDarkMode();
    backIcon ??= SvgPicture.asset(
      ImageResourceSvg.back,
      // color: SessionImpl.isDarkMode() ? Colors.white : Colors.black
    );

    //decrease the fonts size if title is too long
    var fontSize = textSize ?? getTitleSize(actions, title);

    return AppBar(
      toolbarHeight: 80,
      title: titleWidget ??
          Text(
            title!,
            style: CustomTextStyles.bold(
              fontSize: fontSize,
              fontColor: themeWhite,
            ),
            textAlign: TextAlign.center,
          ),
      centerTitle: centerTitle,
      iconTheme: const IconThemeData(color: themeWhite),
      backgroundColor: themeBlack,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(bottomRight: Radius.circular(14), bottomLeft: Radius.circular(14))),
      leading: hasBackIcon
          ? Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                tooltip: backToolTip,
                icon: backIcon,
                onPressed: () => onBackPressed != null ? onBackPressed() : Get.back(),
              ),
            )
          : null,
      automaticallyImplyLeading: hasBackIcon,
      actions: <Widget>[
        ActionsRow(
          availableWidth: Get.width / 2,
          actionWidth: 48,
          actions: actions,
        ),
      ],
    );
  }

  static getTitleSize(actions, String? title) {
    var fontSize = 18.0;
    if (actions != null && actions.length >= 3) {
      if (title != null && title.length > 14) {
        if (title.length > 20) {
          fontSize = 18.0;
        } else {
          fontSize = 20.0;
        }
      }
    } else {
      // actions not available and title length is too long...
      if (title != null && title.length > 24) {
        if (title.length > 26) {
          fontSize = 18.0;
        } else {
          fontSize = 20.0;
        }
      }
    }
    return fontSize;
  }
}

class ActionsRow extends StatelessWidget {
  final double? availableWidth;
  final double actionWidth;
  final List<MenuIcon>? actions;

  const ActionsRow({
    this.availableWidth,
    this.actionWidth = 48,
    @required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    if (actions != null && actions!.isNotEmpty) {
      actions!.sort(); // items with ShowAsAction.NEVER are placed at the end

      List<MenuIcon> visible = actions!
          .where((MenuIcon customAction) => customAction.showAsAction == ShowAsAction.ALWAYS)
          .toList();

      List<MenuIcon> overflow = actions!
          .where((MenuIcon customAction) => customAction.showAsAction == ShowAsAction.NEVER)
          .toList();

      double getOverflowWidth() => overflow.isEmpty ? 0 : actionWidth;

      for (MenuIcon customAction in actions!) {
        if (customAction.showAsAction == ShowAsAction.IF_ROOM) {
          if (availableWidth! - visible.length * actionWidth - getOverflowWidth() > actionWidth) {
            // there is enough room
            visible.insert(
                actions!.indexOf(customAction), customAction); // insert in its given position
          } else {
            // there is not enough room
            if (overflow.isEmpty) {
              MenuIcon? lastOptionalAction = visible.lastWhere(
                (MenuIcon customAction) => customAction.showAsAction == ShowAsAction.IF_ROOM,
                // orElse: () => null
              );
              // ignore: unnecessary_null_comparison
              if (lastOptionalAction != null) {
                visible.remove(
                    lastOptionalAction); // remove the last optionally visible action to make space for the overflow icon
                overflow.add(lastOptionalAction);
                overflow.add(customAction);
              } // else the layout will overflow because there is not enough space for all the visible items and the overflow icon
            } else {
              overflow.add(customAction);
            }
          }
        }
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ...visible.map((MenuIcon customAction) => customAction.visibleWidget!),
          if (overflow.isNotEmpty)
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                for (MenuIcon customAction in overflow)
                  PopupMenuItem(
                    textStyle: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 14.0),
                    child: customAction.overflowWidget,
                  )
              ],
            )
        ],
      );
    } else {
      return Container();
    }
  }
}

class MenuIcon implements Comparable<MenuIcon> {
  final Widget? visibleWidget;
  final Widget? overflowWidget;
  final ShowAsAction showAsAction;

  const MenuIcon({
    this.visibleWidget,
    this.overflowWidget,
    this.showAsAction = ShowAsAction.IF_ROOM,
  });

  @override
  int compareTo(MenuIcon other) {
    if (showAsAction == ShowAsAction.NEVER && other.showAsAction == ShowAsAction.NEVER) {
      return 0;
    } else if (showAsAction == ShowAsAction.NEVER) {
      return 1;
    } else if (other.showAsAction == ShowAsAction.NEVER) {
      return -1;
    } else {
      return 0;
    }
  }
}

enum ShowAsAction {
  ALWAYS,
  IF_ROOM,
  NEVER,
}

myIconButton({
  required Widget icon, //icon can be anything text,Icons.add, custom image, Svg image etc.
  tooltip,
  iconSize = 24.0, // default size 24, change from here
  color = Colors.black, //default color black, pass null if color is not required
  Function? onIconPressed, //
}) {
  return IconButton(
    icon: icon,
    onPressed: () => onIconPressed,
    tooltip: tooltip,
    iconSize: iconSize,
    color: color,
  );
}

commonRatingBar({double initialRating = 0.0, double itemSize = 16.0, bool ignoreGestures = true}) {
  return RatingBar.builder(
    initialRating: initialRating,
    minRating: 1,
    direction: Axis.horizontal,
    updateOnDrag: false,
    glow: false,
    allowHalfRating: true,
    itemCount: 5,
    itemSize: itemSize,
    unratedColor: themeLightWhite,
    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
    itemBuilder: (context, _) => SvgPicture.asset(ImageResourceSvg.starIc),
    glowColor: themeGrey,
    onRatingUpdate: (update) {},
    ignoreGestures: ignoreGestures,
  );
}

imageUploadOptionSheet(
    {Function? onPressTitle1, Function? onPressTitle2, String? title1, String? title2}) {
  return Get.bottomSheet(
      SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              color: themeWhite,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                  "Choose option",
                  style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
                ),
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: InkWell(
                    onTap: () {
                      if (onPressTitle1 != null) {
                        onPressTitle1();
                      }
                    },
                    child: Text(
                      title1 ?? "Camera",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: InkWell(
                    onTap: () {
                      if (onPressTitle2 != null) {
                        onPressTitle2();
                      }
                    },
                    child: Text(
                      title2 ?? "Gallery",
                      style: CustomTextStyles.semiBold(
                        fontColor: themeBlack,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: false);
}

commonDay({Function? onTap, bool isSelected = false, String? text}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? themeBlack : themeLightWhite,
        ),
        height: 28,
        width: 28,
        child: Center(
          child: Text(
            text!,
            style: CustomTextStyles.normal(
              fontSize: 16.0,
              fontColor: isSelected ? themeWhite : themeBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

commonBottomSheet({title}) {
  return Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: themeWhite,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "Successful!",
                style: CustomTextStyles.semiBold(fontColor: themeBlack, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 30.0,
                bottom: 30.0,
              ),
              child: Text(
                title,
                style: CustomTextStyles.normal(
                  fontSize: 14.0,
                  fontColor: grey50,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: ButtonRegular(
                buttonText: "Ok",
                onPress: () {
                  if (Get.isBottomSheetOpen!) Get.back();
                  Get.back(result: true);
                },
              ),
            )
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: false);
}

launchEmail(String toMailId, String subject, String body) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: toMailId,
    query: subject, //add subject and body here
  );
  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    throw 'Could not launch ';
  }
}

launchCall(String number) async {
  UrlLauncher.launch('tel:${number.toString().replaceAll(' ', '')}');
}

shareApp() async {
  print("called");
  try {
    await Share.share('Check out this awesome app: Fast Track Fitness!');
  } catch (e) {
    print('Error sharing: $e');
  }
}
