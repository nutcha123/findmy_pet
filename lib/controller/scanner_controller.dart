import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ScannerController extends GetxController {
  Rx<int> modeIndex = 0.obs;
  Rx<String> scannerMode = "Scan".obs;

  void setScanMode(int index, String mode) {
    if (index >= 0 && index < 2) {
      scannerMode.value = mode;
      modeIndex.value = index;
    }
  }
}
