import 'dart:async';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:backdrop/backdrop.dart';
import 'faza.dart';

String ok = "";
String topText = "";
String bottomText = "";
Io.File _image;
GlobalKey _globalKey = new GlobalKey();
TextAlign textAlign = TextAlign.left;
FontWeight memeWeight = FontWeight.bold;
FontWeight topmemeWeight = FontWeight.bold;
FontWeight bottommemeWeight = FontWeight.bold;
FontStyle memeStyle = FontStyle.normal;
FontStyle topmemeStyle = FontStyle.normal;
FontStyle bottommemeStyle = FontStyle.normal;
double memeSize = 5;
double topmemeSize = 5;
double bottommemeSize = 5;

class TheMemeClass extends StatefulWidget {
  @override
  TheMemeState createState() => new TheMemeState();
}

class TheMemeState extends State<TheMemeClass> {
  @override
  void initState() {
    _image = null;
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    Column meme = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ok != ""
            ? new Text(
                ok,
                maxLines: null,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: memeSize,
                    color: Colors.black,
                    fontWeight: memeWeight,
                    fontStyle: memeStyle),
              )
            : Container(),
        _image == null
            ? new Container()
            : new Padding(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0, top: 20.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      child: new Image.file(
                        _image,
                        width: MediaQuery.of(context).size.width,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    Positioned(
                      child: Text(
                        topText,
                        textAlign: TextAlign.center,
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
                          ],
                        ),
                      ),
                      top: 5,
                      width: MediaQuery.of(context).size.width - 20,
                    ),
                    Positioned(
                      child: Text(
                        bottomText,
                        textAlign: TextAlign.center,
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
                          ],
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 20,
                      bottom: 5,
                    )
                  ],
                ),
              )
      ],
    );
    SingleChildScrollView theMeme = new SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: new Padding(
          padding: EdgeInsets.all(10.0),
          child: meme,
        ),
      ),
    );
    return theMeme;
  }
}

class MemeCreator extends StatelessWidget {
  ThemeData theme;
  MemeCreator({this.theme});
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Meme App',
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(title: 'Meme App'),
      theme: theme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      actions: <Widget>[
        new IconButton(
          tooltip: "Perview",
          icon: new Icon(
            Icons.photo,
            color: Colors.white,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SavePage(
                        memeText: ok,
                        topText: topText,
                        bottomText: bottomText,
                        image: _image,
                        textAlign: textAlign,
                        memeStyle: memeStyle,
                        topmemeStyle: topmemeStyle,
                        bottommemeStyle: bottommemeStyle,
                        memeWeight: memeWeight,
                        topmemeWeight: topmemeWeight,
                        bottommemeWeight: bottommemeWeight,
                        memeSize: memeSize,
                        topmemeSize: topmemeSize,
                        bottommemeSize: bottommemeSize,
                      )),
            );
          },
        )
      ],
      frontLayer: TheMemeClass(),
      backLayer: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 40),
        child: ListView(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[850],
                child: new Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new FlatButton.icon(
                          icon: new Icon(
                            Icons.add_to_photos,
                            color: Theme.of(context).accentColor,
                            size: 50.0,
                          ),
                          label: new Text(
                            "Pick a Photo",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            getImageGallery();
                          },
                        ),
                        new Padding(padding: EdgeInsets.only(top: 20.0)),
                        new FlatButton.icon(
                          icon: new Icon(
                            Icons.add_a_photo,
                            color: Theme.of(context).accentColor,
                            size: 50.0,
                          ),
                          label: new Text(
                            "Snap a Photo",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            getImageCamera();
                          },
                        ),
                        new Padding(padding: EdgeInsets.only(top: 20.0)),
                        new FlatButton.icon(
                          icon: new Icon(
                            Icons.close,
                            color: Theme.of(context).accentColor,
                            size: 50.0,
                          ),
                          label: new Text(
                            "Delete the Photo",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[850],
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Main meme text:",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(color: Colors.white),
                      enabled: true,
                      maxLines: null,
                      cursorColor: Colors.white,
                      onChanged: (bb) {
                        setState(() {
                          ok = bb;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    Text(
                      "Top meme text:",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(color: Colors.white),
                      enabled: true,
                      maxLines: null,
                      cursorColor: Colors.white,
                      onChanged: (bb) {
                        setState(() {
                          topText = bb;
                          topText = topText.toUpperCase();
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    Text(
                      "Bottom meme text:",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(color: Colors.white),
                      enabled: true,
                      maxLines: null,
                      cursorColor: Colors.white,
                      onChanged: (bb) {
                        setState(() {
                          bottomText = bb;
                          bottomText = bottomText.toUpperCase();
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[850],
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Main Meme Text Size: " + memeSize.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.white70,
                      value: memeSize,
                      min: 0,
                      max: 80,
                      divisions: 16,
                      onChangeStart: (ok) {
                        setState(() {
                          memeSize = ok;
                          print(memeSize);
                        });
                      },
                      onChangeEnd: (ok) {
                        setState(() {
                          memeSize = ok;
                          print(memeSize);
                        });
                      },
                      onChanged: (ok) {
                        setState(() {
                          memeSize = ok;
                          print(memeSize);
                        });
                      },
                    ),
                    Text(
                      "Top Meme Text Size: " + topmemeSize.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.white70,
                      value: topmemeSize,
                      min: 0,
                      max: 80,
                      divisions: 16,
                      onChangeStart: (ok) {
                        setState(() {
                          topmemeSize = ok;
                          print(memeSize);
                        });
                      },
                      onChangeEnd: (ok) {
                        setState(() {
                          topmemeSize = ok;
                          print(topmemeSize);
                        });
                      },
                      onChanged: (ok) {
                        setState(() {
                          topmemeSize = ok;
                          print(topmemeSize);
                        });
                      },
                    ),
                    Text(
                      "Bottom Meme Text Size: " + bottommemeSize.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.white70,
                      value: bottommemeSize,
                      min: 0,
                      max: 80,
                      divisions: 16,
                      onChangeStart: (ok) {
                        setState(() {
                          bottommemeSize = ok;
                          print(bottommemeSize);
                        });
                      },
                      onChangeEnd: (ok) {
                        setState(() {
                          bottommemeSize = ok;
                          print(bottommemeSize);
                        });
                      },
                      onChanged: (ok) {
                        setState(() {
                          bottommemeSize = ok;
                          print(bottommemeSize);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[850],
                padding: EdgeInsets.all(5),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      "Main Meme Text Style:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SwitchListTile(
                      value: memeStyle == FontStyle.italic ? true : false,
                      title: Text(
                        "Italic",
                        style: TextStyle(color: Colors.white),
                      ),
                      onChanged: (ok) {
                        setState(() {
                          ok == true
                              ? memeStyle = FontStyle.italic
                              : memeStyle = FontStyle.normal;
                          print(memeStyle);
                        });
                      },
                    ),
                    Text(
                      "Top Meme Text Style:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SwitchListTile(
                      value: topmemeStyle == FontStyle.italic ? true : false,
                      title: Text(
                        "Italic",
                        style: TextStyle(color: Colors.white),
                      ),
                      onChanged: (ok) {
                        setState(() {
                          ok == true
                              ? topmemeStyle = FontStyle.italic
                              : topmemeStyle = FontStyle.normal;
                          print(topmemeStyle);
                        });
                      },
                    ),
                    Text(
                      "Bottom Meme Text Style:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SwitchListTile(
                      value: bottommemeStyle == FontStyle.italic ? true : false,
                      title: Text(
                        "Italic",
                        style: TextStyle(color: Colors.white),
                      ),
                      onChanged: (ok) {
                        setState(() {
                          ok == true
                              ? bottommemeStyle = FontStyle.italic
                              : bottommemeStyle = FontStyle.normal;
                          print(bottommemeStyle);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[850],
                padding: EdgeInsets.all(5),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      "Main Meme Text Weight:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SwitchListTile(
                      value: memeWeight == FontWeight.bold ? true : false,
                      title: Text(
                        "Bold",
                        style: TextStyle(color: Colors.white),
                      ),
                      onChanged: (ok) {
                        setState(() {
                          ok == true
                              ? memeWeight = FontWeight.bold
                              : memeWeight = FontWeight.normal;
                          print(memeWeight);
                        });
                      },
                    ),
                    Text(
                      "Top Meme Text Weight:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SwitchListTile(
                      value: topmemeWeight == FontWeight.bold ? true : false,
                      title: Text(
                        "Bold",
                        style: TextStyle(color: Colors.white),
                      ),
                      onChanged: (ok) {
                        setState(() {
                          ok == true
                              ? topmemeWeight = FontWeight.bold
                              : topmemeWeight = FontWeight.normal;
                          print(topmemeWeight);
                        });
                      },
                    ),
                    Text(
                      "Bottom Meme Text Weight:",
                      style: TextStyle(color: Colors.white),
                    ),
                    SwitchListTile(
                      value: bottommemeWeight == FontWeight.bold ? true : false,
                      title: Text(
                        "Bold",
                        style: TextStyle(color: Colors.white),
                      ),
                      onChanged: (ok) {
                        setState(() {
                          ok == true
                              ? bottommemeWeight = FontWeight.bold
                              : bottommemeWeight = FontWeight.normal;
                          print(bottommemeWeight);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[850],
                padding: EdgeInsets.all(5),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      "Text Alignment:",
                      style: TextStyle(color: Colors.white),
                    ),
                    RadioListTile(
                      title: Text("Left"),
                      groupValue: 2,
                      value: TextAlign.left,
                      selected: textAlign == TextAlign.left ? true : false,
                      onChanged: (x) {
                        setState(() {
                          textAlign = x;
                          print(textAlign);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Center"),
                      groupValue: 2,
                      value: TextAlign.center,
                      selected: textAlign == TextAlign.center ? true : false,
                      onChanged: (x) {
                        setState(() {
                          textAlign = x;
                          print(textAlign);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Right"),
                      groupValue: 2,
                      value: TextAlign.right,
                      selected: textAlign == TextAlign.right ? true : false,
                      onChanged: (x) {
                        setState(() {
                          textAlign = x;
                          print(textAlign);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
          ],
        ),
      ),
      title: Text(
        "Meme Creator",
        style: TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
