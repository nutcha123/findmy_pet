import 'package:flutter/material.dart';
import 'package:project/style/style.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Column(children: [
        SizedBox(
          height: 25,
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: ListView(
            children: [
              TextFormField(
                decoration: textFormStyle.copyWith(hintText: 'Username'),
              ),
              TextFormField(
                decoration: textFormStyle.copyWith(hintText: 'E-Mail'),
              ),
              TextFormField(
                decoration: textFormStyle.copyWith(hintText: 'Telphone No.'),
              ),
              TextFormField(
                maxLines: 5,
                decoration: textFormStyle.copyWith(
                  hintText: 'Address',
                ),
              ),
              TextFormField(
                decoration: textFormStyle.copyWith(hintText: 'Password'),
              ),
              TextFormField(
                decoration:
                    textFormStyle.copyWith(hintText: 'Confirm Password'),
              ),
            ],
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
                    onPressed: () {},
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
