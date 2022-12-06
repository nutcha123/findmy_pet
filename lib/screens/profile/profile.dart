import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/components/widget/custom_button.dart';
import 'package:project/components/widget/result_tile.dart';
import 'package:project/controller/login_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String addr = "";
  String tel = "";
  String email = "";

  getProfile() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString('user_name') ?? "";
      addr = sp.getString('user_addr') ?? "";
      tel = sp.getString('user_tel') ?? "";
      email = sp.getString('user_mail') ?? "";
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

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
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ResultTile(
                    leading: Text("Name"),
                    trailing: Text("$name"),
                  ),
                  ResultTile(
                    leading: Text("Address"),
                    trailing: Text("$addr"),
                  ),
                  ResultTile(
                    leading: Text("Tel"),
                    trailing: Text("$tel"),
                  ),
                  ResultTile(
                    leading: Text("E-Mail"),
                    trailing: Text("$email"),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: CustomButton(
                      onPressed: () {
                        loginController.signOut();
                      },
                      child: Text('Logout'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
