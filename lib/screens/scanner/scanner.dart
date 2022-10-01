import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/scanner_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class Scanner extends StatelessWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScannerController scannerController = Get.find<ScannerController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Obx(() => Text(scannerController.scannerMode.value)),
      ),
      body: Column(children: [
        Obx(() => Expanded(
                child: IndexedStack(
              index: scannerController.modeIndex.value,
              children: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  alignment: Alignment.center,
                  child: QrImage(
                    data: "112312312",
                    size: 80.w,
                  ),
                ),
              ],
            ))),
        Container(
          color: Color.fromARGB(255, 23, 27, 29),
          alignment: Alignment.center,
          height: 20.w,
          child: Row(children: [
            Expanded(
                child: TextButton(
                    onPressed: () {
                      scannerController.setScanMode(0, 'SCAN');
                    },
                    child: Text('Scan'))),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      scannerController.setScanMode(1, 'SHOW');
                    },
                    child: Text('MY QR'))),
          ]),
        )
      ]),
    );
  }
}
