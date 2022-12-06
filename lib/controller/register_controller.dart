import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project/model/user.dart' as usr;


class RegisterController extends GetxController {
  Future<void> createAccountByEmailPassword(BuildContext context,
      {
        required String email,
      required String password,
      required  usr.User user}) async {
    try {

      EasyLoading.show(status: "Processing");
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).catchError(( err) => throw Exception(err.message));

      print("User Credential");
      print("${userCredential.user?.email}");
      print("${userCredential.user?.uid}");
      await FirebaseFirestore.instance.collection('Users').add({
        "username" : user.username,
        "email" : userCredential.user?.email,
        "tel" : user.tel,
        "addr" : user.address,
        "uid": userCredential.user?.uid
      }); 

      print('create complete');

      EasyLoading.dismiss();
      Get.back<void>();
      
    } catch (err) {
      print(err);
      print('create failed');
      EasyLoading.dismiss();
    
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
      
    }
  }
}
