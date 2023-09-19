import 'package:fasttrackfitness/app/core/helper/common_widget/custom_print.dart';

class Validations {
  static String validateEmpty(String input, String hint, {String? errorMsg, checkEmpty = true}) {
    var pleaseEnter = 'Please enter';

    if (checkEmpty) {
      if (hint.toLowerCase().contains('enter')) {
        pleaseEnter = 'Please';
      }
      if (input.isEmpty) if (errorMsg == null) {
        return "$pleaseEnter " + hint;
      } else {
        return errorMsg;
      }
      else {
        return "";
      }
    } else {
      return "";
    }
  }

  static String validateGst(String input, String hint, {bool checkEmpty = true}) {
    /*
    The first 2 digits denote the State Code (01-37) as defined in the Code List for Land Regions.
    The next 10 characters pertain to PAN Number in AAAAA9999X format.
    13th character indicates the number of registrations an entity has within a state for the same PAN.
    14th character is currently defaulted to "Z"
    15th character is a checksum digit
    This regex pattern accommodates lower and upper case.
    example : (27AAAAA1234A1ZV, 27AAPFU0939F1ZV)
    */
    Pattern gstPattern;
    gstPattern =
        // r'^{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}+$';
        // r'^[0-9]{2}[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}zZ[0-9a-zA-Z]{1}$';
        r'^([0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[A-Z0-9]{1}[Z]{1}[A-Z0-9]{1})$';
    // r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
    RegExp regex = RegExp('$gstPattern');

    if (checkEmpty) {
      if (input.isEmpty) {
        return "Please enter " + hint;
      } else if (!regex.hasMatch(input)) {
        return "Please enter valid " + hint;
      } else {
        return "";
      }
    } else {
      if (!regex.hasMatch(input)) {
        return "Please enter valid " + hint;
      } else {
        return "";
      }
    }
  }

  static String validateName(String input, String hint, {bool checkEmpty = true}) {
    Pattern pattern = '[a-zA-Z]';
    RegExp regex = RegExp('$pattern');
    printLog(hint);
    if (checkEmpty) {
      if (input.isEmpty) {
        return "Please enter " + hint;
      } else if (input.length < 2) {
        return "Please enter valid " + hint;
      } else if (!regex.hasMatch(input)) {
        return "Please enter valid " + hint;
      } else {
        return "";
      }
    } else {
      if (input.isNotEmpty && input.length < 2) {
        return "Please enter valid " + hint;
      } else if (input.isNotEmpty && !regex.hasMatch(input)) {
        return "Please enter valid " + hint;
      } else {
        return "";
      }
    }
  }

  static String validateEmail(String input, String hint, {bool checkEmpty = true}) {
    var errorPrefix = 'Please enter';
    if (hint.toLowerCase().contains('enter')) {
      errorPrefix = 'Please';
    }
    if (checkEmpty) {
      if (validateEmpty(input, hint).isEmpty) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp('$pattern');
        if (!regex.hasMatch(input)) {
          return "$errorPrefix valid " + hint;
        } else {
          return "";
        }
      } else {
        return "$errorPrefix " + hint;
      }
    } else {
      if (input.isNotEmpty) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp('$pattern');
        if (!regex.hasMatch(input)) {
          return "$errorPrefix valid " + hint;
        } else {
          return "";
        }
      } else {
        return "";
      }
    }
  }

  static String validateMobile(String input, String hint, {bool checkEmpty = true}) {
    if (checkEmpty) {
      if (input.isEmpty || input.length < 8 || input.length > 16) {
        return "Please enter valid $hint";
      } else if (!isMobileNumber(input)) {
        return "Please enter valid $hint";
      } else {
        return "";
      }
    } else {
      if (input.isNotEmpty) {
        if (isMobileNumber(input)) {
          if (input.length < 8 || input.length > 16) {
            return "Please enter valid $hint";
          } else {
            return "";
          }
        } else {
          return "Please enter valid $hint";
        }
      } else {
        return "";
      }
    }
  }

  static String validateBankAccount(String input, String hint, {bool checkEmpty = true}) {
    if (checkEmpty) {
      if (input.isEmpty || input.length < 9 || input.length > 18) {
        return "Please enter valid $hint";
      } else if (!isMobileNumber(input)) {
        return "Please enter valid $hint";
      } else {
        return "";
      }
    } else {
      if (input.isNotEmpty) {
        if (isMobileNumber(input)) {
          if (input.length < 9 || input.length > 18) {
            return "Please enter valid " + hint;
          } else {
            return "";
          }
        } else {
          return "Please enter valid " + hint;
        }
      } else {
        return "";
      }
    }
  }

  static String validateUserName(String input, String hint) {
    if (input.isEmpty) {
      return "Please enter " + hint;
    } else if (isMobileNumber(input)) {
      return validateMobile(input, hint);
    } else {
      return validateEmail(input, hint);
    }
  }

  static String validatePassword(String input, String hint) {
    if (input.isEmpty) {
      return "Please enter " + hint;
    } else if (input.length < 8 || input.length > 16) {
      return "Password must be between 8-16 characters";
    } else {
      return "";
    }
  }

  static String validateCVV(String input, String hint) {
    if (input.isEmpty || input.length < 3) {
      return "Invalid " + hint;
    } else {
      return "";
    }
  }

  static String validatePanNumber(String input, String hint, {bool checkEmpty = true}) {
    Pattern pattern = r'[A-Z]{5}[0-9]{4}[A-Z]{1}';
    RegExp regex = RegExp('$pattern');

    if (checkEmpty) {
      if (input.isEmpty) {
        return "Please enter PAN Number";
      } else if (!regex.hasMatch(input)) {
        return "Enter valid PAN number";
      } else if (input.length != 10) {
        return "Enter valid PAN number";
      } else {
        return "";
      }
    } else {
      if (input.isNotEmpty && !regex.hasMatch(input)) {
        return "Enter valid PAN number";
      } else if (input.isNotEmpty && input.length != 10) {
        return "Enter valid PAN number";
      } else {
        return "";
      }
    }
  }

  static String validateCINNumber(String input, String hint, {bool checkEmpty = true}) {
    Pattern pattern = r'[A-Z]{1}[0-9]{5}[A-Z]{2}[0-9]{4}[A-Z]{3}[0-9]{6}';
    RegExp regex = RegExp('$pattern');

    if (checkEmpty) {
      if (input.isEmpty) {
        return "Please enter CIN Number";
      } else if (!regex.hasMatch(input)) {
        return "Enter valid CIN number";
      } else if (input.length != 21) {
        return "Enter valid CIN number";
      } else {
        return "";
      }
    } else {
      if (input.isNotEmpty && !regex.hasMatch(input)) {
        return "Enter valid CIN number";
      } else if (input.isNotEmpty && input.length != 21) {
        return "Enter valid CIN number";
      } else {
        return "";
      }
    }
  }

// ^[A-Za-z]{4}0[A-Z0-9a-z]{6}$
  static String validateIFSCNumber(String input, String hint, {bool checkEmpty = true}) {
    Pattern pattern = r'[A-Za-z]{4}0[A-Z0-9a-z]{6}';
    RegExp regex = RegExp('$pattern');
    if (checkEmpty) {
      if (input.isEmpty) {
        return "Please enter IFSC Number";
      } else if (!regex.hasMatch(input)) {
        return "Enter valid IFSC Number";
      } else if (input.length != 11) {
        return "Enter valid IFSC Number";
      } else {
        return "";
      }
    } else {
      if (input.isNotEmpty && !regex.hasMatch(input)) {
        return "Enter valid IFSC Number";
      } else if (input.isNotEmpty && input.length != 11) {
        return "Enter valid IFSC Number";
      } else {
        return "";
      }
    }
  }

  static String validateAadharNumber(String input, String hint, {bool checkEmpty = true}) {
    Pattern pattern = r'[0-9]{12}';
    RegExp regex = RegExp('$pattern');
    if (checkEmpty) {
      if (input.isEmpty) {
        return "Please enter Aadhar Number";
      } else if (!regex.hasMatch(input)) {
        return "Enter valid Aadhar Number";
      } else if (input.length != 12) {
        return "Enter valid Aadhar Number";
      } else {
        return "";
      }
    } else {
      if (input.isNotEmpty && !regex.hasMatch(input)) {
        return "Enter valid Aadhar Number";
      } else if (input.isNotEmpty && input.length != 12) {
        return "Enter valid Aadhar Number";
      } else {
        return "";
      }
    }
  }

  static String validateRegistrationNumber(String input, String hint, {bool checkEmpty = true}) {
    Pattern pattern = r'[A-Z]{1}[0-9]{5}[A-Z]{2}[0-9]{4}[A-Z]{3}[0-9]{6}';
    RegExp regex = RegExp('$pattern');
    if (checkEmpty) {
      if (input.isEmpty) {
        return "Please enter Registration Number";
      } else if (!regex.hasMatch(input)) {
        return "Enter valid Registration number";
      } else if (input.length != 21) {
        return "Enter valid Registration number";
      } else {
        return "";
      }
    } else {
      if (input.isNotEmpty && !regex.hasMatch(input)) {
        return "Enter valid Registration number";
      } else if (input.isNotEmpty && input.length != 21) {
        return "Enter valid Registration number";
      } else {
        return "";
      }
    }
  }

  static bool isPanNumber(String value) {
    RegExp regex = RegExp(r'[A-Z]{5}[0-9]{4}[A-Z]{1}');
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static String cardExpiryDate(String input, String hint) {
    var split = input.split('/');

    if (input.isEmpty) {
      return "Please enter $hint";
    } else if (int.parse(split[0]) >= 13) {
      return "Enter valid date ";
    } else if (input.length != 7) {
      return "Enter valid date ";
    } else {
      return "";
    }
  }

  static String validatecardNumber(String input, String hint) {
    if (input.isEmpty) {
      return "Please enter " + hint;
    } else if (input.length != 19) {
      return "Please enter valid number";
    } else {
      return "";
    }
  }

  static bool iscardNumberValid(String value) {
    RegExp regex = RegExp(r'^-?[0-9]+$');
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool isMobileNumber(String value) {
    // RegExp regex = RegExp(r'^-?[0-9]+$');
    RegExp regex = RegExp(r'^(?:[+])?[0-9]+$');

    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}
