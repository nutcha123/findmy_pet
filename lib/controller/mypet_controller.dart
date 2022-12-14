import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:project/components/dialog/custom_dialog.dart';
import 'package:project/components/widget/custom_button.dart';
import 'package:project/model/pet.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MyPetController extends GetxController {
  late Pet searchResult;
  RxList<Pet> petReactiveList = RxList<Pet>([]);

  RxString currentImagePath = RxString('');


  findUserByUid(String uid) async {
    try {
      final res = await FirebaseFirestore.instance.collection('Users').where('uid',isEqualTo: uid).get();
    return res.docs.first.data();
    }
    catch(err) {

      print(err);
    }

  }

  setLostStatus(bool status, {required String id}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String user_id = sharedPreferences.getString('user_id')!;

    final Query query = await FirebaseFirestore.instance
        .collection('user')
        .doc('owned_pet')
        .collection(user_id)
        .where('petId', isEqualTo: id);
    final QuerySnapshot data = await query.get();

    List doc_id = data.docs
        .map((QueryDocumentSnapshot element) => element.reference.id)
        .toList();

    await FirebaseFirestore.instance
        .collection('user')
        .doc('owned_pet')
        .collection(user_id)
        .doc(doc_id.first)
        .update({'isLost': status});
    findAllMyPet();
  }

  selectImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    currentImagePath.value = image!.path;
  }

  Future<bool> findPetByUserIdAndPetId(BuildContext context,
      {required String token}) async {
    print('toeken : $token');
    final jwt = Jwt.parseJwt(token);
    print('find');
    final Query query = await FirebaseFirestore.instance
        .collection('user')
        .doc('owned_pet')
        .collection(jwt['user_id'])
        .where('petId', isEqualTo: jwt['pet_id'])
        .where('isLost', isEqualTo: true);
    final QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.length > 0) {
      print('found match data');

      final Map<String, dynamic> result =
          snapshot.docs.first.data() as Map<String, dynamic>;

      searchResult = Pet.fromJson(result);

      return true;
    } else {
      print('mathed data not found');
      return false;
    }
  }

  Future<void> createNewPet({required Pet myPet}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String accessToken = sharedPreferences.getString('accessToken')!;
    final String user_id = sharedPreferences.getString('user_id')!;
    final jwt = JWT({
      "user_id": user_id,
      "pet_id": myPet.petId,
    });
    myPet.token = jwt.sign(
      SecretKey('HS256'),
    );
    try {
      EasyLoading.show(status: "Creeating");
      final String fileName = Uuid().v4();

      // upload photo to firebase storage
      final Reference ref =
          FirebaseStorage.instance.ref('pet_images/$user_id/$fileName.jpg');
      await ref.putFile(File(currentImagePath.value));
      // get picture url from storage

      final String imageUrl = await ref.getDownloadURL();

      // send image url to firestore
      myPet.imageUrl = imageUrl;
      await FirebaseFirestore.instance
          .collection('user')
          .doc('owned_pet')
          .collection(user_id)
          .add(myPet.toJson());
      currentImagePath.value = "";
      EasyLoading.dismiss();
    } catch (err) {
      print(err);
      currentImagePath.value = "";
      EasyLoading.dismiss();
    }
  }

  Future<void> findAllMyPet() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // final String accessToken = sharedPreferences.getString('accessToken')!;
    final String user_id = sharedPreferences.getString('user_id')!;
    try {
      EasyLoading.show(status: 'Get All My Pet');

      // GET ALL DATA FROM USER > OWNED PET FROM FIREBASE
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc('owned_pet')
          .collection(user_id)
          .get();

      final List response = snapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      final List<Pet> mypet_list =
          response.map((e) => Pet.fromJson(e)).toList();
      petReactiveList.value = mypet_list;

      print('find all');
      print(mypet_list);

      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();
      print(error);
      petReactiveList.value = [];
    }
  }

  Future<void> deletePetById(String petId) async {
    print('delete');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // final String accessToken = sharedPreferences.getString('accessToken')!;
    final String user_id = sharedPreferences.getString('user_id')!;

    final Query query = await FirebaseFirestore.instance
        .collection('user')
        .doc('owned_pet')
        .collection(user_id)
        .where('petId', isEqualTo: petId);

    final QuerySnapshot data = await query.get();
    List doc_id = data.docs
        .map((QueryDocumentSnapshot element) => element.reference.id)
        .toList();

    await FirebaseFirestore.instance
        .collection('user')
        .doc('owned_pet')
        .collection(user_id)
        .doc(doc_id.first)
        .delete();
    findAllMyPet();
  }

  Future<void> findPetById(String pet_uuid) async {
    print('find : $pet_uuid');
    final res =
        await FirebaseFirestore.instance.collection('user').doc('owned_pet');
    print(res);
  }

  showDeletePetDialog(BuildContext context, String petId) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, _, __) {
        return CustomDialog(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Delete This Pet',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, letterSpacing: 0.75),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                alignment: Alignment.center,
                child: Text('Are you sure to delete this pet ?'),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          deletePetById(petId);

                          Get.back<void>();
                        },
                        child: Text('Confirm'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => Get.back<void>(),
                        child: Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      },
    );
  }

  showErrorDialog(BuildContext context, String title , {VoidCallback? callback}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, _, __) {
        return CustomDialog(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, letterSpacing: 0.75),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          Get.back<void>();
                          callback!();
                        },
                        child: Text('Back'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      },
    );
  }

  @override
  void onInit() {
    findAllMyPet();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    print('1');
  }
}
