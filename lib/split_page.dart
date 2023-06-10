import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imgpkg;
import 'package:permission_handler/permission_handler.dart';
import 'package:split_puzzal/data.dart';
import 'package:split_puzzal/page_three_by_three.dart';


class Split_page extends StatefulWidget {
  int index;

  Split_page(this.index);

  @override
  State<Split_page> createState() => _Split_pageState();
}

class _Split_pageState extends State<Split_page> {
  List<imgpkg.Image> mylist = [];
  bool tamp = true;
  List<bool> tamp1 = [];
  List img_list=[];
  List img_list1=[];
  bool ori=false;

  List<imgpkg.Image> splitImage(imgpkg.Image inputImage,
      int horizontalPieceCount, int verticalPieceCount) {
    imgpkg.Image image = inputImage;

    final pieceWidth = (image.width / horizontalPieceCount).round();
    final pieceHeight = (image.height / verticalPieceCount).round();
    final pieceList = List<imgpkg.Image>.empty(growable: true);
    var x = 0, y = 0;

    for (int i = 0; i < horizontalPieceCount; i++) {
      for (int j = 0; j < verticalPieceCount; j++) {
        pieceList.add(imgpkg.copyCrop(image,
            x: x, y: y, width: pieceWidth, height: pieceHeight));
        x = x + pieceWidth;
      }
      y = y + pieceHeight;
      x = 0;
    }

    return pieceList;
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('myimg/$path');
    var dis_path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS) +
        "/SplitPhoto";
    Directory dir = Directory(dis_path);
    if (!await dir.exists()) {
      dir.create();
    }

    final file = File('${(dir.path)}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    print(file.path);

    return file;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getImageFileFromAssets("${data.three_by_three[widget.index]}")
        .then((value) {
      imgpkg.Image? myimg = imgpkg.decodeJpg(value.readAsBytesSync());
      mylist = splitImage(myimg!, 3, 3);
      for(int i=0;i<mylist.length;i++)
        {
          img_list.add(Image.memory(imgpkg.encodeJpg(mylist[i]),fit: BoxFit.fill,height: 100,width: 100,));
        }
      img_list1.addAll(img_list);
      img_list.shuffle();
      tamp = true;
      tamp1 = List.filled(img_list.length, true);
      setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: OrientationBuilder(builder: (context, orientation) {
      if(Orientation.portrait==orientation)
        {
           SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

          ori=true;

        }else{
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
          SystemUiOverlay.bottom
        ]);
        ori =false;
      }

      return Scaffold(
        body: (tamp)
            ? GridView.builder(
          itemCount: img_list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (ori)?3:4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return (tamp1[index])?Draggable( data: index,
                onDragStarted: () {

                  tamp1=List.filled(img_list.length, false);
                  tamp1[index]=true;
                  setState(() {});

                },onDragEnd: (details) {
                  print("End");
                  tamp1=List.filled(img_list.length, true);

                  setState(() {});
                },
                child: img_list[index],
                feedback: img_list[index])
                :
            // ignore: avoid_types_as_parameter_names
            DragTarget(onAccept: (data) {
              print("Target");

              var str_img=img_list[data as int];
              img_list[data as int ]=img_list[index];
              img_list[index]=str_img;


              if(listEquals(img_list, img_list1))
              {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(title: Text("You are win"),
                    actions: [TextButton(onPressed: () {
                      if(index < data.toString().length)
                      {
                        widget.index++;
                      }setState(() {});
                      Navigator.push(context,MaterialPageRoute(builder: (context) {
                        return Three_by_Three();
                      },));
                    }, child: Text("OK"))],
                  );
                },);
              }

              setState(() {});
            },builder: (context, candidateData, rejectedData) {
              return  img_list[index];
            },);
          },
        )
            : null,
      );
    },), onWillPop: () async{
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text("You want to exit???"),
        actions: [TextButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return Three_by_Three();
          },));
        }, child: Text("Yes")),

          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("No"))],
        );
      },);
      return true;
    },
        );

  }
}
