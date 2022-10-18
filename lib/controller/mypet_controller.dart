import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:project/components/dialog/custom_dialog.dart';
import 'package:project/components/widget/custom_button.dart';
import 'package:project/model/pet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetController extends GetxController {
  RxList<Pet> petReactiveList = RxList<Pet>([]);

  Future<void> createNewPet({required Pet myPet}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        
    final String accessToken = sharedPreferences.getString('accessToken')!;
    final String user_id = sharedPreferences.getString('user_id')!;
    // Create New Pet to USER > OWN PET > USER ID 
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc('owned_pet')
          .collection(user_id)
          .add(myPet.toJson());
      
    } catch (err) {
      print(err);
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



  @override
  void onInit() {
    findAllMyPet();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    print('1');
  }




  
}
