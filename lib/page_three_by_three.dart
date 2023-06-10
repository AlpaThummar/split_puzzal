import 'package:flutter/material.dart';
import 'package:split_puzzal/data.dart';
import 'package:split_puzzal/leval_page.dart';
import 'package:split_puzzal/split_page.dart';

class Three_by_Three extends StatefulWidget {
  const Three_by_Three({Key? key}) : super(key: key);

  @override
  State<Three_by_Three> createState() => _Three_by_ThreeState();
}

class _Three_by_ThreeState extends State<Three_by_Three> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Split_page(index);
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
