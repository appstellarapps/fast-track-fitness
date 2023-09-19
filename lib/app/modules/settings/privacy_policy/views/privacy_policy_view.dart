import 'package:fasttrackfitness/app/core/helper/common_widget/custom_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppBar.appBar(
          title: controller.type == "privacy" ? "Privacy Policy" : "Terms & Conditions"),
      body: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : controller.policy.isEmpty
                ? noDataFound()
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Html(
                      data: controller.policy.value,
                    ),
                  ),
      ),
    );
  }
}
