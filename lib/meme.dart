import 'dart:async';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:backdrop/backdrop.dart';
import 'faza.dart';
import 'memegen_bloc.dart';

String ok = "";
String IMAGE_TYPE;
String topText = "";
String bottomText = "";
String memeTag = "";
Io.File _image;
String _imageNetwork;
GlobalKey _globalKey = GlobalKey();
TextAlign textAlign = TextAlign.left;
TextDirection maintextDirection = TextDirection.ltr;
TextDirection bottomtextDirection = TextDirection.ltr;
TextDirection toptextDirection = TextDirection.ltr;
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
  TheMemeState createState() => TheMemeState();
}

class TheMemeState extends State<TheMemeClass> {
  @override
  void initState() {
    super.initState();
    _image = null;
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      IMAGE_TYPE = 'FILE';
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      IMAGE_TYPE = 'FILE';
    });
  }

  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    Column meme = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ok != ""
            ? Text(
                ok,
                maxLines: null,
                textAlign: textAlign,
                textDirection: maintextDirection,
                style: TextStyle(
                    fontSize: memeSize,
                    color: Colors.black,
                    fontWeight: memeWeight,
                    fontStyle: memeStyle),
              )
            : Container(),
        IMAGE_TYPE == null
            ? Container()
            : Padding(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0, top: 20.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      child: IMAGE_TYPE == 'FILE'
                          ? Image.file(
                              _image,
                              width: MediaQuery.of(context).size.width,
                            )
                          : Image.network(
                              _imageNetwork,
                              width: MediaQuery.of(context).size.width,
                            ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    Positioned(
                      child: Text(
                        topText,
                        textAlign: TextAlign.center,
                        textDirection: toptextDirection,
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
                        textDirection: bottomtextDirection,
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
    SingleChildScrollView theMeme = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: meme,
        ),
      ),
    );
    return theMeme;
  }
}

class MemeCreator extends StatelessWidget {
  MemeCreator({this.theme});
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Meme App'),
      theme: theme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MemegenBloc memegenBloc;
  StreamBuilder<List<String>> memeStreamBuilder;
  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      IMAGE_TYPE = 'FILE';
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      IMAGE_TYPE = 'FILE';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memegenBloc = MemegenBloc();
    memeStreamBuilder = StreamBuilder<List<String>>(
      stream: memegenBloc.memeStream,
      initialData: [],
      builder: (cont, snap) {
        if (snap.hasError)
          return Center(
            child: Text("Error:${snap.error}"),
          );
        else if (snap.hasData) {
          print(snap.data.toString());
          return ListView.builder(
            itemCount: snap.data.length >= 100 ? 101 : snap.data.length + 1,
            itemBuilder: (cont, index) {
              return index == 0
                  ? Material(
                      color: Colors.white,
                      child: TextField(
                        onChanged: (tag) {
                          memeTag = tag;
                          memegenBloc.sinkMemeTag(memeTag);
                        },
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(3),
                      child: snap.data[index - 1] != 'error'
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    IMAGE_TYPE = 'NETWORK';
                                    _imageNetwork = snap.data[index - 1];
                                    _image = null;
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    snap.data[index - 1],
                                    fit: BoxFit.cover,
                                    height: 100,
                                  ),
                                ),
                              ),
                            )
                          : Material(
                              child: Center(
                                child: Text(
                                  "ERROR",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ));
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _alertDialog() {
    memegenBloc.sinkMemeTag("");
    showDialog(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * .07,
            MediaQuery.of(context).size.height * .07,
            MediaQuery.of(context).size.width * .07,
            MediaQuery.of(context).size.height * .07),
        child: memeStreamBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      actions: <Widget>[
        IconButton(
          tooltip: "Perview",
          icon: Icon(
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
                        topTextDirection:toptextDirection,
                        bottomText: bottomText,
                        bottomTextDirection: bottomtextDirection,
                        imageFile: _image,
                        imageNetwork: _imageNetwork,
                        imageType: IMAGE_TYPE,
                        textAlign: textAlign,
                        mainTextDirection: maintextDirection,
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(
                            Icons.add_to_photos,
                            color: Theme.of(context).accentColor,
                            size: 50.0,
                          ),
                          label: Text(
                            "Pick a Photo",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            getImageGallery();
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Theme.of(context).accentColor,
                            size: 50.0,
                          ),
                          label: Text(
                            "Snap a Photo",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            getImageCamera();
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.laptop_chromebook,
                            color: Theme.of(context).accentColor,
                            size: 50.0,
                          ),
                          label: Text(
                            "Download a Photo",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            print("download meme");
                            _alertDialog();
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).accentColor,
                            size: 50.0,
                          ),
                          label: Text(
                            "Delete the Photo",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _image = null;
                              _imageNetwork = null;
                              IMAGE_TYPE = null;
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
                      textDirection: maintextDirection,
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
                      textDirection: toptextDirection,
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
                      textDirection: bottomtextDirection,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[850],
                padding: EdgeInsets.all(5),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      "Main Text Direction:",
                      style: TextStyle(color: Colors.white),
                    ),
                    RadioListTile(
                      title: Text("Left to Right"),
                      groupValue: 2,
                      value: TextDirection.ltr,
                      selected:
                          maintextDirection == TextDirection.ltr ? true : false,
                      onChanged: (x) {
                        setState(() {
                          maintextDirection = x;
                          print(maintextDirection);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Right to Left"),
                      groupValue: 2,
                      value: TextDirection.rtl,
                      selected:
                          maintextDirection == TextDirection.rtl ? true : false,
                      onChanged: (x) {
                        setState(() {
                          maintextDirection = x;
                          print(maintextDirection);
                        });
                      },
                    ),
                    Text(
                      "Top Text Direction:",
                      style: TextStyle(color: Colors.white),
                    ),
                    RadioListTile(
                      title: Text("Left to Right"),
                      groupValue: 2,
                      value: TextDirection.ltr,
                      selected:
                          toptextDirection == TextDirection.ltr ? true : false,
                      onChanged: (x) {
                        setState(() {
                          toptextDirection = x;
                          print(toptextDirection);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Right to Left"),
                      groupValue: 2,
                      value: TextDirection.rtl,
                      selected:
                          toptextDirection == TextDirection.rtl ? true : false,
                      onChanged: (x) {
                        setState(() {
                          toptextDirection = x;
                          print(toptextDirection);
                        });
                      },
                    ),
                    Text(
                      "Bottom Text Direction:",
                      style: TextStyle(color: Colors.white),
                    ),
                    RadioListTile(
                      title: Text("Left to Right"),
                      groupValue: 2,
                      value: TextDirection.ltr,
                      selected:
                          bottomtextDirection == TextDirection.ltr ? true : false,
                      onChanged: (x) {
                        setState(() {
                          bottomtextDirection = x;
                          print(bottomtextDirection);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Right to Left"),
                      groupValue: 2,
                      value: TextDirection.rtl,
                      selected:
                          bottomtextDirection == TextDirection.rtl ? true : false,
                      onChanged: (x) {
                        setState(() {
                          bottomtextDirection = x;
                          print(bottomtextDirection);
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
