import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:project/controller/login_controller.dart';
import 'package:project/controller/mypet_controller.dart';
import 'package:project/controller/register_controller.dart';
import 'package:project/controller/scanner_controller.dart';
import 'package:project/controller/wrapper_controller.dart';

void injectDependencies()  {
  //  sending variable to page

  Get.put(WrapperController());
  Get.put(ScannerController());
  Get.put(LoginController());
  Get.put(MyPetController());
  Get.put(RegisterController());
  
}
