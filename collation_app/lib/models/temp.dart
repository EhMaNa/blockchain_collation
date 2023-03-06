import 'dart:io';
import 'package:dio/dio.dart';
import 'package:collation_app/custom/global.dart';
import 'package:flutter/material.dart';

/*
import 'dart:convert';*/

class CandidateProvider extends ChangeNotifier {
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
    await Dio().post('http://localhost:3000/collation/$category',
        data: {'candidates': list, 'ID': currentUser.area},
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        }));
    statCode = 200;
  }

  Future<void> fetchTally(String url) async {
    try {
      var response = await Dio().get(
          'http://localhost:3000/collation/tally/$url?ID=${currentUser.area}');
      List list = response.data.toList();
      List<Widget> wid = [];
      for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < list[i]['candidates'].length; j++) {
          collect.add(ListTile(
            title: Text(list[i]['candidates'][j]['name']),
            trailing: Text(list[i]['candidates'][j]['voteCount']),
          ));
        }
        colate = list[i]['candidates'];
        collect.add(Text('Approved: ${list[i]['Approved']}'));
        collect.add(const Divider(thickness: 7.0));
      }
      notifyListeners();

      //return list;
    } catch (e) {
      print(e);
      print('not workingg');
    }
  }
}
