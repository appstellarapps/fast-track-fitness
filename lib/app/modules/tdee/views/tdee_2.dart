import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_button.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/tdee/controllers/tdee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TDEE2 extends StatelessWidget {
  const TDEE2({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TdeeController());
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        controller.selectedActivityIndex.value = index;
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: themeLightWhite,
                                blurRadius: 2.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: controller.selectedActivityIndex.value == index
                                ? themeBlack
                                : const Color(0xfff9f9f9)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.tdeeActivityLevel[index].title!,
                              style: CustomTextStyles.semiBold(
                                  fontSize: 16.0,
                                  fontColor: controller.selectedActivityIndex.value == index
                                      ? themeWhite
                                      : themeBlack),
                            ),
                            Text(
                              controller.tdeeActivityLevel[index].subTitle!,
                              style: CustomTextStyles.normal(
                                  fontSize: 11.0,
                                  fontColor: controller.selectedActivityIndex.value == index
                                      ? themeWhite
                                      : themeBlack),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox();
                },
                itemCount: controller.tdeeActivityLevel.length),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: ButtonRegular(
                  onPress: () {
                    controller.selectedStepsIndex.value = 3;
                  },
                  buttonText: "NEXT",
                ))
          ],
        ),
      ),
    );
  }
}
