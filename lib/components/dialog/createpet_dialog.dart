import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';

import 'package:project/components/widget/custom_button.dart';
import 'package:project/controller/mypet_controller.dart';
import 'package:project/model/pet.dart';
import 'package:project/style/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

class CreatePetDialog extends StatefulWidget {
  const CreatePetDialog({
    super.key,
  });

  @override
  State<CreatePetDialog> createState() => _CreatePetDialogState();
}

class _CreatePetDialogState extends State<CreatePetDialog> {
  @override
  Widget build(BuildContext context) {
    MyPetController myPetController = Get.find<MyPetController>();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _ageController = TextEditingController();
    TextEditingController _breedController = TextEditingController();
    TextEditingController _typeController = TextEditingController();
    TextEditingController _personalizeController = TextEditingController();
    TextEditingController _genderController = TextEditingController();
    myPetController.currentImagePath.value = "";
    return SafeArea(
      child: Dialog(
        backgroundColor: Colors.grey[100],
        insetPadding: const EdgeInsets.all(10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Flexible(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return myPetController
                                    .currentImagePath.value.isEmpty
                                ? Container(
                                  alignment: Alignment.center,
                                  color: Colors.grey[200],
                                  width: 50.w,
                                  height: 50.w,
                                  child: Text('No Image'))
                                : Container(
                                  
                                  
                                  width: 50.w,
                                  height: 50.w,
                                  child: Image.file(
                                      File(
                                        myPetController.currentImagePath.value,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                );
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                          onPressed: () async {
                            myPetController.selectImage();
                          },
                          child: Text('Add Photo')),
                      SizedBox(
                        height: 25,
                      ),
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
                        decoration:
                            textFormStyle.copyWith(label: Text("Breed")),
                      ),
                      TextFormField(
                        controller: _genderController,
                        decoration:
                            textFormStyle.copyWith(label: Text("Gender")),
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
                                        name: _nameController.text,
                                        personalize:
                                            _personalizeController.text,
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
            )
          ],
        ),
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
