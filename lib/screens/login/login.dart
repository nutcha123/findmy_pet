import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/components/widget/custom_button.dart';
import 'package:project/controller/login_controller.dart';
import 'package:project/screens/register/register.dart';
import 'package:project/screens/wrapper.dart';

import 'package:project/style/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              'Find My Pet',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800]),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset('assets/images/logo.png'),
            Spacer(),
            TextFormField(
              controller: _emailController,
              decoration: textFormStyle.copyWith(hintText: 'E-Mail'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: textFormStyle.copyWith(hintText: 'Password'),
            ),
            Container(
              width: 50.w,
              child: CustomButton(
                  child: Text('Login'),
                  onPressed: () async {
                    loginController
                        .signInWithEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((res) {
                      if (res) {
                        Get.off<void>(Wrapper());
                      }
                    });
                  }),
            ),
            Spacer(
              flex: 1,
            ),
            TextButton(onPressed: () {

              Get.to<void>(const Register());
            }, child: Text('Register')),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      )),
    );
  }
}
