import 'package:fasttrackfitness/app/core/helper/colors.dart';
import 'package:fasttrackfitness/app/core/helper/images_resources.dart';
import 'package:fasttrackfitness/app/core/helper/text_style.dart';
import 'package:fasttrackfitness/app/modules/global_search/views/global_search_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/helper/common_widget/custom_app_widget.dart';
import '../../../core/helper/helper.dart';
import '../controllers/global_search_controller.dart';

class GlobalSearchView extends GetView<GlobalSearchController> with GlobalSearchComponents {
  GlobalSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppBar.appBar(
        titleWidget: Padding(
          padding: const EdgeInsets.all(7.0),
          child: TextField(
            controller: controller.searchController,
            onChanged: (searchText) {
              controller.isTyping.value = true;
              if (searchText.isNotEmpty) {
                controller.onSearchChanged(searchText);
              } else {
                Helper().hideKeyBoard();
                controller.searchUser.clear();
                controller.isTyping.value = false;
              }
            },
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle:
                  CustomTextStyles.normal(fontSize: 16.0, fontColor: const Color(0xffCDCDCD)),
              border: searchCommonBorderStyle,
              enabledBorder: searchCommonBorderStyle,
              disabledBorder: searchCommonBorderStyle,
              focusedBorder: searchCommonBorderStyle,
              focusedErrorBorder: searchCommonBorderStyle,
              errorBorder: searchCommonBorderStyle,
              filled: true,
              fillColor: themeWhite,
              contentPadding: const EdgeInsets.only(left: 10.0, right: 6.0),
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(end: 12.0),
                child: // myIcon is a 48px-wide widget.
                    SvgPicture.asset(
                  ImageResourceSvg.search1,
                  color: themeGrey,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(maxHeight: 20),
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.isTyping.value
            ? const Align(
                alignment: Alignment.center, child: CircularProgressIndicator(color: themeBlack))
            : controller.searchUser.isEmpty
                ? noDataFound()
                : ListView.separated(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 25.0,
                    ),
                    itemBuilder: (context, index) {
                      if (index == controller.searchUser.length - 1 && controller.haseMore.value) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: themeGreen)),
                          ),
                        );
                      }
                      return searchItem(controller.searchUser[index], index);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: controller.searchUser.length),
      ),
    );
  }
}
