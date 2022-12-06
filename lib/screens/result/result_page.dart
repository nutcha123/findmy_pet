import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:project/components/widget/result_tile.dart';
import 'package:project/controller/mypet_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResultPage extends StatefulWidget {
  final String token;
  final VoidCallback? callback;
  const ResultPage({super.key, this.callback, required this.token});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String uid = "";
  var contact;
  initialAction() async {
    final MyPetController myPetController = Get.find<MyPetController>();

    final data = Jwt.parseJwt(widget.token);
    print(data['user_id']);
    contact = await myPetController.findUserByUid(data['user_id']);
    setState(() {
      uid = data['user_id'];
    });
  }

  @override
  void initState() {
    super.initState();
    initialAction();
  }

  @override
  Widget build(BuildContext context) {
    MyPetController myPetController = Get.find<MyPetController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(myPetController.searchResult.name.toString()),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              widget.callback!();
              Get.back();
            },
            icon: Icon(Icons.chevron_left)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 50.w,
              height: 50.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                    myPetController.searchResult.imageUrl.toString(),
                    fit: BoxFit.cover),
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  
                  ResultTile(
                    leading: Text("Pet's Name"),
                    trailing:
                        Text(myPetController.searchResult.name.toString()),
                  ),
                  ResultTile(
                    leading: Text("Age"),
                    trailing: Text(myPetController.searchResult.age.toString()),
                  ),
                  ResultTile(
                    leading: Text("Breed"),
                    trailing:
                        Text(myPetController.searchResult.breed.toString()),
                  ),
                  ResultTile(
                    leading: Text("Gender"),
                    trailing:
                        Text(myPetController.searchResult.gender.toString()),
                  ),
                  ResultTile(
                    leading: Text("Personality"),
                    trailing: Text(
                        myPetController.searchResult.personalize.toString()),
                  ),
                  // ResultTile(
                  //   leading: Text("Clinical Info"),
                  //   trailing: Column(
                  //     children: myPetController.searchResult.clinicInfo!
                  //         .map((e) => Text(e))
                  //         .toList(),
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    alignment: Alignment.center,
                    child: Text('Contact Detail' , style: TextStyle(fontSize : 18 ,fontWeight: FontWeight.w600,letterSpacing: 1.25),),
                  ),
                  ResultTile(
                    leading: Text("Owner"),
                    trailing: Text("${contact?["username"]}"),
                  ),
                  ResultTile(
                    leading: Text("E-Mail"),
                    trailing: Text("${contact?["email"]}"),
                  ),
                  ResultTile(
                    leading: Text("Mobile No."),
                    trailing: Text("${contact?["tel"]}"),
                  ),
                  ResultTile(
                    leading: Text("Address"),
                    trailing: Text("${contact?["addr"]}"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
