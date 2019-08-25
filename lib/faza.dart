import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as Io;
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_permissions/simple_permissions.dart';

Permission permission;

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();

  return directory.path;
}

class SavePage extends StatelessWidget {
  final String memeText, topText, bottomText,imageType,imageNetwork;
  final Io.File imageFile;
  final TextAlign textAlign;
  final TextDirection mainTextDirection,topTextDirection, bottomTextDirection;
  final FontWeight memeWeight, topmemeWeight, bottommemeWeight;
  final FontStyle memeStyle, topmemeStyle, bottommemeStyle;
  final double memeSize, topmemeSize, bottommemeSize;
  SavePage({
    this.memeText,
    this.topText,
    this.bottomText,
    this.memeSize,
    this.topmemeSize,
    this.bottommemeSize,
    this.imageType,
    this.imageFile,
    this.imageNetwork,
    this.textAlign,
    this.mainTextDirection,
    this.topTextDirection,
    this.bottomTextDirection,
    this.memeStyle,
    this.topmemeStyle,
    this.bottommemeStyle,
    this.memeWeight,
    this.topmemeWeight,
    this.bottommemeWeight,
  });

  Widget build(BuildContext context) {
    var perview =  Container(
        color: Colors.white,
        child:  Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              memeText != "" && memeText != " "
                  ? Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      memeText,
                      textAlign: textAlign,
                      textDirection: mainTextDirection,
                      style: TextStyle(
                          fontSize: memeSize,
                          color: Colors.black,
                          fontWeight: memeWeight,
                          fontStyle: memeStyle),
                    ),
                  )
                  : Container(),
              imageType != null
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ClipRRect(
                            child:  imageType == 'FILE'?Image.file(
                              imageFile,
                              width: MediaQuery.of(context).size.width,
                            ):Image.network(
                              imageNetwork,
                              width: MediaQuery.of(context).size.width,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          Positioned(
                            child: Text(
                              topText,
                              textAlign: TextAlign.center,
                              textDirection: topTextDirection,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: topmemeStyle,
                                  fontSize: topmemeSize,
                                  fontWeight: topmemeWeight,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1.2, 1.2),
                                    ),
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(-1.2, -1.2),
                                    ),
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(-1.2, 1.2),
                                    ),
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1.2, -1.2),
                                    ),
                                  ]),
                            ),
                            top: 5,
                            width: MediaQuery.of(context).size.width - 20,
                          ),
                          Positioned(
                            child: Text(
                              bottomText,
                              textAlign: TextAlign.center,
                              textDirection: bottomTextDirection,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: bottommemeStyle,
                                  fontSize: bottommemeSize,
                                  fontWeight: bottommemeWeight,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1.2, 1.2),
                                    ),
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(-1.2, -1.2),
                                    ),
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(-1.2, 1.2),
                                    ),
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1.2, -1.2),
                                    ),
                                  ]),
                            ),
                            width: MediaQuery.of(context).size.width - 20,
                            bottom: 5,
                          )
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ));
    GlobalKey _globalKey =  GlobalKey();
    /*Future<void> _capturePng() async {
      int i = 0;
      String pathMeme = await _localPath;
      String path = pathMeme + "/Memes/";
      Io.Directory(path).create(recursive: true);
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Io.File file =  Io.File(path + "meme" + i.toString() + ".jpg");
      while (await file.exists() == true) {
        i++;
        file =  Io.File(path + "meme" + i.toString() + ".jpg");
      }
      file.create();
      print("Done Fetching");
      Uint8List pngBytes = byteData.buffer.asUint8List();
      file.writeAsBytes(pngBytes);
      file.create();
      print(pngBytes);
      print("----------------------------");
      print(file.path);
      SimplePermissions.checkPermission(Permission.WriteExternalStorage)
          .then((status) {
        if (!status)
          Fluttertoast.showToast(
              msg: "Please enable Permissions",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 3,
              bgcolor: "#686666",
              textcolor: '#ffffff');
        else
          Fluttertoast.showToast(
              msg: "Meme saved in " + file.path,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 3,
              bgcolor: "#686666",
              textcolor: '#ffffff');
      });
    }*/

    //---------------------------------------------------------------------
    _saved(Uint8List byteData) async {
      await ImageGallerySaver.save(byteData.buffer.asUint8List());
    }

    Future<void> _capturePng2() async {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 4);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      SimplePermissions.checkPermission(Permission.WriteExternalStorage)
          .then((status) {
        if (!status)
          Fluttertoast.showToast(
              msg: "Please enable Permissions",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 3,
              backgroundColor: Colors.black87,
              textColor: Colors.white);
        else {
          Fluttertoast.showToast(
              msg: "Meme saved Gallery ",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 3,
              backgroundColor: Colors.black87,
              textColor: Colors.white);
          _saved(pngBytes);
        }
      });
    }

    Future<void> _capturePng() async {
      int i = 0;
      String pathMeme = await _localPath;
      String path = pathMeme + "/Memes/";
      Io.Directory(path).create(recursive: true);
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 4);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Io.File file =  Io.File(path + "meme" + i.toString() + ".png");
      while (await file.exists() == true) {
        i++;
        file =  Io.File(path + "meme" + i.toString() + ".png");
      }
      file.create();
      print("Done Fetching");
      Uint8List pngBytes = byteData.buffer.asUint8List();
      file.writeAsBytesSync(pngBytes);
      file.create();
      print(pngBytes);
      print("----------------------------");
      print(file.path);
      SimplePermissions.checkPermission(Permission.WriteExternalStorage)
          .then((status) {
        if (!status)
          Fluttertoast.showToast(
              msg: "Please enable Permissions",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 3,
              backgroundColor: Colors.black87,
              textColor: Colors.white);
        else
          Fluttertoast.showToast(
              msg: "Meme saved in " + file.path,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 3,
              backgroundColor: Colors.black87,
              textColor: Colors.white);
      });
    }
    //----------------------------------------------------------------------

    RepaintBoundary memePerview =  RepaintBoundary(
      key: _globalKey,
      child: perview,
    );
    SingleChildScrollView finalMeme =  SingleChildScrollView(
      child: memePerview,
    );
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Save?",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        actions: <Widget>[
           IconButton(
            tooltip: "Save",
            icon:  Icon(
              Icons.save,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              if (memeText == "") {
                print("EMPTY!");
              } else {
                print(memeText);
              }
              SimplePermissions.checkPermission(Permission.WriteExternalStorage)
                  .then((status) {
                if (!status)
                  SimplePermissions.requestPermission(
                          Permission.WriteExternalStorage)
                      .whenComplete(() {
                    _capturePng2();
                  });
                else
                  _capturePng2();
              });
            },
          )
        ],
      ),
      body: finalMeme,
    );
  }
}
