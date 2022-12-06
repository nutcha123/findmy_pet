import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project/controller/register_controller.dart';
import 'package:project/model/user.dart';
import 'package:project/style/style.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    RegisterController registerController = Get.find<RegisterController>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController telController = TextEditingController();
    TextEditingController addrController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Column(children: [
        SizedBox(
          height: 25,
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  
                  controller: usernameController,
                  decoration: textFormStyle.copyWith(hintText: 'Username',label: Text("Username")),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "User name must not empty";
                    }
          
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: textFormStyle.copyWith(hintText: 'E-Mail',label: Text("E-Mail")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email  must not empty";
                    }
          
                    return null;
                  },
                ),
                TextFormField(
                  controller: telController,
                  decoration: textFormStyle.copyWith(hintText: 'Telphone No.',label: Text("Telephone No.")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mobile no must not empty";
                    }
          
                    return null;
                  },
                ),
                TextFormField(
                  controller: addrController,
                  maxLines: 5,
                  decoration: textFormStyle.copyWith(
                    hintText: 'Address',
                    label: Text("Address")
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Address must not empty";
                    }
          
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: textFormStyle.copyWith(hintText: 'Password',label: Text("Password")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password must not empty";
                    }
                    if (value.length < 6) return "Password must longer 6 letter";
                    return null;
                  },
                ),
                TextFormField(
                  controller: confPasswordController,
                  decoration:
                      textFormStyle.copyWith(hintText: 'Confirm Password',label: Text("Confirm Password")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password must not empty";
                    }
                    if (value != passwordController.text) {
                      return "Password mismatch";
                    }
          
                    return null;
                  },
                ),
              ],
            ),
          ),
        )),
        Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                color: Colors.white,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        await registerController.createAccountByEmailPassword(
                          context,
                          email: emailController.text,
                          password: passwordController.text,
                          user: User(
                            username: usernameController.text,
                            address: addrController.text,
                            email: emailController.text,
                            tel: telController.text,
                          ));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
