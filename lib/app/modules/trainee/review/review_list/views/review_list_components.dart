import 'package:fasttrackfitness/app/core/helper/colors.dart';

import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../../../data/review_model.dart';

mixin ReviewListComponents {
  reviewItem(ReviewList reviewsList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            circleProfileNetworkImage(
              networkImage: reviewsList.trainee.profileImage,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${reviewsList.trainee.firstName} ${reviewsList.trainee.lastName}",
                    style: CustomTextStyles.semiBold(
                      fontSize: 16.0,
                      fontColor: themeBlack,
                    ),
                  ),
                  Row(
                    children: [
                      commonRatingBar(
                          initialRating: double.parse(reviewsList.ratting.toString()),
                          itemSize: 16.0,
                          ignoreGestures: true),
                      Text(
                        " ${reviewsList.ratting}",
                        style: CustomTextStyles.semiBold(
                          fontSize: 16.0,
                          fontColor: themeBlack,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 21.0),
              child: Text(
                reviewsList.published,
                style: CustomTextStyles.medium(
                  fontColor: grey50,
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          reviewsList.description,
          style: CustomTextStyles.normal(
            fontSize: 14.0,
            fontColor: grey50,
          ),
        )
      ],
    );
  }
}
