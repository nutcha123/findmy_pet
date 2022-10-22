import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/mypet_controller.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyPetController myPetController = Get.find<MyPetController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              myPetController.searchResult.name.toString(),
            ),
            Text(
              myPetController.searchResult.age.toString(),
            ),
            Text(
              myPetController.searchResult.clinicInfo.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
