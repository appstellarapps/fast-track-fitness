import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../../../modules/trainer/trainer_dashboard/side_drawer/side_drawer.dart';

class CommonDrawer extends StatefulWidget {
  CommonDrawer({Key? key, required this.mainWidget, required this.advancedDrawerController})
      : super(key: key);
  @required
  Widget mainWidget;
  @required
  AdvancedDrawerController advancedDrawerController;

  @override
  _CommonDrawerState createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AdvancedDrawer(
          backdropColor: const Color(0xffE5E5E5),
          controller: widget.advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: true,
          childDecoration: const BoxDecoration(
            // NOTICE: Uncomment if you want to add shadow behind the page.
            // Keep in mind that it may cause animation jerks.
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: SideDrawer(
            () {
              widget.advancedDrawerController.hideDrawer();
            },
          ),
          child: widget.mainWidget),
    );
  }
}
