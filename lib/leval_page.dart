import 'package:flutter/material.dart';
import 'package:split_puzzal/page_three_by_three.dart';

import 'leval_page_four.dart';
import 'main.dart';

class leval_page extends StatefulWidget {
  const leval_page({Key? key}) : super(key: key);

  @override
  State<leval_page> createState() => _leval_pageState();
}

class _leval_pageState extends State<leval_page> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("myimg/background images.jpg"),fit: BoxFit.fill)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Three_by_Three();
                    },));
                  },
                    child: Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(
                        "3 * 3",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 5),
                          borderRadius: BorderRadius.circular(10),gradient: LinearGradient(colors: <Color>[
                        //Color(0xff1f005c),
                        //Color(0xff5b0060),
                        Color(0xff870160),
                        Color(0xffac255e),
                        Color(0xffca485c),
                        Color(0xffe16b5c),
                        Color(0xfff39060),
                        Color(0xffffb56b),
                      ],)),
                    ),
                  ),
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return four();
                    },));
                  },
                    child: Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(
                        "4 * 4",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 5),
                          borderRadius: BorderRadius.circular(10),gradient: LinearGradient(colors: <Color>[
                        //Color(0xff1f005c),
                        //Color(0xff5b0060),
                        Color(0xff870160),
                        Color(0xffac255e),
                        Color(0xffca485c),
                        Color(0xffe16b5c),
                        Color(0xfff39060),
                        Color(0xffffb56b),
                      ],)),
                    ),
                  ),
                ],

              ),


            ],
          ),
        ),
      ),

    ), onWillPop: () async{
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text("You want to exit???"),
          actions: [TextButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return Split_puzzal();
            },));
          }, child: Text("Yes")),

            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("No"))],
        );
      },);
      return true;
    },);
  }
}
