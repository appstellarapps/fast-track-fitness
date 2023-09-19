import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const themeTransparent = Colors.transparent;
const themeBlack = Color(0xFF030303);
const themeWhite = Color(0xFFFFFFFF);
const themeGreen = Color(0xFF4DDA65);
const themeGrey = Color(0xFF6A7181);
const errorColor = Color(0xffFF4A40);
const themeYellow = Color(0xFFFFC107);
var dropShadow8 = const Color(0xffF1F2F2);
const themeLightWhite = Color(0xFFDADADA);
var white50 = const Color(0xffE5E5E5).withOpacity(0.50);
const inputGrey = Color(0xFFF9F9F9);
const borderColor = Color(0xFFE5E5E5);
var grey50 = const Color(0xff030303).withOpacity(0.50);
var colorGrey = const Color(0xffF0F0F0);
var colorGreyText = const Color(0xffBCBCBC);
var colorGreyEditText = const Color(0xffF9F9F9);
var themeBlack50 = const Color(0xFF030303).withOpacity(0.50);
var themeOrange = const Color(0xffD48000);
var lightGrey = const Color(0xffF7F7F7);

themeGradient({opacity = 1.0}) {
  return LinearGradient(
      begin: Alignment.topCenter,
      stops: const [0.0, 1.5],
      end: Alignment.bottomRight,
      colors: [
        themeGrey.withOpacity(opacity),
        themeBlack.withOpacity(opacity),
      ]);
}

