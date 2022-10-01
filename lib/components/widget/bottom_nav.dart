import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/scanner/scanner.dart';
import 'package:project/style/app_color.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      onTap: (index) {
        
        if (activeIndex != index) {
          switch (index) {
            case 0:
              Get.off(Home);
              break;
            case 1:
              Get.off(Scanner());
              break;
            default:
          }
          setState(() {
          activeIndex = index;
        });
        }
      },
      initialActiveIndex: 0,
      items: [
        TabItem(
          icon: Icon(Ionicons.home),
        ),
        TabItem(icon: Icon(Ionicons.qr_code)),
        TabItem(icon: Icon(Ionicons.person)),
      ],
    );
  }
}
