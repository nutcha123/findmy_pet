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
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('user_id', user.user!.uid);
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
    sp.remove('accessToken');
    sp.remove('user_id');
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
