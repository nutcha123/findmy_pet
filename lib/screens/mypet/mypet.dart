import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/components/dialog/createpet_dialog.dart';
import 'package:project/components/widget/custom_button.dart';
import 'package:project/components/widget/pet/pet_list_tile.dart';
import 'package:project/controller/mypet_controller.dart';

class MyPet extends StatelessWidget {
  const MyPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyPetController myPetController = Get.find<MyPetController>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: Text('MY PETS'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Obx(() => ListView.builder(
                    itemCount: myPetController.petReactiveList.length,
                    itemBuilder: (context, index) {
                      return PetListTile(
                          pet: myPetController.petReactiveList[index]);
                    },
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: CustomButton(
                  onPressed: () => showCreatePetDialog(context),
                  child: Text('Create New Pet')),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
