import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/modules/auth/subscription/views/subscription_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> with SubscriptionComponents {
  SubscriptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeWhite,
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: subscriptionView(),
      floatingActionButton: btnView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
