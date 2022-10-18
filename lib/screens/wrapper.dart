import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/controller/wrapper_controller.dart';
import 'package:project/screens/mypet/mypet.dart';
import 'package:project/screens/profile/profile.dart';
import 'package:project/screens/scanner/scanner.dart';

import '../style/app_color.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  @override
  Widget build(BuildContext context) {
    // Page List
    var pages = [Home(), Scanner(), MyPet(), Profile()];

    // Use Wrapper Controller
    WrapperController wrapperController = Get.find<WrapperController>();
    return Scaffold(
      body: Obx(() => Container(
            child: pages[wrapperController.navigatorIndex.value],
          )),
      bottomNavigationBar: ConvexAppBar(
        height: 60,
        backgroundColor: AppColor.white,
        elevation: 0,
        onTap: (index) {
          wrapperController.navigatorIndex.value = index;
        },
        initialActiveIndex: 0,
        
        items: [
          TabItem(
              isIconBlend: false,
              icon: Container(
                child: Image.asset(
                  'assets/images/icons/home.png',
                  fit: BoxFit.contain,
                ),
              )),
          TabItem(
              icon: Container(
            child: Image.asset(
              'assets/images/icons/qrscan.png',
              fit: BoxFit.contain,
            ),
          )),
          TabItem(
              icon: Container(
            child: Image.asset(
              'assets/images/icons/pet.png',
              fit: BoxFit.contain,
            ),
          )),
          TabItem(
              icon: Container(
            child: Image.asset(
              'assets/images/icons/profile.png',
              fit: BoxFit.contain,
            ),
          )),
        ],
      ),
    );
  }
}
