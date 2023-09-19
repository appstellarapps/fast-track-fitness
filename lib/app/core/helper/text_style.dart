import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';

class CustomTextStyles {
  static normal({required fontSize, required fontColor, bool? isUnderLine}) {
    return TextStyle(
      color: fontColor,
      fontFamily: "OpenSans-Regular",
      fontSize: fontSize,
      decoration: isUnderLine == true ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static bold({required fontSize, required fontColor, bool? isUnderLine}) {
    return TextStyle(
        color: fontColor,
        fontFamily: "OpenSans-Bold",
        fontSize: fontSize,
        decoration: isUnderLine == true ? TextDecoration.underline : TextDecoration.none);
  }

  static medium({required fontSize, required fontColor, bool? isUnderLine}) {
    return TextStyle(
      color: fontColor,
      fontFamily: "OpenSans-Medium",
      fontSize: fontSize,
      decoration: isUnderLine == true ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static light({required fontSize, required fontColor, bool? isUnderLine}) {
    return TextStyle(
      color: fontColor,
      fontFamily: "OpenSans-Light",
      fontSize: fontSize,
      decoration: isUnderLine == true ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static semiBold({required fontSize, required fontColor}) {
    return TextStyle(
      color: fontColor,
      fontFamily: "OpenSans-SemiBold",
      fontSize: fontSize,
    );
  }

  static normalKusunagi({required fontSize, required fontColor, bool? isUnderLine}) {
    return TextStyle(
      color: fontColor,
      fontFamily: "Kusanagi-Regular",
      fontSize: fontSize,
      decoration: isUnderLine == true ? TextDecoration.underline : TextDecoration.none,
    );
  }
}
