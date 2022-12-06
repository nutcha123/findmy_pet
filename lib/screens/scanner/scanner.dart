import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project/controller/mypet_controller.dart';
import 'package:project/screens/result/result_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

  String byPassToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiVmFpVUViOGRvSmRuVGd2YmdKVmt5bGZZb3l1MSIsInBldF9pZCI6Ijc2NzM4NTUwLTVmMmUtMTFlZC1iNzI5LWI3M2VkODYwYTc1NyIsImlhdCI6MTY2Nzg4ODg2N30.abtnSNHPy1ffXxwrEnue9oFr63M1cK4NYbXe5V7lxx4";
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

 

  @override
  void reassemble() {
    super.reassemble();
    try {

      if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
    } catch(err) {

      print('error camera');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanner')),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    MyPetController myPetController = Get.find<MyPetController>();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code!.isNotEmpty) {
        controller.pauseCamera();
//call api when found data
        final bool res = await myPetController.findPetByUserIdAndPetId(context,
            token: scanData.code.toString());

        if (res) {
          
         await Get.to<void>(ResultPage(
          token: scanData.code.toString(),
            callback: () {
              controller.resumeCamera();
            },
          ));
          
          


        } else {
          await myPetController.showErrorDialog(context, "Not Found",
              callback: () {
            controller.resumeCamera();
          });
          
        }
      }
      
    });


    
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) async  {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      MyPetController myPetController = Get.find<MyPetController>();

      final bool res = await myPetController.findPetByUserIdAndPetId(context,
            token: byPassToken);

        if (res) {
          
         await Get.to<void>(ResultPage(
          token: byPassToken,
            callback: () {
              controller?.resumeCamera();
            },
          ));
          
  
        } else {
          await myPetController.showErrorDialog(context, "Not Found",
              callback: () {
            controller?.resumeCamera();
          });
          
        }
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
    
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}
