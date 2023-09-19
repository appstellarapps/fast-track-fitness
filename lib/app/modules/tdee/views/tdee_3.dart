import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/common_widget/custom_button.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/tdee/controllers/tdee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TDEE3 extends StatelessWidget {
  const TDEE3({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TdeeController());
    return Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Obx(
                    ()=> InkWell(
                  onTap: () {
                    controller.selectedGoalIndex.value = index;
                  },
                  child: Container(

                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 25),
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                        boxShadow:  const [
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
                        color: controller.selectedGoalIndex.value == index
                            ? themeBlack
                            : const Color(0xfff9f9f9)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.tdeeGoalLevel[index].title!,
                          style: CustomTextStyles.semiBold(
                              fontSize: 16.0,
                              fontColor:
                              controller.selectedGoalIndex.value == index
                                  ? themeWhite
                                  : themeBlack),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          controller.tdeeGoalLevel[index].subTitle!,
                          style: CustomTextStyles.normal(
                              fontSize: 11.0,
                              fontColor:
                              controller.selectedGoalIndex.value == index
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
            itemCount: controller.tdeeGoalLevel.length),
        Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
            child: ButtonRegular(onPress: (){
              controller.calculation();
              controller.selectedStepsIndex.value = 4;
            },buttonText: "NEXT",))
      ],
    );
  }
}
