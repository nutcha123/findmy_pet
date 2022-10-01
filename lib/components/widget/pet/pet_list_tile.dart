import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/controller/mypet_controller.dart';
import 'package:project/model/pet.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PetListTile extends StatelessWidget {
  final Pet pet;
  const PetListTile({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyPetController myPetController  = Get.find<MyPetController>();
    return Container(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      pet.name!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.75,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        myPetController.showDeletePetDialog(context, pet.petId!);
                      },
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('AGE : ${pet.age}',
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 30.w,
                      height: 30.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cat_November_2010-1a.jpg/1200px-Cat_November_2010-1a.jpg',
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${pet.type}'),
                      Text('${pet.breed}'),
                      Text('${pet.personalize}'),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Spacer(),
                  SizedBox(
                      width: 30.w,
                      height: 45,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        onPressed: () {
                          showGeneralDialog(
                            barrierLabel: "",
                            barrierDismissible: true,
                            context: context,
                            pageBuilder: (context, _, __) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [QrImage(data: pet.petId!)],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Ionicons.qr_code),
                        label: Text('View'),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
