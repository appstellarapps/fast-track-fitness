import 'package:fasttrackfitness/app/core/helper/common_widget/custom_textformfield.dart';
import 'package:fasttrackfitness/app/core/services/web_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';

import '../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../core/helper/common_widget/custom_print.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/country_utilities.dart';
import '../../../../data/country.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController mobileController = TextEditingController();

  final GlobalKey<CustomTextFormFieldState> keyMobile = GlobalKey<CustomTextFormFieldState>();

  Country? selectedCountry;

  var isValidate = true;
  var phoneCode = "";
  var platformVersion = 'Unknown';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validateLogin() {
    if (keyMobile.currentState!.checkValidation()) {
      isValidate = false;
      return;
    } else {
      apiLoader(asyncCall: () => loginAPI());
    }
  }

  defaultCountry() async {
    selectedCountry =
        CountryPickerUtils.getCountryByIsoCode(WidgetsBinding.instance.window.locale.countryCode!);
    selectedCountry ??= CountryPickerUtils.getCountryByName('United States');
    try {
      platformVersion = (await FlutterSimCountryCode.simCountryCode)!;
      printLog(platformVersion);
      selectedCountry = CountryPickerUtils.getCountryByIsoCode(platformVersion);
      phoneCode = selectedCountry!.phoneCode == "" ? "+91" : "+${selectedCountry!.phoneCode}";
      (phoneCode);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      printLog('No Sim Card found in this device');
    }
  }

  void loginAPI() {
    var body = {
      "countryCode": phoneCode == "" ? "+91" : phoneCode,
      "phoneNumber": mobileController.text,
    };
    WebServices.postRequest(
      uri: EndPoints.LOG_IN,
      body: body,
      hasBearer: false,
      onStatusSuccess: (responseBody) {
        hideAppLoader();
        Get.toNamed(Routes.OTP, arguments: [mobileController.text, phoneCode]);
      },
      onFailure: (error) {

        hideAppLoader(hideSnacks: false);

        },
    );
  }
}
