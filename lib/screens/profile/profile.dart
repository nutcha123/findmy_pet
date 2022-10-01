import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/components/widget/custom_button.dart';
import 'package:project/controller/login_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("My Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Owner Detail '),
                Spacer(),
                TextButton(
                  child: Text(
                    'Edit',
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Container(
              height: 30.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Name"),
                  Text("Address"),
                  Text("Tel"),
                  Text("E-Mail"),
                ],
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              child: CustomButton(
                onPressed: () {
                  loginController.signOut();
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
