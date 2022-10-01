import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'package:project/components/widget/custom_button.dart';
import 'package:project/controller/mypet_controller.dart';
import 'package:project/model/pet.dart';
import 'package:project/style/style.dart';
import 'package:uuid/uuid.dart';

class CreatePetDialog extends StatelessWidget {
  const CreatePetDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    MyPetController myPetController = Get.find<MyPetController>();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _ageController = TextEditingController();
    TextEditingController _breedController = TextEditingController();
    TextEditingController _typeController = TextEditingController();
    TextEditingController _personalizeController = TextEditingController();
    TextEditingController _genderController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.grey[100],
      insetPadding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Get.back<void>(),
              child: CircleAvatar(
                child: Icon(Ionicons.close),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('Create My Pet'),
          ),
          SizedBox(
            height: 25,
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: textFormStyle.copyWith(label: Text("Name")),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _ageController,
                          decoration:
                              textFormStyle.copyWith(label: Text("Age")),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _typeController,
                          decoration:
                              textFormStyle.copyWith(label: Text("Type")),
                        ),
                      )
                    ],
                  ),
                  TextFormField(
                    controller: _breedController,
                    decoration: textFormStyle.copyWith(label: Text("Breed")),
                  ),
                  TextFormField(
                    controller: _genderController,
                    decoration: textFormStyle.copyWith(label: Text("Gender")),
                  ),
                  TextFormField(
                    controller: _personalizeController,
                    decoration:
                        textFormStyle.copyWith(label: Text("Personalize")),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () async {
                            await myPetController.createNewPet(
                                myPet: Pet(
                                    petId: Uuid().v1(),
                                    age: int.tryParse(_ageController.text),
                                    type: _typeController.text,
                                    breed: _breedController.text,
                                    gender: _genderController.text,
                                    imageUrl: "",
                                    name: _nameController.text,
                                    personalize: _personalizeController.text,
                                    clinicInfo: ["1", "2"]));
                            myPetController.findAllMyPet();        
                            Get.back<void>();
                          },
                          child: Text('Create'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showCreatePetDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: false,
    pageBuilder: (context, _, __) {
      return CreatePetDialog();
    },
  );
}
