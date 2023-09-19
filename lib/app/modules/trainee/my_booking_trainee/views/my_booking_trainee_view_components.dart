import 'package:fasttrackfitness/app/core/helper/colors.dart';

import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

mixin MyBookingTraineeViewComponents {
  commonFields({icon, title, subTitle}) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: CustomTextStyles.normal(
              fontSize: 16.0,
              fontColor: grey50,
            ),
          ),
        ),
        Text(
          subTitle == "" ? "-" : subTitle,
          style: CustomTextStyles.semiBold(
            fontSize: 16.0,
            fontColor: themeBlack,
          ),
        )
      ],
    );
  }
}
