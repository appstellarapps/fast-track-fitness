library pin_code_fields;

import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

// import 'package:relative_scale/relative_scale.dart';
// import 'package:wright_touch/utility/ui/color_pallete.dart';

/// Pin code text fields which automatically changes focus and validates
class PinCodeTextField extends StatefulWidget {
  /// length of how many cells there should be. 3-8 is recommended by me
  final int? length;

  /// you already know what it does i guess :P default is false
  final bool? obsecureText;

  /// returns the current typed text in the fields
  final ValueChanged<String>? onChanged;

  /// returns the typed text when all pins are set
  final ValueChanged<String>? onCompleted;

  /// this defines the shape of the input fields. Default is underlined
  final PinCodeFieldShape? shape;

  /// the style of the text, default is [ fontSize: 20, color: blackColor, fontWeight: FontWeight.bold]
  final TextStyle? textStyle;

  /// background color for the whole row of pin code fields. Default is [Colors.white]
  final Color? backgroundColor;

  /// Border radius of each pin code field
  final BorderRadius? borderRadius;

  /// [height] for the pin code field. default is [50.0]
  final double? fieldHeight;

  /// [width] for the pin code field. default is [40.0]
  final double? fieldWidth;

  /// This defines how the elements in the pin code field align. Default to [MainAxisAlignment.spaceBetween]
  final MainAxisAlignment? mainAxisAlignment;

  /// Colors of the input fields which have inputs. Default is [Colors.green]
  final Color activeColor;

  /// Color of the input field which is currently selected. Default is [Colors.blue]
  final Color selectedColor;

  /// Colors of the input fields which don't have inputs. Default is [Colors.red]
  final Color? inactiveColor;

  /// Colors of the input fields if the [PinCodeTextField] is disabled. Default is [Colors.grey]
  final Color disabledColor;

  /// Border width for the each input fields. Default is [2.0]
  final double? borderWidth;

  /// [AnimationType] for the text to appear in the pin code field. Default is [AnimationType.slide]
  final AnimationType? animationType;

  /// Duration for the animation. Default is [Duration(milliseconds: 150)]
  final Duration? animationDuration;

  /// [Curve] for the animation. Default is [Curves.easeInOut]
  final Curve animationCurve;

  /// [TextInputType] for the pin code fields. default is [TextInputType.visiblePassword]
  final TextInputType textInputType;

  /// If the pin code field should be autofocused or not. Default is [false]
  final bool autoFocus;

  /// Should pass a [FocusNode] to manage it from the parent
  final FocusNode? focusNode;

  /// A list of [TextInputFormatter] that goes to the TextField
  final List<TextInputFormatter> inputFormatters;

  /// Enable or disable the Field. Default is [true]
  final bool enabled;

  /// title of the [AlertDialog] while pasting the code. Default to [Paste Code]
  final String? dialogTitle;

  /// content of the [AlertDialog] while pasting the code. Default to ["Do you want to paste this code "]
  final String? dialogContent;

  /// Affirmative action text for the [AlertDialog]. Default to "Paste"
  final String? affirmativeText;

  /// Negative action text for the [AlertDialog]. Default to "Cancel"
  final String? negativeText;

  /// [TextEditingController] to control the text manually. Sets a default [TextEditingController()] object if none given
  final TextEditingController? controller;

  /// Enabled Color fill for individual pin fields, default is [false]
  final bool? enableActiveFill;

  /// Colors of the input fields which have inputs. Default is [Colors.green]
  final Color? activeFillColor;

  /// Color of the input field which is currently selected. Default is [Colors.blue]
  final Color? selectedFillColor;

  /// Colors of the input fields which don't have inputs. Default is [Colors.red]
  final Color? inactiveFillColor;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  /// Only supports text keyboards, other keyboard types will ignore this configuration. Capitalization is locale-aware.
  /// - Copied from 'https://api.flutter.dev/flutter/services/TextCapitalization-class.html'
  /// Default is [TextCapitalization.none]
  final TextCapitalization? textCapitalization;

  final TextInputAction? textInputAction;

  const PinCodeTextField({
    Key? key,
    this.length,
    this.controller,
    this.obsecureText = false,
    this.onChanged,
    this.onCompleted,
    this.backgroundColor = Colors.white,
    this.borderRadius,
    this.fieldHeight = 60,
    this.fieldWidth = 40,
    this.activeColor = Colors.green,
    this.selectedColor = Colors.blue,
    this.inactiveColor = Colors.red,
    this.disabledColor = Colors.grey,
    this.borderWidth = 2,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.shape = PinCodeFieldShape.underline,
    this.animationType = AnimationType.slide,
    this.textInputType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.enabled = true,
    this.inputFormatters = const <TextInputFormatter>[],
    this.dialogContent = "Do you want to paste this code ",
    this.dialogTitle = "Paste Code",
    this.affirmativeText = "Paste",
    this.negativeText = "Cancel",
    this.textStyle = const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    this.enableActiveFill = false,
    this.activeFillColor,
    this.selectedFillColor = Colors.blue,
    this.inactiveFillColor = Colors.red,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  _PinCodeTextFieldState createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;
  late BorderRadius borderRadius;
  late bool isLandscap;

  @override
  void initState() {
    print("IF YOU WANT TO USE COLOR FILL FOR EACH CELL THEN SET enableActiveFill = true");
    _checkForInvalidValues();
    _assignController();

    if (widget.shape != PinCodeFieldShape.circle && widget.shape != PinCodeFieldShape.underline) {
      borderRadius = widget.borderRadius!;
    }
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    }); // Rebuilds on every change to reflect the correct color on each field.
    // ignore: deprecated_member_use
    _inputList = List<String>.filled(widget.length!, '');
    _initializeValues();
    super.initState();
  }

  // validating all the values
  void _checkForInvalidValues() {
    assert(widget.length != null && widget.length! > 0);
    assert(widget.obsecureText != null);
    assert(widget.fieldHeight != null && widget.fieldHeight! > 0);
    assert(widget.fieldWidth != null && widget.fieldWidth! > 0);
    assert(widget.inactiveColor != null);
    assert(widget.backgroundColor != null);
    assert(widget.borderWidth != null && widget.borderWidth! >= 0);
    assert(widget.mainAxisAlignment != null);
    assert(widget.animationDuration != null);
    assert(widget.shape != null);
    assert(widget.animationType != null);
    assert(widget.textStyle != null);
    assert(widget.affirmativeText != null && widget.affirmativeText!.isNotEmpty);
    assert(widget.negativeText != null && widget.negativeText!.isNotEmpty);
    assert(widget.dialogTitle != null && widget.dialogTitle!.isNotEmpty);
    assert(widget.dialogContent != null && widget.dialogContent!.isNotEmpty);
    assert(widget.enableActiveFill != null);

    assert(widget.inactiveFillColor != null);
    assert(widget.selectedFillColor != null);
    assert(widget.textCapitalization != null);
    assert(widget.textInputAction != null);
  }

  // Assigning the text controller, if empty assiging a new one.
  void _assignController() {
    if (widget.controller == null) {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = widget.controller!;
    }
    _textEditingController.addListener(() {
      var currentText = _textEditingController.text;

      if (widget.enabled && _inputList.join("") != currentText) {
        if (currentText.length >= widget.length!) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.length!) {
              // removing extra text longer than the length
              currentText = currentText.substring(0, widget.length);
            }
            widget.onCompleted!(currentText);
          }
          _focusNode.unfocus();
        }
        if (widget.onChanged != null) {
          widget.onChanged!(currentText);
        }
      }

      _setTextToInput(currentText);
    });
  }

  @override
  void dispose() {
    print("*** Disposing _textEditingController and _focusNode for pin code field ***");
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _initializeValues() {
    for (int i = 0; i < _inputList.length; i++) {
      _inputList[i] = "";
    }
  }

  // selects the right color for the field
  // ignore: unused_element
  Color _getColorFromIndex(int index) {
    if (!widget.enabled) {
      return widget.disabledColor;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus) {
      return widget.selectedColor;
    } else if (_selectedIndex > index) {
      return widget.activeColor;
    }
    return widget.inactiveColor!;
  }

  Future<void> _showPasteDialog(String pastedText) {
    var formattedPastedText =
        pastedText.trim().substring(0, min(pastedText.trim().length, widget.length!));
    return showDialog(
      context: context,
      builder: (context) {
        return Platform.isAndroid
            ? AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(widget.dialogTitle!),
                content: RichText(
                  text: TextSpan(
                    text: widget.dialogContent,
                    style: TextStyle(color: Theme.of(context).textTheme.button!.color),
                    children: [
                      TextSpan(
                        text: formattedPastedText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade600,
                        ),
                      ),
                      TextSpan(
                        text: " ?",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.button!.color,
                        ),
                      )
                    ],
                  ),
                ),
                actions: _getActionButtons(formattedPastedText),
              )
            : CupertinoAlertDialog(
                title: Text(widget.dialogTitle!),
                content: RichText(
                  text: TextSpan(
                    text: widget.dialogContent,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button!.color,
                    ),
                    children: [
                      TextSpan(
                        text: formattedPastedText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade600,
                        ),
                      ),
                      TextSpan(
                        text: " ?",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.button!.color,
                        ),
                      )
                    ],
                  ),
                ),
                actions: _getActionButtons(formattedPastedText),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    isLandscap = MediaQuery.of(context).orientation == Orientation.landscape;
    // initRelativeScaler(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: AbsorbPointer(
            // this is a hidden textfield under the pin code fields.
            absorbing: true, // it prevents on tap on the text field
            child: TextField(
              textInputAction: widget.textInputAction,
              controller: _textEditingController,
              focusNode: _focusNode,
              enabled: widget.enabled,
              autofocus: widget.autoFocus,
              autocorrect: false,
              keyboardType: widget.textInputType,
              textCapitalization: widget.textCapitalization!,
              inputFormatters: <TextInputFormatter>[
                // ignore: deprecated_member_use
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(
                  widget.length,
                ), // this limits the input length
              ],
              enableInteractiveSelection: false,
              showCursor: true,
              // this cursor must remain hidden
              cursorColor: widget.backgroundColor,
              // using same as background color so tha it can blend into the view
              cursorWidth: 0.01,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.transparent,
                height: .01,
                fontSize:
                    0.01, // it is a hidden textfield which should remain transparent and extremely small
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _onFocus,
          onLongPress: widget.enabled
              ? () async {
                  var data = await Clipboard.getData("text/plain");
                  if (data!.text!.isNotEmpty) {
                    _showPasteDialog(data.text!);
                  }
                }
              : null,
          child: Container(
            color: widget.backgroundColor,
            constraints: const BoxConstraints(minHeight: 30),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
            child: Row(
              mainAxisAlignment: widget.mainAxisAlignment!,
              children: _generateFields(),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _generateFields() {
    var result = <Widget>[];
    for (int i = 0; i < widget.length!; i++) {
      result.add(
        Padding(
          padding: EdgeInsets.only(left: i == 0 ? 0.0 : 16.0),
          child: AnimatedContainer(
            curve: widget.animationCurve,
            duration: widget.animationDuration!,
            width: widget.fieldWidth,
            height: widget.fieldHeight,
            decoration: BoxDecoration(
              color: widget.activeFillColor ?? themeWhite,
              borderRadius: BorderRadius.circular(10.0),
              border: widget.shape == PinCodeFieldShape.underline
                  ? Border(
                      bottom: BorderSide(
                        color: _getColorFromIndex(i),
                        width: widget.borderWidth!,
                      ),
                    )
                  : Border.all(
                      color: _getColorFromIndex(i),
                      width: widget.borderWidth!,
                    ),

              // shape: widget.shape == PinCodeFieldShape.underline
              //     ? BoxShape.circle
              //     : BoxShape.rectangle,
              // borderRadius: BorderRadius.circular(16),
              // border: Border.on(color: Colors.white, width: 1.5),
            ),
            child: Center(
              child: AnimatedSwitcher(
                switchInCurve: widget.animationCurve,
                switchOutCurve: widget.animationCurve,
                duration: widget.animationDuration!,
                transitionBuilder: (child, animation) {
                  if (widget.animationType == AnimationType.scale) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  } else if (widget.animationType == AnimationType.fade) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  } else if (widget.animationType == AnimationType.none) {
                    return child;
                  } else {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, .5),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }
                },
                child: Text(
                  widget.obsecureText! && _inputList[i].isEmpty ? "*" : _inputList[i],
                  key: ValueKey(_inputList[i]),
                  style: widget.obsecureText! && _inputList[i].isEmpty
                      ? const TextStyle(
                          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)
                      : widget.textStyle,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return result;
  }

  void _onFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      Future.delayed(Duration(milliseconds: 500), () {
        _focusNode.requestFocus();
      });
    } else {
      _focusNode.requestFocus();
    }
  }

  void _setTextToInput(String data) async {
    // ignore: deprecated_member_use
    var replaceInputList = List<String>.filled(widget.length!, '');

    for (int i = 0; i < widget.length!; i++) {
      replaceInputList[i] = data.length > i ? data[i] : "";
    }

    setState(() {
      _selectedIndex = data.length;
      _inputList = replaceInputList;
    });
  }

  List<Widget> _getActionButtons(String pastedText) {
    var resultList = <Widget>[];
    if (Platform.isAndroid) {
      resultList.addAll([
        // ignore: deprecated_member_use
        ElevatedButton(
          child: Text(widget.negativeText!),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // ignore: deprecated_member_use
        ElevatedButton(
          child: Text(widget.affirmativeText!),
          onPressed: () {
            _textEditingController.text = pastedText;
            Navigator.pop(context);
          },
        ),
      ]);
    } else if (Platform.isIOS) {
      resultList.addAll([
        CupertinoDialogAction(
          child: Text(widget.negativeText!),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text(widget.affirmativeText!),
          onPressed: () {
            _textEditingController.text = pastedText;
            Navigator.pop(context);
          },
        ),
      ]);
    }
    return resultList;
  }
}

enum AnimationType { scale, slide, fade, none }

enum PinCodeFieldShape { box, underline, circle }
