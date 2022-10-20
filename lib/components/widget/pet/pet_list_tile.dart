

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    final MyPetController myPetController = Get.find<MyPetController>();
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
                        myPetController.showDeletePetDialog(
                            context, pet.petId!);
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
                        child: pet.imageUrl == null ? SpinKitCircle(color: Colors.blue,): Image.network(pet.imageUrl!,fit: BoxFit.cover),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lost Mode'),
                      CupertinoSwitch(value: false, onChanged: (value) {
                        
                      },),
                    ],
                  ),
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
                              return Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    QrImage(
                                      data: pet.token!,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Text('${pet.token!}'),

                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                  ],
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
