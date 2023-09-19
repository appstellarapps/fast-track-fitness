import 'package:flutter/cupertino.dart';

class Helper {
  Helper();
  hideKeyBoard() => FocusManager.instance.primaryFocus?.unfocus();
}
