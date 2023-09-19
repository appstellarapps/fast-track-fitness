import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/helper/colors.dart';
import '../controllers/history_controller.dart';

mixin HistoryComponents {
  var ctr = Get.put(HistoryController());

  historyView(index) {
    return InkWell(
      onTap: () {
        paymentDetailsView(index);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: inputGrey,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ctr.historyList[index].createdTimeFormat,
                  style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                ),
                ctr.historyList[index].usercard.cardImageUrl != ""
                    ? Image.network(
                        ctr.historyList[index].usercard.cardImageUrl,
                        height: 30,
                        width: 30,
                      )
                    : const SizedBox.shrink(),
                SvgPicture.asset(
                  ImageResourceSvg.forward,
                  color: themeBlack,
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Amount ',
                      style: CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${ctr.historyList[index].amount} AUD',
                      style: CustomTextStyles.bold(fontSize: 14.0, fontColor: themeBlack),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Validity',
                      style: CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      ctr.historyList[index].subscriptions.validity,
                      style: CustomTextStyles.bold(fontSize: 14.0, fontColor: themeBlack),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Active',
                      style: CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                    ),
                    const SizedBox(height: 5),
                    SvgPicture.asset(ctr.historyList[index].isActive == 0
                        ? ImageResourceSvg.rejected
                        : ImageResourceSvg.selected),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  paymentDetailsView(index) {
    return showDialog(
      barrierColor: Colors.transparent,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: Get.height * 0.52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                width: 4,
                color: inputGrey,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Payment Details".toUpperCase(),
                  style: CustomTextStyles.bold(fontSize: 20.0, fontColor: themeBlack),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  height: 2,
                  color: inputGrey,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Type - ",
                              style:
                                  CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                            ),
                          ),
                          Text(
                            ctr.historyList[index].type.toUpperCase(),
                            style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 2,
                        color: inputGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Validity - ",
                              style:
                                  CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                            ),
                          ),
                          Text(
                            ctr.historyList[index].subscriptions.validity.toUpperCase(),
                            style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 2,
                        color: inputGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Amount - ",
                              style:
                                  CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                            ),
                          ),
                          Text(
                            "${ctr.historyList[index].amount.toString().toUpperCase()} AUD",
                            style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 2,
                        color: inputGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Date - ",
                              style:
                                  CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                            ),
                          ),
                          Text(
                            ctr.historyList[index].createdTimeFormat.toUpperCase(),
                            style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 2,
                        color: inputGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Mode - ",
                              style:
                                  CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                            ),
                          ),
                          Text(
                            ctr.historyList[index].chargeType.toUpperCase(),
                            style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 2,
                        color: inputGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Status - ",
                              style:
                                  CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                            ),
                          ),
                          Text(
                            ctr.historyList[index].chargeStatus.toUpperCase(),
                            style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 2,
                        color: inputGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Ref Id - ",
                              style:
                                  CustomTextStyles.bold(fontSize: 12.0, fontColor: colorGreyText),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ctr.historyList[index].chargeId,
                              style: CustomTextStyles.bold(fontSize: 12.0, fontColor: themeBlack),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 2,
                        color: inputGrey,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
