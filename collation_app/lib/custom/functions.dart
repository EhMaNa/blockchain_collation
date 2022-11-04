import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:collation_app/models/users.dart';
import 'package:collation_app/custom/global.dart';

// My custom functions

dynamic getCollation(String category, bool add) async {
  try {
    var response = await Dio().get(
        'http://localhost:3000/collation/$category?ID=${currentUser.area}');
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

User validateUser(String area, String pass) {
  List<User> users = [
    User(1, 'Legon A', 'awesomeA', 'pOfficer'),
    User(2, 'Legon B', 'awesomeM', 'pOfficer'),
    User(3, 'Legon', 'awesome', 'cOfficer'),
    User(4, 'Legon A', 'awesomeR', 'Party'),
    User(5, 'Legon B', 'awesomeE', 'Party'),
  ];
  User controller = User(1234, '', '', '');
  for (int i = 0; i < users.length; i++) {
    if (users[i].area == area && users[i].password == pass) {
      controller = users[i];
    }
  }
  return controller;
}
