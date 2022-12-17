import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:collation_app/models/users.dart';
import 'package:collation_app/custom/global.dart';

// My custom functions

//function to get collation
dynamic getCollation(String category, String add) async {
  try {
    var response = await Dio().get(
        'http://localhost:3000/collation/$category?ID=${currentUser.area}&add=$add');
    List list = response.data.toList();
    List<Widget> wid = [];
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list[i]['candidates'].length; j++) {
        wid.add(ListTile(
          title: Text(list[i]['candidates'][j]['name']),
          trailing: Text(list[i]['candidates'][j]['voteCount']),
        ));
      }
      if (add == 'yes') {
        var app = list[i]['Approved'];
        wid.add(Text(list[i]['ID']));
        wid.add(const SizedBox(
          height: 12,
        ));
        wid.add(Text('Approved: $app'));
        wid.add(const Divider(thickness: 7.0));
      } else if (add == 'never') {
        wid.add(const Divider(thickness: 7.0));
      } else {
        wid.add(Text('Approved: ${list[i]['Approved']}'));
        wid.add(const Divider(thickness: 7.0));
      }
    }
    return wid.toList();

    //return list;
  } catch (e) {
    print('not workingg');
  }
}

// function for creation and validation of users
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

// function for dialogg boxes
Future<dynamic> chooseDialog(BuildContext context, Function() onParlimentary,
    Function() onPresidential) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Choose an Option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: onParlimentary,
              child: const Text('Parlimentary'),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: onPresidential, child: const Text('Presidential')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
