import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../validation.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? prefixText;
  bool obscureText, enabled, showVisibilityPassword;
  bool enabledTextField;
  late TextInputType textInputType;
  late int? maxLength;
  int? maxLines;
  late TextInputAction? textInputAction;
  late String? error;
  late TextEditingController controller;
  late ValidateTypes? validateTypes;
  late ValidateState? validateState;
  late Widget? suffixIcon;
  late String? suffixText;
  late Color? suffixColor;
  late bool isVerifyButton;
  late bool? isVerify;
  late bool? getOnChageCallBack;
  bool? showCounterText;
  List<TextInputFormatter>? inputFormat;
  final void Function()? onVerifyPressed;
  final Function()? onCrossPressed;
  final Function(String)? onCountText;
  late bool? isCounterCallback;
  late bool isCrossIcon;
  late bool? isApplytext = false;
  late int? counter;
  late String? labelText;
  late Function? applyPromo;
  String? errorMsg;
  FocusNode? focusNext;
  FocusNode? focusNode;
  bool? isOptional = false;
  int? minLines;
  final autofillHints; // [AutofillHints.name]
  final void Function(String)? onChanged;
  late TextCapitalization textCapitalization;
  Widget? prefix;
  Color? fillColor;
  bool? hasBorder = true;
  EdgeInsets? contentPadding;
  double? height;
  double? width;
  bool? checkEmpty;
  bool? asteriskMark;
  late TextStyle? style, hintStyle;
  bool autoFocus;
  Color? fontColor;
  Color? borderColor;
  InputBorder? inputBorder;
  final void Function(String)? onSubmit;
  bool isDense = false;
  TextAlign textAlign;

  CustomTextFormField(
      {required Key key,
      this.maxLength,
      this.error = '',
      this.textInputAction,
      this.maxLines = 1,
      required this.hintText,
      this.obscureText = false,
      this.enabled = true,
      this.showVisibilityPassword = false,
      this.textInputType = TextInputType.text,
      required this.controller,
      this.validateTypes,
      this.validateState,
      this.suffixIcon,
      this.suffixText,
      this.enabledTextField = true,
      this.isVerifyButton = false,
      this.isVerify,
      this.onVerifyPressed,
      this.inputFormat,
      this.isCrossIcon = false,
      this.onCountText,
      this.isCounterCallback = false,
      this.showCounterText = false,
      this.counter,
      this.onCrossPressed,
      this.isApplytext,
      this.applyPromo,
      this.labelText,
      this.errorMsg,
      this.focusNext,
      this.focusNode,
      this.isOptional = false,
      this.minLines,
      this.prefixText = "",
      this.getOnChageCallBack = false,
      this.onChanged,
      this.textCapitalization = TextCapitalization.none,
      this.autofillHints, //const [AutofillHints.name],
      this.fillColor,
      this.prefix,
      this.hasBorder = true,
      this.height,
      this.width,
      this.checkEmpty = true,
      this.asteriskMark = false,
      this.style,
      this.hintStyle,
      this.contentPadding,
      this.autoFocus = false,
      this.fontColor,
      this.borderColor,
      this.inputBorder,
      this.suffixColor,
      this.onSubmit,
      this.isDense = false,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode? _focusNode;
  bool? isFocus = false;
  var hintText;
  var inputLength = false.obs;
  String? text = "";

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    } else {
      _focusNode = widget.focusNode;
    }
    _focusNode?.addListener(() {
      if (!mounted) return;
      setState(() {
        isFocus = _focusNode?.hasFocus;
      });
      if (!_focusNode!.hasFocus) {
        if (widget.validateTypes != null) {
          checkValidation(_focusNode!.hasFocus, widget.checkEmpty);
        }
      }
    });
    widget.controller.selection =
        TextSelection.fromPosition(TextPosition(offset: widget.controller.text.length));
    // }

    widget.maxLines ?? 1;

    widget.error ??= "";
    widget.validateState ??= ValidateState.initial;
    widget.isVerify ??= false;
    hintText = widget.hintText;
    widget.validateTypes ??= ValidateTypes.empty;

    // isVerify = widget.isVerify;
    if (widget.controller.text.isNotEmpty) {
      checkValidation(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.hasBorder! ? Colors.transparent : colorGreyEditText,
            border: Border.all(
                color: widget.hasBorder! ? widget.borderColor ?? themeWhite : Colors.transparent),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.prefix != null) widget.prefix!,
              if (widget.prefixText!.isNotEmpty)
                Text(
                  widget.prefixText.toString(),
                  style: CustomTextStyles.semiBold(fontSize: 13.0, fontColor: themeBlack),
                ),
              Flexible(
                child: TextField(
                  textAlign: widget.textAlign!,
                  autofocus: widget.autoFocus,
                  textCapitalization: widget.textCapitalization,
                  inputFormatters: widget.inputFormat,
                  onSubmitted: (text) {
                    if (widget.textInputAction == TextInputAction.next) {
                      if (widget.focusNext == null) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).requestFocus(widget.focusNext);
                      }
                    } else {
                      widget.onSubmit!(widget.controller.text);
                    }
                  },
                  enabled: widget.enabledTextField,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines ?? 1,
                  minLines: widget.minLines,
                  textInputAction: widget.textInputAction,
                  obscureText: widget.obscureText,
                  onChanged: (val) {
                    checkValidation(isFocus, widget.checkEmpty);
                    if (val.isNotEmpty) {
                      inputLength.value = true;
                    } else {
                      inputLength.value = false;
                    }
                    if (widget.getOnChageCallBack!) {
                      widget.onChanged!(val);
                    }
                  },
                  focusNode: _focusNode,
                  keyboardType: widget.textInputType,
                  controller: widget.controller,
                  cursorColor: themeGreen,
                  style: widget.style ??
                      CustomTextStyles.semiBold(
                        fontSize: 16.0,
                        fontColor: widget.fontColor ?? themeWhite,
                      ),
                  decoration: InputDecoration(
                    counterText: '',
                    isDense: widget.isDense,
                    contentPadding: widget.contentPadding ??
                        const EdgeInsets.only(
                          left: 10.0,
                        ),
                    border: widget.inputBorder ?? InputBorder.none,
                    enabledBorder: widget.inputBorder ?? InputBorder.none,
                    focusedBorder: widget.inputBorder ?? InputBorder.none,
                    suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0), child: widget.suffixIcon),
                    fillColor: widget.fillColor ?? Colors.transparent,
                    filled: true,
                    suffixText: widget.suffixText,
                    suffixIconConstraints: BoxConstraints.loose(const Size.fromRadius(40.0)),
                    suffixStyle: CustomTextStyles.semiBold(
                      fontSize: 14.0,
                      fontColor: widget.suffixColor ?? themeGreen,
                    ),
                    hintText: widget.hintText,
                    // asteriskMark: widget.asteriskMark,
                    hintStyle: CustomTextStyles.normal(
                      fontSize: 14.0,
                      fontColor: widget.enabledTextField == false ? themeBlack : colorGreyText,
                    ),
                  ),
                  autofillHints: widget.autofillHints, //[AutofillHints.newPassword]
                ),
              ),
              widget.validateTypes == ValidateTypes.password && widget.controller.text.isNotEmpty
                  ? Visibility(
                      visible: widget.showVisibilityPassword,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                widget.obscureText = !widget.obscureText;
                              });
                            },
                            child: Icon(
                              widget.obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 24.0,
                              color: themeBlack,
                            ),
                          ),
                        ),
                      ),
                    )
                  : widget.validateState == ValidateState.validate
                      ? widget.isApplytext == true
                          ? Padding(
                              padding: const EdgeInsets.only(
                                bottom: 18.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  widget.applyPromo!();
                                },
                                child: Text("Apply",
                                    style: CustomTextStyles.normal(
                                        fontSize: 16.0, fontColor: themeBlack)),
                              ))
                          : widget.isVerifyButton
                              ? Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: !widget.isVerify!
                                      ? InkWell(
                                          onTap: () {
                                            widget.onVerifyPressed!();
                                          },
                                          child: Text("Verify",
                                              style: CustomTextStyles.normal(
                                                  fontSize: 16.0, fontColor: themeBlack)))
                                      : Text("Verified",
                                          style: CustomTextStyles.normal(
                                              fontSize: 16.0, fontColor: themeBlack)),
                                )
                              : widget.isCrossIcon
                                  ? InkWell(
                                      onTap: () {
                                        if (!mounted) return;
                                        setState(() {
                                          widget.counter = 0;
                                        });
                                        widget.onCrossPressed!();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 6.0),
                                        child: SvgPicture.asset(
                                          ImageResourcePng.welcomeBg,
                                          height: 22.0,
                                          width: 22.0,
                                        ),
                                      ),
                                    )
                                  : Container()
                      : Container()
            ],
          ),
        ),
        if (widget.showCounterText!)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.counter.toString() + "/" + widget.maxLength.toString(),
                style: CustomTextStyles.normal(
                  fontColor: themeBlack,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),

        if (widget.validateState == ValidateState.inValidate && widget.error!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.error,
                color: errorColor,
                size: 15.0,
              ),
              const SizedBox(width: 6.0),
              Flexible(
                child: Text('${widget.error}',
                    style: CustomTextStyles.normal(fontColor: errorColor, fontSize: 14.0)),
              ),
            ],
          ),
        // : Container()
      ],
    );
  }

  String getText() {
    return widget.controller.text.trim();
  }

  bool checkValidation([bool? isFocus = false, bool? checkEmpty = true]) {
    String errorText = "";
    var isCheck = true;
    if (widget.isOptional! && widget.controller.text.isEmpty) {
      isCheck = false;
    }
    if (isCheck) {
      switch (widget.validateTypes) {
        case ValidateTypes.name:
          {
            errorText = Validations.validateName(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.empty:
          {
            errorText = Validations.validateEmpty(
                widget.controller.text,
                // widget.errorMsg == null ? hintText : widget.errorMsg
                hintText,
                errorMsg: widget.errorMsg,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.email:
          {
            errorText = Validations.validateEmail(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.mobile:
          {
            errorText = Validations.validateMobile(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.bankaccountno:
          {
            errorText = Validations.validateBankAccount(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.userName:
          {
            errorText =
                Validations.validateUserName(widget.controller.text, widget.errorMsg ?? hintText);
            break;
          }
        case ValidateTypes.password:
          {
            errorText =
                Validations.validatePassword(widget.controller.text, widget.errorMsg ?? hintText);
            break;
          }
        case ValidateTypes.cvv:
          {
            errorText =
                Validations.validateCVV(widget.controller.text, widget.errorMsg ?? hintText);
            break;
          }
        case ValidateTypes.cardExpiryDate:
          {
            errorText =
                Validations.cardExpiryDate(widget.controller.text, widget.errorMsg ?? hintText);
            break;
          }
        case ValidateTypes.validatecardNumber:
          {
            errorText =
                Validations.validatecardNumber(widget.controller.text, widget.errorMsg ?? hintText);
            break;
          }
        case ValidateTypes.gst:
          {
            errorText = Validations.validateGst(widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.pan:
          {
            errorText = Validations.validatePanNumber(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.cin:
          {
            errorText = Validations.validateCINNumber(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.ifsc:
          {
            errorText = Validations.validateIFSCNumber(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.aadharCardNumber:
          {
            errorText = Validations.validateAadharNumber(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }

        case ValidateTypes.registrationNumber:
          {
            errorText = Validations.validateRegistrationNumber(
                widget.controller.text, widget.errorMsg ?? hintText,
                checkEmpty: checkEmpty!);
            break;
          }
        case ValidateTypes.noValidation:
          {
            break;
          }
        case null:
          {}
      }
    }

    if (errorText.isNotEmpty) {
      if (widget.validateState != ValidateState.inValidate) {
        setState(() {
          widget.validateState = ValidateState.inValidate;
        });
      }
      if (!isFocus!) {
        setState(() {
          widget.error = errorText;
        });
      } else if (widget.error!.isNotEmpty) {
        setState(() {
          widget.error = "";
        });
      }
      return true;
    } else {
      if (widget.validateState != ValidateState.validate) {
        setState(() {
          widget.error = "";
          widget.validateState = ValidateState.validate;
        });
      }
      return false;
    }
  }

  void setError(String errorText) {
    if (widget.validateState != ValidateState.inValidate) {
      if (!mounted) return;
      setState(() {
        widget.validateState = ValidateState.inValidate;
      });
    }
    if (!mounted) return;
    setState(() {
      widget.error = errorText;
    });
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

enum ValidateTypes {
  email,
  mobile,
  password,
  name,
  empty,
  gst, //27AAPFU0939F1ZV
  cardExpiryDate,
  validatecardNumber,
  userName,
  cvv,
  pan, //ABCTY1234D
  cin, //L21091KA2019PCP141331 // A12345AB1234ABC123456
  registrationNumber, //U72200MH2009PLC123456 // A12345AB1234ABC123456
  bankaccountno,
  ifsc, // XXXX0YYYYYY
  aadharCardNumber, //1234 5678 9012,
  noValidation
}

enum ValidateState { initial, validate, inValidate }
