//Keep global variables and functions
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

dynamic getCollation(String category, bool add) async {
  try {
    var response =
        await Dio().get('http://localhost:3000/collation/$category?ID=$ID');
    List list = response.data.toList();
    List<Widget> wid = [];
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list[i]['candidates'].length; j++) {
        wid.add(ListTile(
          title: Text(list[i]['candidates'][j]['name']),
          trailing: Text(list[i]['candidates'][j]['voteCount']),
        ));
      }
      if (add) {
        var app = list[i]['Approved'];
        wid.add(Text(list[i]['ID']));
        wid.add(const SizedBox(
          height: 8,
        ));
        wid.add(Text('Approved: $app'));
        wid.add(const Divider(thickness: 7.0));
      } else {
        wid.add(const Divider(thickness: 7.0));
      }
    }
    return wid.toList();

    //return list;
  } catch (e) {
    print('not workingg');
  }
}

String level = '';
String ID = '';
String ID1 = 'Legon A';
String ID2 = 'Legon B';
String ID3 = 'Legon';
String password1 = 'awesomeR';
String password2 = 'awesomeE';
String password3 = 'awesomeA';
String password4 = 'awesomeM';
String password5 = 'Officer';
