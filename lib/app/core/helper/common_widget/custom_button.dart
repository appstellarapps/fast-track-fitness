import 'package:flutter/material.dart';

import '../colors.dart';
import '../text_style.dart';

class ButtonRegular extends StatefulWidget {
  ButtonRegular(
      {Key? key,
      this.buttonText,
      required this.onPress,
      this.verticalPadding,
      this.isShadow = false,
      this.color = themeGreen,
      this.fontColor = themeBlack})
      : super(key: key);
  final String? buttonText;
  final Function onPress;
  final double? verticalPadding;
  bool? isShadow;
  Color color;
  Color fontColor;

  @override
  _ButtonRegularState createState() => _ButtonRegularState();
}

class _ButtonRegularState extends State<ButtonRegular> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: widget.isShadow!
              ? const [
                  BoxShadow(
                    color: Color(0xffC1E4D9),
                    spreadRadius: 8,
                    blurRadius: 10,
                    offset: Offset(0, 8), // changes position of shadow
                  ),
                ]
              : null,
          color: widget.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 10.0),
        child: Text(
          widget.buttonText ?? "",
          style: CustomTextStyles.semiBold(
            fontColor: widget.fontColor,
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
