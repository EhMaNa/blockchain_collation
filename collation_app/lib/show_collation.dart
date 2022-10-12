// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/mini_database.dart';

class Show extends StatefulWidget {
  const Show({Key? key}) : super(key: key);

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  void initState() {
    super.initState();
    getCollation().then((value) {
      setState(() {
        if (value != null) value.forEach((item) => use.add(item));
      });
      //realColl = getCollation();
      print(use.runtimeType);
      print(use);
    });
  }

  List use = [];
  dynamic getCollation() async {
    try {
      var response = await Dio().get('http://localhost:3000/collation');
      List list = response.data.toList();
      //print(response.data.runtimeType);
      //print(list.runtimeType);
      //print(list);
      List<Widget> wid = [];
      for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < list[i]['candidates'].length; j++) {
          //print(param[j]['candidates'].length);
          //print(param[i]['candidates'][j]);
          wid.add(ListTile(
            title: Text(list[i]['candidates'][j]['name']),
            trailing: Text(list[i]['candidates'][j]['voteCount']),
          ));
        }
        wid.add(const Divider(thickness: 7.0));
      }
      //print(wid.runtimeType);
      //print(wid);
      return wid.toList();

      //return list;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collations'),
      ),
      body: ListView.builder(
        itemCount: use.length,
        itemBuilder: (context, index) {
          return Container(
            child: use[index],
          );
          /*ListTile(
            title: Text(realColl[index]['candidates'][index]['name']),
            trailing: SizedBox(height: 20, child: Text('sd')),
          );*/
        },
      ),
    );
  }
}

dynamic display(List param) {
  List<Widget> wid = [];
  for (int i = 0; i < param.length; i++) {
    for (int j = 0; j < param[i]['candidates'].length; j++) {
      //print(param[j]['candidates'].length);
      //print(param[i]['candidates'][j]);
      wid.add(ListTile(
        title: Text(param[i]['candidates'][j]['name']),
        trailing: Text(param[i]['candidates'][j]['voteCount']),
      ));
    }
    wid.add(const Divider(thickness: 7.0));
  }
  return wid;
}
