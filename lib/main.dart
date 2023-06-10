import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'leval_page.dart';


void main() {
  runApp(MaterialApp(
    home: Split_puzzal(),
    debugShowCheckedModeBanner: false,
  ));
}

class Split_puzzal extends StatefulWidget {
  const Split_puzzal({Key? key}) : super(key: key);

  @override
  State<Split_puzzal> createState() => _Split_puzzalState();
}

class _Split_puzzalState extends State<Split_puzzal> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_permission();

  }
  get_permission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
          Permission.storage,
    ].request();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.mirror,
            colors: <Color>[
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(onTap: () {
                    print("Hello");
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return leval_page();
                    },));
                  },
                    child: Container(
                      height: 100,
                      width: 300,
                      alignment: Alignment.center,
                      child: Text(
                        "Play Game",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 50),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 5),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
