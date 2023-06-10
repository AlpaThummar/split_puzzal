import 'package:flutter/material.dart';
import 'package:split_puzzal/data.dart';
import 'package:split_puzzal/leval_page.dart';
import 'package:split_puzzal/split_page.dart';

import 'four_four.dart';

class four extends StatefulWidget {
  const four({Key? key}) : super(key: key);

  @override
  State<four> createState() => _four();
}

class _four extends State<four> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return fourbyfour(index);
                  },));
                },
                  child: Container(
                    height: 500,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(),
                        image: DecorationImage(
                            image: AssetImage("myimg/${data.three_by_three[index]}"),
                            fit: BoxFit.fill)),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.cyan,
                );
              },
              itemCount: data.three_by_three.length),
        )), onWillPop: () async{
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text("You want to exit???"),
          actions: [TextButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return leval_page();
            },));
          }, child: Text("Yes")),

            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("No"))],
        );
      },);
      return true;
    }, );
  }
}
