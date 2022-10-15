import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
/*
import 'dart:convert';*/

class Temporary extends ChangeNotifier {
  List routines = [];
  List title = [];
  List collect = [];

  void addCandidate(Map candidate) {
    routines.add(candidate);
    notifyListeners();
  }

  void removeCandidate(int index) {
    routines.removeAt(index);
    notifyListeners();
  }

  Future<void> submit(String type, List list) async {
    var response = await Dio().post('http://localhost:3000/collation/${type}',
        data: {'candidates': list},
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        }));

    /*await post(url, body: json.encode({'Name': one,"text": list}), headers: {'Content-type': 'application/json'});
     var response = await get(url);
     List data = jsonDecode(response.body);
     title.clear();
     collect.clear();
     data.forEach((element) {
       title.add(element['Name']);
       collect.add(element['text']);
     });*/
  }

  /*Future<void> fetch(String url) async{
   var response = await get(url);
   List data = jsonDecode(response.body);
   title.clear();
   collect.clear();
   data.forEach((element) {
     title.add(element['Name']);
     collect.add(element['text']);
   });


 }*/

}
