import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:collation_app/custom/global.dart';

/*
import 'dart:convert';*/

class Temporary extends ChangeNotifier {
  List routines = [];
  List title = [];
  List collect = [];
  int statCode = 200;

  void addCandidate(Map candidate) {
    routines.add(candidate);
    notifyListeners();
  }

  void removeCandidate(int index) {
    routines.removeAt(index);
    notifyListeners();
  }

  Future<void> submit(String category, List list) async {
    var response = await Dio().post('http://localhost:3000/collation/$category',
        data: {'candidates': list, 'ID': currentUser.area},
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        }));
    statCode = 200;
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
