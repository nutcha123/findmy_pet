import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ionicons/ionicons.dart';
import 'package:project/controller/mypet_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static final String homeRoutePath = "/home";
  @override
  Widget build(BuildContext context) {
    MyPetController myPetController = Get.find<MyPetController>();
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            child: Icon(Ionicons.add),
          )),
      appBar: AppBar(
        title: Text('FIND MY PETS'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      String fileName = Uuid().v4();
                      Reference ref =
                          FirebaseStorage.instance.ref('images/$fileName.jpg');
                      await ref.putFile(File(image!.path));

                      print('done');

                      print(await ref.getDownloadURL());
                    },
                    child: Text('FIND BY ID'))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
