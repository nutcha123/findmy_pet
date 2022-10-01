import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static final String homeRoutePath = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            child: Icon(Ionicons.add),
          )),
      appBar: AppBar(
        title: Text('FIND MY PETS'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Flexible(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal : 25.0),
            child: ListView(
              children: [
              
              ],
            ),
          ))
        ],
      ),
      
    );
  }
}
