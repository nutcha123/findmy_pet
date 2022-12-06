import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/login/login.dart';
import 'package:project/screens/wrapper.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      EasyLoading.show(status: 'Loading');
      final UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('uid : ${user.user?.uid}');
      final QuerySnapshot firestoreResponse = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: user.user?.uid)
          .get();

      final Map userData = firestoreResponse.docs.first.data() as Map;

      print(userData["email"]);
      print(userData["username"]);
      print(userData["uid"]);
      print(userData["addr"]);
      print(userData["tel"]);

      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('user_id', userData["uid"]);
      sp.setString('user_name', userData["username"]);
      sp.setString('user_mail', userData["email"]);
      sp.setString('user_addr', userData["addr"]);
      sp.setString('user_tel', userData["tel"]);
      sp.setString("accessToken", await user.user!.getIdToken());

      EasyLoading.dismiss();

      return true;
    } catch (err) {
      print(err);
      EasyLoading.dismiss();
      return false;
    }
  }

  signOut() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.remove('accessToken');
    // sp.remove('user_id');
    sp.clear();
    await FirebaseAuth.instance.signOut();
    Get.off(const Login());
    return true;
  }

  isAuth() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getString("accessToken") != null) {
      Get.off(const Wrapper());
    }
  }

  @override
  onInit() {
    super.onInit();
    isAuth();
  }
}
