import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class MemegenBloc {
  String _memegenPath = "https://memegen.link/api/search/";
  List<String> _memeArray = [];
  StreamController<List<String>> _streamController =
      StreamController<List<String>>.broadcast();
  Stream<List<String>> get memeStream => _streamController.stream;
  StreamSink<List<String>> get sinkStream => _streamController.sink;

  MemegenBloc() {
    _fetchData(_memegenPath).whenComplete(() {
      _streamController.sink.add(_memeArray);
      print(_memeArray.toString());
    });
  }

  Future _fetchData(String fetchPath) async {
    var client = http.Client();
    http.Response response;
    var responseBody = [];
    List<String> result = [];
    try {
      response = await client.get(fetchPath);
      responseBody = jsonDecode(response.body);
    } catch (e) {
      if(responseBody.length ==0)
        responseBody.add({'template':{'blank':'error'}});
    }
    for (var element in responseBody) {
      result.add(element['template']['blank']);
    }
    _memeArray = result;
  }

  sinkMemeTag(String tag) {
    _fetchData(_memegenPath + tag).whenComplete(() {
      _streamController.sink.add(_memeArray);
    });
  }

  dispose() {
    _streamController.close();
  }
}
